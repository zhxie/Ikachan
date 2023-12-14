//
//  Splatoon2ShiftWidget.swift
//  IkachanWidget
//
//  Created by Sketch on 2023/12/13.
//

import WidgetKit
import SwiftUI
import Intents
import Kingfisher

struct Splatoon2ShiftProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> Splatoon2ShiftEntry {
        Splatoon2ShiftEntry(date: Date(), configuration: Splatoon2ShiftIntent(), shift: PreviewSplatoon2Shift)
    }

    func getSnapshot(for configuration: Splatoon2ShiftIntent, in context: Context, completion: @escaping (Splatoon2ShiftEntry) -> ()) {
        fetchSplatoon2Shifts(locale: Locale.localizedLocale) { shifts, error in
            guard error == .NoError else {
                completion(Splatoon2ShiftEntry(date: Date(), configuration: configuration, shift: nil))
                
                return
            }
            
            if !shifts.isEmpty {
                var entry = Splatoon2ShiftEntry(date: Date(), configuration: configuration, shift: shifts.first!)
                var urls: Set<URL> = []
                if let stage = shifts.first!.stage {
                    urls.insert(stage.thumbnail ?? stage.image)
                    for weapon in shifts.first!.weapons! {
                        urls.insert(weapon.thumbnail ?? weapon.image)
                    }
                }
                if shifts.count > 1 {
                    entry.nextShift = shifts.at(index: 1)!
                    if let stage = shifts.at(index: 1)!.stage {
                        urls.insert(stage.thumbnail ?? stage.image)
                        for weapon in shifts.at(index: 1)!.weapons! {
                            urls.insert(weapon.thumbnail ?? weapon.image)
                        }
                    }
                }
                
                ImagePrefetcher(resources: urls.map({ url in
                    KF.ImageResource(downloadURL: url)
                })) { (_, _, _) in
                    completion(entry)
                }
                .start()
            } else {
                completion(Splatoon2ShiftEntry(date: Date(), configuration: configuration, shift: nil))
            }
        }
    }

    func getTimeline(for configuration: Splatoon2ShiftIntent, in context: Context, completion: @escaping (Timeline<Splatoon2ShiftEntry>) -> ()) {
        fetchSplatoon2Shifts(locale: Locale.localizedLocale) { shifts, error in
            guard error == .NoError else {
                completion(Timeline(entries: [Splatoon2ShiftEntry(date: Date(), configuration: configuration, shift: nil)], policy: .after(Date().addingTimeInterval(300))))
                
                return
            }
            
            var entries: [Splatoon2ShiftEntry] = []
            var urls: Set<URL> = []
            if !shifts.isEmpty || shifts.last!.endTime <= Date() {
                for i in 0..<MaxShiftWidgetEntryCount {
                    if shifts.count <= i {
                        break
                    }
                    var entry = Splatoon2ShiftEntry(date: i == 0 ? Date() : shifts.at(index: i)!.startTime, configuration: configuration, shift: shifts.at(index: i)!)
                    if let stage = shifts.at(index: i)!.stage {
                        urls.insert(stage.thumbnail ?? stage.image)
                        for weapon in shifts.at(index: i)!.weapons! {
                            urls.insert(weapon.thumbnail ?? weapon.image)
                        }
                    }
                    if (shifts.count > i + 1) {
                        entry.nextShift = shifts.at(index: i + 1)!
                        if let stage = shifts.at(index: i + 1)!.stage {
                            urls.insert(stage.thumbnail ?? stage.image)
                            for weapon in shifts.at(index: i + 1)!.weapons! {
                                urls.insert(weapon.thumbnail ?? weapon.image)
                            }
                        }
                    }
                    entries.append(entry)
                }
                
                ImagePrefetcher(resources: urls.map({ url in
                    KF.ImageResource(downloadURL: url)
                })) { (_, _, _) in
                    completion(Timeline(entries: entries, policy: .atEnd))
                }
                .start()
            } else {
                completion(Timeline(entries: [Splatoon2ShiftEntry(date: Date(), configuration: configuration, shift: nil)], policy: .after(Date().addingTimeInterval(300))))
            }
        }
    }
}

struct Splatoon2ShiftEntry: TimelineEntry {
    var date: Date
    var configuration: Splatoon2ShiftIntent

    var shift: Splatoon2Shift?
    var nextShift: Splatoon2Shift?
}

struct Splatoon2ShiftWidgetEntryView : View {
    var entry: Splatoon2ShiftProvider.Entry
    
    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            if #available(iOSApplicationExtension 17.0, *) {
                SmallShiftView(shift: entry.shift, nextShift: entry.nextShift)
                    .containerBackground(for: .widget, content: {})
            } else {
                SmallShiftView(shift: entry.shift, nextShift: entry.nextShift)
                    .padding()
            }
        default:
            if #available(iOSApplicationExtension 17.0, *) {
                MediumShiftView(shift: entry.shift, nextShift: entry.nextShift)
                    .containerBackground(for: .widget, content: {})
            } else {
                MediumShiftView(shift: entry.shift, nextShift: entry.nextShift)
                    .padding()
            }
        }
    }
}

struct Splatoon2ShiftWidget: Widget {
    let kind = "Splatoon2ShiftWidget"

    var body: some WidgetConfiguration {
        return IntentConfiguration(kind: kind, intent: Splatoon2ShiftIntent.self, provider: Splatoon2ShiftProvider()) { entry in
            Splatoon2ShiftWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("splatoon_2_shift")
        .description("splatoon_2_shift_widget_description")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct Splatoon2ShiftWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Splatoon2ShiftWidgetEntryView(entry: Splatoon2ShiftEntry(date: Date(), configuration: Splatoon2ShiftIntent(), shift: PreviewSplatoon2Shift, nextShift: PreviewSplatoon2Shift))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            Splatoon2ShiftWidgetEntryView(entry: Splatoon2ShiftEntry(date: Date(), configuration: Splatoon2ShiftIntent(), shift: PreviewSplatoon2Shift, nextShift: PreviewSplatoon2Shift))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
