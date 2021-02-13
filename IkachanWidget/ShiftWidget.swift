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

struct ShiftProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> ShiftEntry {
        ShiftEntry(date: Date(), shift: ShiftPlaceholder)
    }
    
    func getSnapshot(for configuration: ShiftIntent, in context: Context, completion: @escaping (ShiftEntry) -> ()) {
        fetchShifts { (shifts, error) in
            let current = Date()
            
            guard let shifts = shifts else {
                completion(ShiftEntry(date: current, shift: nil))
                
                return
            }
            
            let details = shifts.filter { shift in
                shift.stage != nil
            }
            
            if details.count > 0 {
                let entry = ShiftEntry(date: current, shift: details[0])
                let resources = [ImageResource(downloadURL: URL(string: details[0].stage!.url)!), ImageResource(downloadURL: URL(string: details[0].weapons[0].url)!), ImageResource(downloadURL: URL(string: details[0].weapons[1].url)!), ImageResource(downloadURL: URL(string: details[0].weapons[2].url)!), ImageResource(downloadURL: URL(string: details[0].weapons[3].url)!)]
                
                ImagePrefetcher(resources: resources) { (_, _, _) in
                    completion(entry)
                }
                .start()
            } else {
                completion(ShiftEntry(date: current, shift: nil))
            }
        }
    }
    
    func getTimeline(for configuration: ShiftIntent, in context: Context, completion: @escaping (Timeline<ShiftEntry>) -> ()) {
        fetchShifts { (shifts, error) in
            var entries: [ShiftEntry] = []
            var urls: Set<String> = []
            var resources: [Resource] = []
            
            var current = Date()
            let interval = current - Date(timeIntervalSince1970: 0)
            let secs = interval - interval.truncatingRemainder(dividingBy: 60)
            current = Date(timeIntervalSince1970: secs)
            
            guard let shifts = shifts else {
                let entry = ShiftEntry(date: current, shift: nil)

                completion(Timeline(entries: [entry], policy: .after(current.addingTimeInterval(300))))
                
                return
            }
            
            var details = shifts.filter { shift in
                shift.stage != nil
            }
            // HACK: Since there're only 2 detailed shifts at once, it's ok to pop the former one.
            details = details.suffix(details.count - IntentHandler.rotationConvertTo(rotation: configuration.rotation))
            
            for shift in details {
                while current < shift.endTime && entries.count < MaxWidgetEntryCount {
                    let entry = ShiftEntry(date: current, shift: shift)
                    entries.append(entry)
                    urls.insert(shift.stage!.url)
                    urls.insert(shift.weapons[0].url)
                    urls.insert(shift.weapons[1].url)
                    urls.insert(shift.weapons[2].url)
                    urls.insert(shift.weapons[3].url)
                    
                    var distance = shift.endTime - current
                    if current < shift.startTime {
                        distance = shift.startTime - current
                    }
                    
                    var delta = 60.0
                    if distance >= 864000 {
                        delta = distance.truncatingRemainder(dividingBy: 86400)
                    } else if distance >= 36000 {
                        delta = distance.truncatingRemainder(dividingBy: 3600)
                    }
                    if delta == 0 {
                        delta = 60.0
                    }
                    current = current.addingTimeInterval(delta)
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
                        let entry = ShiftEntry(date: current, shift: nil)

                        completion(Timeline(entries: [entry], policy: .after(current.addingTimeInterval(60))))
                    } else {
                        completion(Timeline(entries: entries, policy: .atEnd))
                    }
                } else {
                    let entry = ShiftEntry(date: current, shift: nil)

                    completion(Timeline(entries: [entry], policy: .after(current.addingTimeInterval(300))))
                }
            }
            .start()
        }
    }
}

struct ShiftEntry: TimelineEntry {
    let date: Date
    
    let shift: Shift?
}

struct ShiftWidgetEntryView: View {
    var entry: ShiftProvider.Entry
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            SmallShiftView(current: entry.date, shift: entry.shift)
                .widgetURL(URL(string: Shift.url)!)
        default:
            MediumShiftView(current: entry.date, shift: entry.shift)
                .widgetURL(URL(string: Shift.url)!)
        }
    }
}

struct ShiftWidget: Widget {
    let kind: String = "ShiftWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent:ShiftIntent.self, provider: ShiftProvider()) { entry in
            ShiftWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("shift")
        .description("shift_widget_description")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct ShiftWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ShiftWidgetEntryView(entry: ShiftEntry(date: Date(), shift: ShiftPlaceholder))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            ShiftWidgetEntryView(entry: ShiftEntry(date: Date(), shift: ShiftPlaceholder))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
