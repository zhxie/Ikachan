//
//  ScheduleWidget.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/1/21.
//

import WidgetKit
import SwiftUI
import Intents
import Kingfisher

struct Splatoon2ScheduleProvider: IntentTimelineProvider {
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
        }
    }
    
    func placeholder(in context: Context) -> Splatoon2ScheduleEntry {
        Splatoon2ScheduleEntry(date: Date(), configuration: Splatoon2ScheduleIntent(), schedule: PreviewSplatoon2Schedule)
    }

    func getSnapshot(for configuration: Splatoon2ScheduleIntent, in context: Context, completion: @escaping (Splatoon2ScheduleEntry) -> ()) {
        fetchSplatoon2Schedules(locale: Locale.localizedLocale) { schedules, error in
            guard error == .NoError else {
                completion(Splatoon2ScheduleEntry(date: Date(), configuration: configuration, schedule: nil))
                
                return
            }
            
            let filtered = filterSchedules(schedules: schedules, mode: configuration.mode)
            if !filtered.isEmpty {
                var entry = Splatoon2ScheduleEntry(date: Date(), configuration: configuration, schedule: filtered.first!)
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
                completion(Splatoon2ScheduleEntry(date: Date(), configuration: configuration, schedule: nil))
            }
        }
    }

    func getTimeline(for configuration: Splatoon2ScheduleIntent, in context: Context, completion: @escaping (Timeline<Splatoon2ScheduleEntry>) -> ()) {
        fetchSplatoon2Schedules(locale: Locale.localizedLocale) { schedules, error in
            guard error == .NoError else {
                completion(Timeline(entries: [Splatoon2ScheduleEntry(date: Date(), configuration: configuration, schedule: nil)], policy: .after(Date().addingTimeInterval(300))))
                
                return
            }
            
            var entries: [Splatoon2ScheduleEntry] = []
            var urls: Set<URL> = []
            let filtered = filterSchedules(schedules: schedules, mode: configuration.mode)
            if !filtered.isEmpty {
                for i in 0..<MaxScheduleWidgetEntryCount {
                    if filtered.count <= i {
                        break
                    }
                    var entry = Splatoon2ScheduleEntry(date: i == 0 ? Date() : filtered.at(index: i)!.startTime, configuration: configuration, schedule: filtered.at(index: i)!)
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
                completion(Timeline(entries: [Splatoon2ScheduleEntry(date: Date(), configuration: configuration, schedule: nil)], policy: .after(Date().addingTimeInterval(300))))
            }
        }
    }
}

struct Splatoon2ScheduleEntry: TimelineEntry {
    var date: Date
    var configuration: Splatoon2ScheduleIntent

    var schedule: Splatoon2Schedule?
    var nextSchedule: Splatoon2Schedule?
}

struct Splatoon2ScheduleWidgetEntryView : View {
    var entry: Splatoon2ScheduleProvider.Entry
    
    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        switch family {
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
    }
}

struct Splatoon2ScheduleWidget: Widget {
    let kind = "Splatoon2ScheduleWidget"

    var body: some WidgetConfiguration {
        return IntentConfiguration(kind: kind, intent: Splatoon2ScheduleIntent.self, provider: Splatoon2ScheduleProvider()) { entry in
            Splatoon2ScheduleWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("splatoon_2_schedule")
        .description("splatoon_2_schedule_widget_description")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct Splatoon2ScheduleWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Splatoon2ScheduleWidgetEntryView(entry: Splatoon2ScheduleEntry(date: Date(), configuration: Splatoon2ScheduleIntent(), schedule: PreviewSplatoon2Schedule, nextSchedule: PreviewSplatoon2Schedule))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            Splatoon2ScheduleWidgetEntryView(entry: Splatoon2ScheduleEntry(date: Date(), configuration: Splatoon2ScheduleIntent(), schedule: PreviewSplatoon2Schedule, nextSchedule: PreviewSplatoon2Schedule))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
