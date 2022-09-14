//
//  DayWidget.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/1/24.
//

import WidgetKit
import SwiftUI
import Intents

struct DayProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> DayEntry {
        DayEntry(date: Date(), configuration: DayIntent(), schedule: SchedulePlaceholder)
    }
    
    func getSnapshot(for configuration: DayIntent, in context: Context, completion: @escaping (DayEntry) -> Void) {
        fetchSchedules { (schedules, error) in
            let current = Date().floorToMin()
            
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
    
    func getTimeline(for configuration: DayIntent, in context: Context, completion: @escaping (Timeline<DayEntry>) -> Void) {
        fetchSchedules { (schedules, error) in
            var entries: [DayEntry] = []
            
            var current = Date().floorToMin()
            
            guard let schedules = schedules else {
                let entry = DayEntry(date: current, configuration: configuration, schedule: nil)

                completion(Timeline(entries: [entry], policy: .after(current.addingTimeInterval(300))))
                
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
            
            if entries.count > 0 {
                if entries.last!.date < Date() {
                    let entry = DayEntry(date: current, configuration: configuration, schedule: nil)

                    completion(Timeline(entries: [entry], policy: .after(current.addingTimeInterval(60))))
                } else {
                    completion(Timeline(entries: entries, policy: .atEnd))
                }
            } else {
                let entry = DayEntry(date: current, configuration: configuration, schedule: nil)

                completion(Timeline(entries: [entry], policy: .after(current.addingTimeInterval(300))))
            }
        }
    }
}

struct DayEntry: TimelineEntry {
    let date: Date
    let configuration: DayIntent
    
    let schedule: Schedule?
}

struct DayWidgetEntryView: View {
    var entry: DayProvider.Entry
    
    var body: some View {
        SmallDayView(current: entry.date, schedule: entry.schedule)
    }
}

struct DayWidget: Widget {
    let kind = "DayWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: DayIntent.self, provider: DayProvider()) { entry in
            DayWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("day_widget_name")
        .description("day_widget_description")
        .supportedFamilies([.systemSmall])
    }
}

struct DayWidget_Previews: PreviewProvider {
    static var previews: some View {
        DayWidgetEntryView(entry: DayEntry(date: Date(), configuration: DayIntent(), schedule: SchedulePlaceholder))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
