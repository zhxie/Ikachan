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
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), current: Date(), schedule: SchedulePlaceholder)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        ModelData.fetchSchedules { (schedules, error) in
            let current = Date()
            
            guard let schedules = schedules else {
                return
            }
            
            let filtered = schedules.filter { schedule in
                schedule.gameMode == gameMode(for: configuration)
            }
            
            if filtered.count > 0 {
                let entry = SimpleEntry(date: current, configuration: configuration, current: current, schedule: filtered[0])
                let resources = [ImageResource(downloadURL: URL(string: Splatnet2URL + filtered[0].stageA.image)!), ImageResource(downloadURL: URL(string: Splatnet2URL + filtered[0].stageB.image)!)]
                
                ImagePrefetcher(resources: resources) { (_, _, _) in
                    completion(entry)
                }
                .start()
            }
        }
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        var urls: Set<URL> = []
        var resources: [Resource] = []
        
        ModelData.fetchSchedules { (schedules, error) in
            let current = Date()
            
            guard let schedules = schedules else {
                return
            }
            
            let filtered = schedules.filter { schedule in
                schedule.gameMode == gameMode(for: configuration)
            }
            
            var date = Date()
            for schedule in filtered {
                date = schedule.startTime
                
                while date < schedule.endTime && entries.count < 60 {
                    if date >= current.addingTimeInterval(-60) {
                        let entry = SimpleEntry(date: date, configuration: configuration, current: date, schedule: schedule)
                        entries.append(entry)
                        urls.insert(URL(string: Splatnet2URL + schedule.stageA.image)!)
                        urls.insert(URL(string: Splatnet2URL + schedule.stageB.image)!)
                    }
                    
                    date = date.addingTimeInterval(60)
                }
                
                if entries.count >= 60 {
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

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    
    let current: Date
    let schedule: Schedule?
}

struct ScheduleWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            SmallScheduleView(current: entry.current, schedule: entry.schedule)
        default:
            MediumScheduleView(current: entry.current, schedule: entry.schedule)
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
            ScheduleWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), current: Date(), schedule: modelData.schedules[0]))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            ScheduleWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), current: Date(), schedule: modelData.schedules[0]))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
