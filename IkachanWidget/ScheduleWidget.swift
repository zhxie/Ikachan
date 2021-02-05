//
//  ScheduleWidget.swift
//  ScheduleWidget
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
        fetchSchedules { (schedules, error) in
            let current = Date()
            
            guard let schedules = schedules else {
                completion(ScheduleEntry(date: current, configuration: configuration, schedule: nil))
                
                return
            }
            
            let filtered = schedules.filter { schedule in
                schedule.gameMode == IntentHandler.gameModeConvertTo(gameMode: configuration.gameMode)
            }
            
            if filtered.count > 0 {
                let entry = ScheduleEntry(date: current, configuration: configuration, schedule: filtered[0])
                let resources = [ImageResource(downloadURL: URL(string: filtered[0].stageA.url)!), ImageResource(downloadURL: URL(string: filtered[0].stageB.url)!)]
                
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
        fetchSchedules { (schedules, error) in
            var entries: [ScheduleEntry] = []
            var urls: Set<String> = []
            var resources: [Resource] = []
            
            var current = Date()
            let interval = current - Date(timeIntervalSince1970: 0)
            let secs = interval - interval.truncatingRemainder(dividingBy: 60)
            current = Date(timeIntervalSince1970: secs)
            
            guard let schedules = schedules else {
                let entry = ScheduleEntry(date: current, configuration: configuration, schedule: nil)
                let entry2 = ScheduleEntry(date: current.addingTimeInterval(60), configuration: configuration, schedule: nil)
                
                completion(Timeline(entries: [entry, entry2], policy: .atEnd))
                
                return
            }
            
            let filtered = schedules.filter { schedule in
                schedule.gameMode == IntentHandler.gameModeConvertTo(gameMode: configuration.gameMode)
            }
            // HACK: Since each schedule lasts for 2 hours, it's ok to add a fixed time shift.
            let timeShift = 7200 * IntentHandler.rotationConvertTo(rotation: configuration.rotation)
            
            for schedule in filtered {
                while current.addingTimeInterval(TimeInterval(timeShift)) < schedule.endTime && entries.count < MaxWidgetEntryCount {
                    let entry = ScheduleEntry(date: current, configuration: configuration, schedule: schedule)
                    entries.append(entry)
                    urls.insert(schedule.stageA.url)
                    urls.insert(schedule.stageB.url)
                    
                    current = current.addingTimeInterval(60)
                }
                
                if entries.count >= MaxWidgetEntryCount {
                    break
                }
            }
            
            let timeline = Timeline(entries: entries, policy: .atEnd)
            for url in urls {
                resources.append(ImageResource(downloadURL: URL(string: url)!))
            }
            ImagePrefetcher(resources: resources) { (_, _, _) in
                completion(timeline)
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
            SmallScheduleView(current: entry.date, schedule: entry.schedule, gameMode: gameMode)
                .widgetURL(URL(string: gameMode.url)!)
        default:
            MediumScheduleView(current: entry.date, schedule: entry.schedule, gameMode: gameMode)
                .widgetURL(URL(string: gameMode.url)!)
        }
    }
    
    var gameMode: Schedule.GameMode {
        IntentHandler.gameModeConvertTo(gameMode: entry.configuration.gameMode)
    }
}

struct ScheduleWidget: Widget {
    let kind: String = "ScheduleWidget"

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
