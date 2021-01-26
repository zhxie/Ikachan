//
//  ShiftWidget.swift
//  ScheduleWidgetExtension
//
//  Created by Sketch on 2021/1/24.
//

import WidgetKit
import SwiftUI
import Intents
import Kingfisher

struct ShiftProvider: TimelineProvider {
    func placeholder(in context: Context) -> ShiftEntry {
        ShiftEntry(date: Date(), current: Date(), shift: ShiftPlaceholder)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (ShiftEntry) -> ()) {
        ModelData.fetchShifts { (shifts, error) in
            let current = Date()
            
            guard let shifts = shifts else {
                completion(placeholder(in: context))
                
                return
            }
            
            let details = shifts.filter { shift in
                shift.stage != nil
            }
            
            if details.count > 0 {
                let entry = ShiftEntry(date: current, current: current, shift: details[0])
                let resources = [ImageResource(downloadURL: URL(string: Splatnet2URL + details[0].stage!.image.rawValue)!), ImageResource(downloadURL: URL(string: Splatnet2URL + details[0].weapons[0].image)!), ImageResource(downloadURL: URL(string: Splatnet2URL + details[0].weapons[1].image)!), ImageResource(downloadURL: URL(string: Splatnet2URL + details[0].weapons[2].image)!), ImageResource(downloadURL: URL(string: Splatnet2URL + details[0].weapons[3].image)!)]
                
                ImagePrefetcher(resources: resources) { (_, _, _) in
                    completion(entry)
                }
                .start()
            } else {
                completion(placeholder(in: context))
            }
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ShiftEntry>) -> ()) {
        ModelData.fetchShifts { (shifts, error) in
            var entries: [ShiftEntry] = []
            var urls: Set<String> = []
            var resources: [Resource] = []
            
            var current = Date()
            let interval = current - Date(timeIntervalSince1970: 0)
            let secs = interval - interval.truncatingRemainder(dividingBy: 60)
            current = Date(timeIntervalSince1970: secs)
            
            guard let shifts = shifts else {
                completion(Timeline(entries: [], policy: .atEnd))
                
                return
            }
            
            let details = shifts.filter { shift in
                shift.stage != nil
            }
            
            var date = Date()
            for shift in details {
                date = shift.startTime
                
                while date < shift.endTime && entries.count < MaxWidgetEntryCount {
                    if date >= current {
                        let entry = ShiftEntry(date: date, current: date, shift: shift)
                        entries.append(entry)
                        urls.insert(Splatnet2URL + shift.stage!.image.rawValue)
                        urls.insert(Splatnet2URL + shift.weapons[0].image)
                        urls.insert(Splatnet2URL + shift.weapons[1].image)
                        urls.insert(Splatnet2URL + shift.weapons[2].image)
                        urls.insert(Splatnet2URL + shift.weapons[3].image)
                    }
                    
                    let distance = shift.endTime - date
                    if distance >= 11 * 86400 {
                        date = date.addingTimeInterval(86400)
                    } else if distance >= 10 * 86400 {
                        date = date.addingTimeInterval(distance - 10 * 86400)
                    } else if distance >= 11 * 3600 {
                        date = date.addingTimeInterval(3600)
                    } else if distance >= 10 * 3600 {
                        date = date.addingTimeInterval(distance - 10 * 3600)
                    } else {
                        date = date.addingTimeInterval(60)
                    }
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

struct ShiftEntry: TimelineEntry {
    let date: Date
    
    let current: Date
    let shift: Shift?
}

struct ShiftWidgetEntryView: View {
    var entry: ShiftProvider.Entry
    
    var body: some View {
        MediumShiftView(current: entry.current, shift: entry.shift)
            .widgetURL(URL(string: Shift.url)!)
    }
}

struct ShiftWidget: Widget {
    let kind: String = "ShiftWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ShiftProvider()) { entry in
            ShiftWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("shift")
        .description("shift_widget_description")
        .supportedFamilies([.systemMedium])
    }
}

struct ShiftWidget_Previews: PreviewProvider {
    static var previews: some View {
        ShiftWidgetEntryView(entry: ShiftEntry(date: Date(), current: Date(), shift: ShiftPlaceholder))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
