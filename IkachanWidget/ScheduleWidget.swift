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

struct ScheduleProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> ScheduleEntry {
        ScheduleEntry(date: Date(), configuration: ScheduleIntent(), schedule: SchedulePlaceholder)
    }

    func getSnapshot(for configuration: ScheduleIntent, in context: Context, completion: @escaping (ScheduleEntry) -> ()) {
        fetchSchedules(game: Game(intent: configuration.game)) { schedules, _, error in
            let current = Date().floorToMin()
            guard let schedules = schedules else {
                completion(ScheduleEntry(date: current, configuration: configuration, schedule: nil))
                
                return
            }
            
            let filtered = schedules.filter { schedule in
                schedule.mode.intent == configuration.mode
            }
            if filtered.count > 0 {
                let entry = ScheduleEntry(date: current, configuration: configuration, schedule: filtered[0])
                let resources = [ImageResource(downloadURL: URL(string: filtered[0].stages[0].imageUrl)!), ImageResource(downloadURL: URL(string: filtered[0].stages[1].imageUrl)!)]
                
                ImagePrefetcher(resources: resources) { (_, _, _) in
                    completion(entry)
                }
                .start()
            } else {
                completion(ScheduleEntry(date: current, configuration: configuration, schedule: nil))
            }
        }
    }

    func getTimeline(for configuration: ScheduleIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        fetchSchedules(game: Game(intent: configuration.game)) { schedules, _, error in
            var entries: [ScheduleEntry] = []
            var urls: Set<String> = []
            var resources: [Resource] = []
            var current = Date().floorToMin()
            guard let schedules = schedules else {
                let entry = ScheduleEntry(date: current, configuration: configuration, schedule: nil)

                completion(Timeline(entries: [entry], policy: .after(current.addingTimeInterval(300))))
                
                return
            }
            
            let filtered = schedules.filter { schedule in
                schedule.mode.intent == configuration.mode
            }
            // HACK: Since each schedule lasts for 2 hours, it's ok to add a fixed time shift.
            let timeShift = 7200 * IntentHandler.rotationConvertTo(rotation: configuration.rotation)
            for schedule in filtered {
                let shifted = current.addingTimeInterval(TimeInterval(timeShift))
                while shifted < schedule.endTime && entries.count < MaxWidgetEntryCount {
                    var entry: ScheduleEntry
                    if shifted < schedule.startTime {
                        entry = ScheduleEntry(date: current, configuration: configuration, schedule: nil)
                    } else {
                        entry = ScheduleEntry(date: current, configuration: configuration, schedule: schedule)
                        urls.insert(schedule.stages[0].imageUrl)
                        urls.insert(schedule.stages[1].imageUrl)
                    }
                    entries.append(entry)
                    
                    current = current.addingTimeInterval(60)
                }
                
                if entries.count >= MaxWidgetEntryCount {
                    break
                }
            }
            
            for url in urls {
                resources.append(ImageResource(downloadURL: URL(string: url)!))
            }
            ImagePrefetcher(resources: resources) { (_, _, _) in
                if entries.count > 0 {
                    if entries.last!.date < Date() {
                        let entry = ScheduleEntry(date: current, configuration: configuration, schedule: nil)
                        
                        completion(Timeline(entries: [entry], policy: .after(current.addingTimeInterval(60))))
                    } else {
                        completion(Timeline(entries: entries, policy: .atEnd))
                    }
                } else {
                    let entry = ScheduleEntry(date: current, configuration: configuration, schedule: nil)

                    completion(Timeline(entries: [entry], policy: .after(current.addingTimeInterval(300))))
                }
            }
            .start()
        }
    }
}

struct ScheduleEntry: TimelineEntry {
    let date: Date
    let configuration: ScheduleIntent
    
    let schedule: Schedule?
}

struct ScheduleWidgetEntryView : View {
    var entry: ScheduleProvider.Entry
    
    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        if #available(iOSApplicationExtension 16.0, *) {
            switch family {
            case .accessoryCircular:
                AccessoryCircularScheduleView(current: entry.date, schedule: entry.schedule, mode: mode)
            case .accessoryRectangular:
                AccessoryRectangularScheduleView(schedule: entry.schedule, mode: mode)
            case .systemSmall:
                SmallScheduleView(current: entry.date, schedule: entry.schedule, mode: mode)
            default:
                MediumScheduleView(current: entry.date, schedule: entry.schedule, mode: mode)
            }
        } else {
            switch family {
            case .systemSmall:
                SmallScheduleView(current: entry.date, schedule: entry.schedule, mode: mode)
            default:
                MediumScheduleView(current: entry.date, schedule: entry.schedule, mode: mode)
            }
        }
    }
    
    var game: Game {
        Game(intent: entry.configuration.game)
    }
    var mode: Mode? {
        switch game {
        case .splatoon2:
            return Splatoon2ScheduleMode(intent: entry.configuration.mode)
        case .splatoon3:
            return Splatoon3ScheduleMode(intent: entry.configuration.mode)
        }
    }
}

struct ScheduleWidget: Widget {
    let kind = "ScheduleWidget"

    var body: some WidgetConfiguration {
        if #available(iOSApplicationExtension 16.0, *) {
            return IntentConfiguration(kind: kind, intent: ScheduleIntent.self, provider: ScheduleProvider()) { entry in
                ScheduleWidgetEntryView(entry: entry)
            }
            .configurationDisplayName("schedule")
            .description("schedule_widget_description")
            .supportedFamilies([.accessoryCircular, .accessoryRectangular, .systemSmall, .systemMedium])
        } else {
            return IntentConfiguration(kind: kind, intent: ScheduleIntent.self, provider: ScheduleProvider()) { entry in
                ScheduleWidgetEntryView(entry: entry)
            }
            .configurationDisplayName("schedule")
            .description("schedule_widget_description")
            .supportedFamilies([.systemSmall, .systemMedium])
        }
    }
}

struct ScheduleWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            if #available(iOSApplicationExtension 16.0, *) {
                ScheduleWidgetEntryView(entry: ScheduleEntry(date: Date(), configuration: ScheduleIntent(), schedule: SchedulePlaceholder))
                    .previewContext(WidgetPreviewContext(family: .accessoryCircular))
                    .previewDisplayName("Circular")
                ScheduleWidgetEntryView(entry: ScheduleEntry(date: Date(), configuration: ScheduleIntent(), schedule: SchedulePlaceholder))
                    .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
                    .previewDisplayName("Rectangular")
            }
            ScheduleWidgetEntryView(entry: ScheduleEntry(date: Date(), configuration: ScheduleIntent(), schedule: SchedulePlaceholder))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            ScheduleWidgetEntryView(entry: ScheduleEntry(date: Date(), configuration: ScheduleIntent(), schedule: SchedulePlaceholder))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
