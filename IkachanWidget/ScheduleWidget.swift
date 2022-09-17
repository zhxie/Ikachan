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
        fetchSplatoon2Schedules { (schedules, error) in
            let current = Date().floorToMin()
            
            guard let schedules = schedules else {
                completion(ScheduleEntry(date: current, configuration: configuration, schedule: nil))
                
                return
            }
            
            let filtered = schedules.filter { schedule in
                schedule.mode.name == IntentHandler.modeConvertTo(mode: configuration.mode).name
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
        fetchSplatoon2Schedules { (schedules, error) in
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
                schedule.mode.name == IntentHandler.modeConvertTo(mode: configuration.mode).name
            }
            // HACK: Since each schedule lasts for 2 hours, it's ok to add a fixed time shift.
            let timeShift = 7200 * IntentHandler.rotationConvertTo(rotation: configuration.rotation)
            
            for schedule in filtered {
                while current.addingTimeInterval(TimeInterval(timeShift)) < schedule.endTime && entries.count < MaxWidgetEntryCount {
                    let entry = ScheduleEntry(date: current, configuration: configuration, schedule: schedule)
                    entries.append(entry)
                    urls.insert(schedule.stages[0].imageUrl)
                    urls.insert(schedule.stages[1].imageUrl)
                    
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
        switch family {
        case .systemSmall:
            SmallScheduleView(current: entry.date, schedule: entry.schedule, mode: mode)
        default:
            MediumScheduleView(current: entry.date, schedule: entry.schedule, mode: mode)
        }
    }
    
    var mode: Mode {
        IntentHandler.modeConvertTo(mode: entry.configuration.mode)
    }
}

struct ScheduleWidget: Widget {
    let kind = "ScheduleWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ScheduleIntent.self, provider: ScheduleProvider()) { entry in
            ScheduleWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("schedule")
        .description("schedule_widget_description")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct ScheduleWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScheduleWidgetEntryView(entry: ScheduleEntry(date: Date(), configuration: ScheduleIntent(), schedule: SchedulePlaceholder))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            ScheduleWidgetEntryView(entry: ScheduleEntry(date: Date(), configuration: ScheduleIntent(), schedule: SchedulePlaceholder))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
