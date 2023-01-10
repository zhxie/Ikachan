//
//  ShiftWidget.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/1/24.
//

import WidgetKit
import SwiftUI
import Intents
import Kingfisher

struct ShiftProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> ShiftEntry {
        ShiftEntry(date: Date(), configuration: ShiftIntent(), shift: ShiftPlaceholder)
    }
    
    func getSnapshot(for configuration: ShiftIntent, in context: Context, completion: @escaping (ShiftEntry) -> ()) {
        fetchShifts(game: Game(intent: configuration.game)) { (shifts, error) in
            let current = Date().floorToMin()
            guard let shifts = shifts else {
                completion(ShiftEntry(date: current, configuration: configuration, shift: nil))
                
                return
            }
            
            let details = shifts.filter { shift in
                shift.stage != nil
            }
            if details.count > 0 {
                let entry = ShiftEntry(date: current, configuration: configuration, shift: details[0])
                let resources = [ImageResource(downloadURL: URL(string: details[0].stage!.thumbnailUrl)!), ImageResource(downloadURL: URL(string: details[0].weapons[0].thumbnailUrl)!), ImageResource(downloadURL: URL(string: details[0].weapons[1].thumbnailUrl)!), ImageResource(downloadURL: URL(string: details[0].weapons[2].thumbnailUrl)!), ImageResource(downloadURL: URL(string: details[0].weapons[3].thumbnailUrl)!)]
                
                ImagePrefetcher(resources: resources) { (_, _, _) in
                    completion(entry)
                }
                .start()
            } else {
                completion(ShiftEntry(date: current, configuration: configuration, shift: nil))
            }
        }
    }
    
    func getTimeline(for configuration: ShiftIntent, in context: Context, completion: @escaping (Timeline<ShiftEntry>) -> ()) {
        fetchShifts(game: Game(intent: configuration.game)) { (shifts, error) in
            var entries: [ShiftEntry] = []
            var urls: Set<String> = []
            var resources: [Resource] = []
            var current = Date().floorToMin()
            guard let shifts = shifts else {
                let entry = ShiftEntry(date: current, configuration: configuration, shift: nil)

                completion(Timeline(entries: [entry], policy: .after(current.addingTimeInterval(300))))
                
                return
            }
            
            var details = shifts.filter { shift in
                shift.stage != nil
            }
            // HACK: Since there are at least more than 2 detailed shifts at once, it's ok to pop the former one.
            details = details.suffix(details.count - IntentHandler.rotationConvertTo(rotation: configuration.rotation))
            for shift in details {
                while current < shift.endTime && entries.count < MaxWidgetEntryCount {
                    let entry = ShiftEntry(date: current, configuration: configuration, shift: shift)
                    entries.append(entry)
                    urls.insert(shift.stage!.thumbnailUrl)
                    urls.insert(shift.weapons[0].thumbnailUrl)
                    urls.insert(shift.weapons[1].thumbnailUrl)
                    urls.insert(shift.weapons[2].thumbnailUrl)
                    urls.insert(shift.weapons[3].thumbnailUrl)
                    
                    var distance = shift.endTime - current
                    if current < shift.startTime {
                        distance = shift.startTime - current
                    }
                    
                    var delta: Double = 60
                    if distance >= 864000 {
                        delta = distance.truncatingRemainder(dividingBy: 86400)
                    } else if distance >= 36000 {
                        delta = distance.truncatingRemainder(dividingBy: 3600)
                    }
                    if delta == 0 {
                        delta = 60
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
                        let entry = ShiftEntry(date: current, configuration: configuration, shift: nil)

                        completion(Timeline(entries: [entry], policy: .after(current.addingTimeInterval(60))))
                    } else {
                        completion(Timeline(entries: entries, policy: .atEnd))
                    }
                } else {
                    let entry = ShiftEntry(date: current, configuration: configuration, shift: nil)

                    completion(Timeline(entries: [entry], policy: .after(current.addingTimeInterval(300))))
                }
            }
            .start()
        }
    }
}

struct ShiftEntry: TimelineEntry {
    let date: Date
    let configuration: ShiftIntent
    
    let shift: Shift?
}

struct ShiftWidgetEntryView: View {
    var entry: ShiftProvider.Entry
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        if #available(iOSApplicationExtension 16.0, *) {
            switch family {
            case .accessoryCircular:
                AccessoryCircularShiftView(current: entry.date, shift: entry.shift, mode: mode)
                    .widgetURL(URL(string: String(format: IkachanShiftScheme, game.name))!)
            case .accessoryRectangular:
                AccessoryRectangularShiftView(shift: entry.shift)
                    .widgetURL(URL(string: String(format: IkachanShiftScheme, game.name))!)
            case .systemSmall:
                SmallShiftView(current: entry.date, shift: entry.shift, mode: mode)
                    .widgetURL(URL(string: String(format: IkachanShiftScheme, game.name))!)
            default:
                MediumShiftView(current: entry.date, shift: entry.shift, mode: mode)
                    .widgetURL(URL(string: String(format: IkachanShiftScheme, game.name))!)
            }
        } else {
            switch family {
            case .systemSmall:
                SmallShiftView(current: entry.date, shift: entry.shift, mode: mode)
                    .widgetURL(URL(string: String(format: IkachanShiftScheme, game.name))!)
            default:
                MediumShiftView(current: entry.date, shift: entry.shift, mode: mode)
                    .widgetURL(URL(string: String(format: IkachanShiftScheme, game.name))!)
            }
        }
    }
    
    var game: Game {
        Game(intent: entry.configuration.game)
    }
    var mode: Mode {
        switch game {
        case .splatoon2:
            return Splatoon2ShiftMode.salmonRun
        case .splatoon3:
            return Splatoon3ShiftMode.regularJob
        }
    }
}

struct ShiftWidget: Widget {
    let kind = "ShiftWidget"
    
    var body: some WidgetConfiguration {
        if #available(iOSApplicationExtension 16.0, *) {
            return IntentConfiguration(kind: kind, intent:ShiftIntent.self, provider: ShiftProvider()) { entry in
                ShiftWidgetEntryView(entry: entry)
            }
            .configurationDisplayName("shift")
            .description("shift_widget_description")
            .supportedFamilies([.accessoryCircular, .accessoryRectangular, .systemSmall, .systemMedium])
        } else {
            return IntentConfiguration(kind: kind, intent:ShiftIntent.self, provider: ShiftProvider()) { entry in
                ShiftWidgetEntryView(entry: entry)
            }
            .configurationDisplayName("shift")
            .description("shift_widget_description")
            .supportedFamilies([.systemSmall, .systemMedium])
        }
    }
}

struct ShiftWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            if #available(iOSApplicationExtension 16.0, *) {
                ShiftWidgetEntryView(entry: ShiftEntry(date: Date(), configuration: ShiftIntent(), shift: ShiftPlaceholder))
                    .previewContext(WidgetPreviewContext(family: .accessoryCircular))
                    .previewDisplayName("Circular")
                ShiftWidgetEntryView(entry: ShiftEntry(date: Date(), configuration: ShiftIntent(), shift: ShiftPlaceholder))
                    .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
                    .previewDisplayName("Rectangular")
            }
            ShiftWidgetEntryView(entry: ShiftEntry(date: Date(), configuration: ShiftIntent(), shift: ShiftPlaceholder))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            ShiftWidgetEntryView(entry: ShiftEntry(date: Date(), configuration: ShiftIntent(), shift: ShiftPlaceholder))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
