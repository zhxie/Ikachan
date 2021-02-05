//
//  DayWidget.swift
//  ScheduleWidgetExtension
//
//  Created by Sketch on 2021/1/24.
//

import WidgetKit
import SwiftUI
import Intents
import Kingfisher

struct DayProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> DayEntry {
        DayEntry(date: Date(), configuration: ScheduleIntent(), schedule: SchedulePlaceholder)
    }
    
    func getSnapshot(for configuration: ScheduleIntent, in context: Context, completion: @escaping (DayEntry) -> Void) {
        fetchSchedules { (schedules, error) in
            let current = Date()
            
            guard let schedules = schedules else {
                completion(DayEntry(date: current, configuration: configuration, schedule: nil))
                
                return
            }
            
            let filtered = schedules.filter { schedule in
                schedule.gameMode == IntentHandler.gameModeConvertTo(gameMode: configuration.gameMode)
            }
            
            if filtered.count > 0 {
                let entry = DayEntry(date: current, configuration: configuration, schedule: filtered[0])
                
                completion(entry)
            } else {
                completion(DayEntry(date: current, configuration: configuration, schedule: nil))
            }
        }
    }
    
    func getTimeline(for configuration: ScheduleIntent, in context: Context, completion: @escaping (Timeline<DayEntry>) -> Void) {
        fetchSchedules { (schedules, error) in
            var entries: [DayEntry] = []
            
            var current = Date()
            let interval = current - Date(timeIntervalSince1970: 0)
            let secs = interval - interval.truncatingRemainder(dividingBy: 60)
            current = Date(timeIntervalSince1970: secs)
            
            guard let schedules = schedules else {
                let entry = DayEntry(date: current, configuration: configuration, schedule: nil)
                let entry2 = DayEntry(date: current.addingTimeInterval(60), configuration: configuration, schedule: nil)
                
                completion(Timeline(entries: [entry, entry2], policy: .atEnd))
                
                return
            }
            
            let filtered = schedules.filter { schedule in
                schedule.gameMode == IntentHandler.gameModeConvertTo(gameMode: configuration.gameMode)
            }
            
            for schedule in filtered {
                while current < schedule.endTime && entries.count < MaxWidgetEntryCount {
                    let entry = DayEntry(date: current, configuration: configuration, schedule: schedule)
                    entries.append(entry)
                    
                    current = current.addingTimeInterval(60)
                }
                
                if entries.count >= MaxWidgetEntryCount {
                    break
                }
            }
            
            let timeline = Timeline(entries: entries, policy: .atEnd)
            
            completion(timeline)
        }
    }
}

struct DayEntry: TimelineEntry {
    let date: Date
    let configuration: ScheduleIntent
    
    let schedule: Schedule?
}

struct DayWidgetEntryView: View {
    var entry: DayProvider.Entry
    
    var body: some View {
        SmallDayView(current: entry.date, schedule: entry.schedule)
            .widgetURL(URL(string: IntentHandler.gameModeConvertTo(gameMode: entry.configuration.gameMode).url)!)
    }
}

struct DayWidget: Widget {
    let kind: String = "DayWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ScheduleIntent.self, provider: DayProvider()) { entry in
            DayWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("day_widget_name")
        .description("day_widget_description")
        .supportedFamilies([.systemSmall])
    }
}

struct DayWidget_Previews: PreviewProvider {
    static var previews: some View {
        DayWidgetEntryView(entry: DayEntry(date: Date(), configuration: ScheduleIntent(), schedule: SchedulePlaceholder))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
