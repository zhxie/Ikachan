//
//  ScheduleWidget.swift
//  ScheduleWidget
//
//  Created by Sketch on 2021/1/21.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func gameMode(for configuration: ConfigurationIntent) -> Schedule.GameMode {
        switch configuration.gameMode {
        case .regular:
            return Schedule.GameMode.regular
        case .gachi:
            return Schedule.GameMode.gachi
        case .league:
            return Schedule.GameMode.league
        default:
            return Schedule.GameMode.regular
        }
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), schedule: SchedulePlaceholder)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        ModelData.fetchSchedules { (schedules, error) in
            guard let schedules = schedules else {
                let entry = SimpleEntry(date: Date(), configuration: configuration, schedule: nil)
                completion(entry)
                
                return
            }
            
            let filtered = schedules.filter { schedule in
                schedule.gameMode == gameMode(for: configuration)
            }
            
            let entry = SimpleEntry(date: filtered[0].startTime, configuration: configuration, schedule: filtered[0])
            completion(entry)
        }
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        ModelData.fetchSchedules { (schedules, error) in
            guard let schedules = schedules else {
                let entry = SimpleEntry(date: Date(), configuration: configuration, schedule: nil)
                entries.append(entry)
                
                let timeline = Timeline(entries: entries, policy: .atEnd)
                completion(timeline)
                
                return
            }
            
            let filtered = schedules.filter { schedule in
                schedule.gameMode == gameMode(for: configuration)
            }
            
            for schedule in filtered {
                let entry = SimpleEntry(date: schedule.startTime, configuration: configuration, schedule: schedule)
                entries.append(entry)
            }
            
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    
    let schedule: Schedule?
}

struct ScheduleWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            SmallScheduleView(schedule: entry.schedule)
        default:
            MediumScheduleView(schedule: entry.schedule)
        }
    }
}

@main
struct ScheduleWidget: Widget {
    let kind: String = "ScheduleWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            ScheduleWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Schedule")
        .description("See the current or future schedules.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct ScheduleWidget_Previews: PreviewProvider {
    static var previews: some View {
        let modelData = ModelData()
        
        let asset = NSDataAsset(name: "schedules", bundle: Bundle.main)!
        
        _ = modelData.loadSchedules(data: asset.data)
        
        return Group {
            ScheduleWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), schedule: modelData.schedules[0]))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            ScheduleWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), schedule: modelData.schedules[0]))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
