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
        DayEntry(date: Date(), configuration: ConfigurationIntent(), current: Date(), schedule: SchedulePlaceholder)
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (DayEntry) -> Void) {
        ModelData.fetchSchedules { (schedules, error) in
            let current = Date()
            
            guard let schedules = schedules else {
                return
            }
            
            let filtered = schedules.filter { schedule in
                schedule.gameMode == ScheduleProvider.gameMode(for: configuration)
            }
            
            if filtered.count > 0 {
                let entry = DayEntry(date: current, configuration: configuration, current: current, schedule: filtered[0])
                let resources = [ImageResource(downloadURL: URL(string: Splatnet2URL + filtered[0].stageA.image)!), ImageResource(downloadURL: URL(string: Splatnet2URL + filtered[0].stageB.image)!)]
                
                ImagePrefetcher(resources: resources) { (_, _, _) in
                    completion(entry)
                }
                .start()
            }
        }
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<DayEntry>) -> Void) {
        ModelData.fetchSchedules { (schedules, error) in
            var entries: [DayEntry] = []
            var urls: Set<URL> = []
            var resources: [Resource] = []
            
            var current = Date()
            let interval = current - Date(timeIntervalSince1970: 0)
            let secs = interval - interval.truncatingRemainder(dividingBy: 60)
            current = Date(timeIntervalSince1970: secs)
            
            guard let schedules = schedules else {
                return
            }
            
            let filtered = schedules.filter { schedule in
                schedule.gameMode == ScheduleProvider.gameMode(for: configuration)
            }
            
            var date = Date()
            for schedule in filtered {
                date = schedule.startTime
                
                while date < schedule.endTime && entries.count < 30 {
                    if date >= current {
                        let entry = DayEntry(date: date, configuration: configuration, current: date, schedule: schedule)
                        entries.append(entry)
                        urls.insert(URL(string: Splatnet2URL + schedule.stageA.image)!)
                        urls.insert(URL(string: Splatnet2URL + schedule.stageB.image)!)
                    }
                    
                    date = date.addingTimeInterval(60)
                }
                
                if entries.count >= 30 {
                    break
                }
            }
            
            let timeline = Timeline(entries: entries, policy: .atEnd)
            for url in urls {
                resources.append(ImageResource(downloadURL: url))
            }
            ImagePrefetcher(resources: resources) { (_, _, _) in
                completion(timeline)
            }
            .start()
        }
    }
}

struct DayEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    
    let current: Date
    let schedule: Schedule?
}

struct DayWidgetEntryView: View {
    var entry: DayProvider.Entry
    
    var body: some View {
        SmallDayView(current: entry.current, schedule: entry.schedule)
            .widgetURL(URL(string: ScheduleProvider.gameMode(for: entry.configuration).url)!)
    }
}

struct DayWidget: Widget {
    let kind: String = "DayWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: DayProvider()) { entry in
            DayWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("day_widget_name")
        .description("day_widget_description")
        .supportedFamilies([.systemSmall])
    }
}

struct DayWidget_Previews: PreviewProvider {
    static var previews: some View {
        let modelData = ModelData()
        
        let asset = NSDataAsset(name: "schedules", bundle: Bundle.main)!
        
        _ = modelData.loadSchedules(data: asset.data)
        
        return DayWidgetEntryView(entry: DayEntry(date: Date(), configuration: ConfigurationIntent(), current: Date(), schedule: modelData.schedules[0]))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
