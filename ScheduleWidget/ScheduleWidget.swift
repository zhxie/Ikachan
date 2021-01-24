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
    static func gameMode(for configuration: ConfigurationIntent) -> Schedule.GameMode {
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
    
    func placeholder(in context: Context) -> ScheduleEntry {
        ScheduleEntry(date: Date(), configuration: ConfigurationIntent(), current: Date(), schedule: SchedulePlaceholder)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (ScheduleEntry) -> ()) {
        ModelData.fetchSchedules { (schedules, error) in
            let current = Date()
            
            guard let schedules = schedules else {
                return
            }
            
            let filtered = schedules.filter { schedule in
                schedule.gameMode == ScheduleProvider.gameMode(for: configuration)
            }
            
            if filtered.count > 0 {
                let entry = ScheduleEntry(date: current, configuration: configuration, current: current, schedule: filtered[0])
                let resources = [ImageResource(downloadURL: URL(string: Splatnet2URL + filtered[0].stageA.image)!), ImageResource(downloadURL: URL(string: Splatnet2URL + filtered[0].stageB.image)!)]
                
                ImagePrefetcher(resources: resources) { (_, _, _) in
                    completion(entry)
                }
                .start()
            }
        }
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        ModelData.fetchSchedules { (schedules, error) in
            var entries: [ScheduleEntry] = []
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
                        let entry = ScheduleEntry(date: date, configuration: configuration, current: date, schedule: schedule)
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

struct ScheduleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    
    let current: Date
    let schedule: Schedule?
}

struct ScheduleWidgetEntryView : View {
    var entry: ScheduleProvider.Entry
    
    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            SmallScheduleView(current: entry.current, schedule: entry.schedule)
                .widgetURL(URL(string: ScheduleProvider.gameMode(for: entry.configuration).url)!)
        default:
            MediumScheduleView(current: entry.current, schedule: entry.schedule)
                .widgetURL(URL(string: ScheduleProvider.gameMode(for: entry.configuration).url)!)
        }
    }
}

struct ScheduleWidget: Widget {
    let kind: String = "ScheduleWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: ScheduleProvider()) { entry in
            ScheduleWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("schedule")
        .description("schedule_widget_description")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct ScheduleWidget_Previews: PreviewProvider {
    static var previews: some View {
        let modelData = ModelData()
        
        let asset = NSDataAsset(name: "schedules", bundle: Bundle.main)!
        
        _ = modelData.loadSchedules(data: asset.data)
        
        return Group {
            ScheduleWidgetEntryView(entry: ScheduleEntry(date: Date(), configuration: ConfigurationIntent(), current: Date(), schedule: modelData.schedules[0]))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            ScheduleWidgetEntryView(entry: ScheduleEntry(date: Date(), configuration: ConfigurationIntent(), current: Date(), schedule: modelData.schedules[0]))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
