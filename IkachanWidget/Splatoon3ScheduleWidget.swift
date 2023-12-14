import WidgetKit
import SwiftUI
import Intents
import Kingfisher

struct Splatoon3ScheduleProvider: IntentTimelineProvider {
    func filterSchedules(schedules: [Splatoon3Schedule], mode: INSplatoon3ScheduleMode) -> [Splatoon3Schedule] {
        return schedules.filter { schedule in
            switch mode {
            case .unknown, .regularBattle:
                return schedule._mode == .regularBattle
            case .anarchyBattleSeries:
                return schedule._mode == .anarchyBattleSeries
            case .anarchyBattleOpen:
                return schedule._mode == .anarchyBattleOpen
            case .xBattle:
                return schedule._mode == .xBattle
            case .challenges:
                return schedule._mode == .challenges
            case .splatfestBattleOpen:
                return schedule._mode == .splatfestBattleOpen
            case .splatfestBattlePro:
                return schedule._mode == .splatfestBattlePro
            case .tricolorBattle:
                return schedule._mode == .tricolorBattle
            }
        }.filter { schedule in
            schedule.endTime > Date()
        }
    }
    
    func placeholder(in context: Context) -> Splatoon3ScheduleEntry {
        Splatoon3ScheduleEntry(date: Date(), configuration: Splatoon3ScheduleIntent(), schedule: PreviewSplatoon3Schedule)
    }

    func getSnapshot(for configuration: Splatoon3ScheduleIntent, in context: Context, completion: @escaping (Splatoon3ScheduleEntry) -> ()) {
        fetchSplatoon3Schedules(locale: Locale.localizedLocale) { schedules, error in
            guard error == .NoError else {
                completion(Splatoon3ScheduleEntry(date: Date(), configuration: configuration, schedule: nil))
                
                return
            }
            
            let filtered = filterSchedules(schedules: schedules, mode: configuration.mode)
            if !filtered.isEmpty {
                var entry = Splatoon3ScheduleEntry(date: Date(), configuration: configuration, schedule: filtered.first!)
                var urls: Set<URL> = []
                for stage in filtered.first!.stages {
                    urls.insert(stage.thumbnail ?? stage.image)
                }
                if filtered.count > 1 {
                    entry.nextSchedule = filtered.at(index: 1)!
                    for stage in filtered.at(index: 1)!.stages {
                        urls.insert(stage.thumbnail ?? stage.image)
                    }
                }
                
                ImagePrefetcher(resources: urls.map({ url in
                    KF.ImageResource(downloadURL: url)
                })) { (_, _, _) in
                    completion(entry)
                }
                .start()
            } else {
                completion(Splatoon3ScheduleEntry(date: Date(), configuration: configuration, schedule: nil))
            }
        }
    }

    func getTimeline(for configuration: Splatoon3ScheduleIntent, in context: Context, completion: @escaping (Timeline<Splatoon3ScheduleEntry>) -> ()) {
        fetchSplatoon3Schedules(locale: Locale.localizedLocale) { schedules, error in
            guard error == .NoError else {
                completion(Timeline(entries: [Splatoon3ScheduleEntry(date: Date(), configuration: configuration, schedule: nil)], policy: .after(Date().addingTimeInterval(300))))
                
                return
            }
            
            var entries: [Splatoon3ScheduleEntry] = []
            var urls: Set<URL> = []
            let filtered = filterSchedules(schedules: schedules, mode: configuration.mode)
            if !filtered.isEmpty {
                for i in 0..<MaxScheduleWidgetEntryCount {
                    if filtered.count <= i {
                        break
                    }
                    var entry = Splatoon3ScheduleEntry(date: i == 0 ? Date() : filtered.at(index: i)!.startTime, configuration: configuration, schedule: filtered.at(index: i)!)
                    for stage in filtered.at(index: i)!.stages {
                        urls.insert(stage.thumbnail ?? stage.image)
                    }
                    if (filtered.count > i + 1) {
                        entry.nextSchedule = filtered.at(index: i + 1)!
                        for stage in filtered.at(index: i + 1)!.stages {
                            urls.insert(stage.thumbnail ?? stage.image)
                        }
                    }
                    entries.append(entry)
                }
                
                ImagePrefetcher(resources: urls.map({ url in
                    KF.ImageResource(downloadURL: url)
                })) { (_, _, _) in
                    completion(Timeline(entries: entries, policy: .atEnd))
                }
                .start()
            } else {
                completion(Timeline(entries: [Splatoon3ScheduleEntry(date: Date(), configuration: configuration, schedule: nil)], policy: .after(Date().addingTimeInterval(300))))
            }
        }
    }
}

struct Splatoon3ScheduleEntry: TimelineEntry {
    var date: Date
    var configuration: Splatoon3ScheduleIntent

    var schedule: Splatoon3Schedule?
    var nextSchedule: Splatoon3Schedule?
}

struct Splatoon3ScheduleWidgetEntryView : View {
    var entry: Splatoon3ScheduleProvider.Entry
    
    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        if #available(iOSApplicationExtension 16.0, *) {
            switch family {
            case .accessoryRectangular:
                if #available(iOSApplicationExtension 17.0, *) {
                    AccessoryRectangularScheduleView(schedule: entry.schedule)
                        .containerBackground(for: .widget, content: {})
                } else {
                    AccessoryRectangularScheduleView(schedule: entry.schedule)
                }
            case .systemSmall:
                if #available(iOSApplicationExtension 17.0, *) {
                    SmallScheduleView(schedule: entry.schedule, nextSchedule: entry.nextSchedule)
                        .containerBackground(for: .widget, content: {})
                } else {
                    SmallScheduleView(schedule: entry.schedule, nextSchedule: entry.nextSchedule)
                        .padding()
                }
            default:
                if #available(iOSApplicationExtension 17.0, *) {
                    MediumScheduleView(schedule: entry.schedule, nextSchedule: entry.nextSchedule)
                        .containerBackground(for: .widget, content: {})
                } else {
                    MediumScheduleView(schedule: entry.schedule, nextSchedule: entry.nextSchedule)
                        .padding()
                }
            }
        } else {
            switch family {
            case .systemSmall:
                SmallScheduleView(schedule: entry.schedule, nextSchedule: entry.nextSchedule)
                    .padding()
            default:
                MediumScheduleView(schedule: entry.schedule, nextSchedule: entry.nextSchedule)
                    .padding()
            }
        }
    }
}

struct Splatoon3ScheduleWidget: Widget {
    let kind = "Splatoon3ScheduleWidget"
    
    var supportedFamilies: [WidgetFamily] {
        if #available(iOSApplicationExtension 16.0, *) {
            return [.systemSmall, .systemMedium, .accessoryRectangular]
        } else {
            return [.systemSmall, .systemMedium]
        }
    }

    var body: some WidgetConfiguration {
        return IntentConfiguration(kind: kind, intent: Splatoon3ScheduleIntent.self, provider: Splatoon3ScheduleProvider()) { entry in
            Splatoon3ScheduleWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("splatoon_3_schedule")
        .description("splatoon_3_schedule_widget_description")
        .supportedFamilies(supportedFamilies)
    }
}

struct Splatoon3ScheduleWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        Splatoon3ScheduleWidgetEntryView(entry: Splatoon3ScheduleEntry(date: Date(), configuration: Splatoon3ScheduleIntent(), schedule: PreviewSplatoon3Schedule, nextSchedule: PreviewSplatoon3Schedule))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
