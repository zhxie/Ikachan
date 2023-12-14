import WidgetKit
import SwiftUI
import Intents

struct Splatoon2ScheduleDynamicProvider: IntentTimelineProvider {
    func filterSchedules(schedules: [Splatoon2Schedule], mode: INSplatoon2ScheduleMode) -> [Splatoon2Schedule] {
        return schedules.filter { schedule in
            switch mode {
            case .unknown, .regularBattle:
                return schedule._mode == .regularBattle
            case .rankedBattle:
                return schedule._mode == .rankedBattle
            case .leagueBattle:
                return schedule._mode == .leagueBattle
            }
        }.filter { schedule in
            schedule.endTime > Date()
        }
    }
    
    func placeholder(in context: Context) -> Splatoon2ScheduleDynamicEntry {
        Splatoon2ScheduleDynamicEntry(date: Date(), configuration: Splatoon2ScheduleIntent(), schedule: PreviewSplatoon2Schedule)
    }

    func getSnapshot(for configuration: Splatoon2ScheduleIntent, in context: Context, completion: @escaping (Splatoon2ScheduleDynamicEntry) -> ()) {
        fetchSplatoon2Schedules(locale: Locale.localizedLocale) { schedules, error in
            guard error == .NoError else {
                completion(Splatoon2ScheduleDynamicEntry(date: Date(), configuration: configuration, schedule: nil))
                
                return
            }
            
            let filtered = filterSchedules(schedules: schedules, mode: configuration.mode)
            if !filtered.isEmpty {
                completion(Splatoon2ScheduleDynamicEntry(date: Date(), configuration: configuration, schedule: filtered.first!))
            } else {
                completion(Splatoon2ScheduleDynamicEntry(date: Date(), configuration: configuration, schedule: nil))
            }
        }
    }

    func getTimeline(for configuration: Splatoon2ScheduleIntent, in context: Context, completion: @escaping (Timeline<Splatoon2ScheduleDynamicEntry>) -> ()) {
        fetchSplatoon2Schedules(locale: Locale.localizedLocale) { schedules, error in
            guard error == .NoError else {
                completion(Timeline(entries: [Splatoon2ScheduleDynamicEntry(date: Date(), configuration: configuration, schedule: nil)], policy: .after(Date().addingTimeInterval(300))))
                
                return
            }
            
            var entries: [Splatoon2ScheduleDynamicEntry] = []
            let filtered = filterSchedules(schedules: schedules, mode: configuration.mode)
            if !filtered.isEmpty {
                var current = Date().floorToMin()
                for schedule in filtered {
                    while current < schedule.endTime && entries.count < MaxDynamicWidgetEntryCount {
                        let entry = Splatoon2ScheduleDynamicEntry(date: current, configuration: configuration, schedule: schedule)
                        entries.append(entry)
                        
                        current = current.addingTimeInterval(60)
                    }
                }
                
                completion(Timeline(entries: entries, policy: .atEnd))
            } else {
                completion(Timeline(entries: [Splatoon2ScheduleDynamicEntry(date: Date(), configuration: configuration, schedule: nil)], policy: .after(Date().addingTimeInterval(300))))
            }
        }
    }
}

struct Splatoon2ScheduleDynamicEntry: TimelineEntry {
    var date: Date
    var configuration: Splatoon2ScheduleIntent

    var schedule: Splatoon2Schedule?
}

@available(iOSApplicationExtension 16.0, *)
struct Splatoon2ScheduleDynamicWidgetEntryView : View {
    var entry: Splatoon2ScheduleDynamicProvider.Entry
    
    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        if #available(iOSApplicationExtension 17.0, *) {
            AccessoryCircularView(progress: timePassingBy(current: entry.date, start: entry.schedule?.startTime ?? entry.date, end: entry.schedule?.endTime ?? entry.date), mode: entry.schedule?.mode.image ?? nil, rule: entry.schedule?.rule.image ?? nil)
                .containerBackground(for: .widget, content: {})
        } else {
            AccessoryCircularView(progress: timePassingBy(current: entry.date, start: entry.schedule?.startTime ?? entry.date, end: entry.schedule?.endTime ?? entry.date), mode: entry.schedule?.mode.image ?? nil, rule: entry.schedule?.rule.image ?? nil)
        }
    }
}

@available(iOSApplicationExtension 16.0, *)
struct Splatoon2ScheduleDynamicWidget: Widget {
    let kind = "Splatoon2ScheduleDynamicWidget"

    var body: some WidgetConfiguration {
        return IntentConfiguration(kind: kind, intent: Splatoon2ScheduleIntent.self, provider: Splatoon2ScheduleDynamicProvider()) { entry in
            Splatoon2ScheduleDynamicWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("splatoon_2_schedule")
        .description("splatoon_2_schedule_widget_description")
        .supportedFamilies([.accessoryCircular])
    }
}

@available(iOSApplicationExtension 16.0, *)
struct Splatoon2ScheduleDynamicWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        Splatoon2ScheduleDynamicWidgetEntryView(entry: Splatoon2ScheduleDynamicEntry(date: Date(), configuration: Splatoon2ScheduleIntent(), schedule: PreviewSplatoon2Schedule))
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
