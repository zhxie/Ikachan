//
//  Splatoon3ShiftWidget.swift
//  IkachanWidget
//
//  Created by Sketch on 2023/12/13.
//

import WidgetKit
import SwiftUI
import Intents
import Kingfisher

struct Splatoon3ShiftProvider: IntentTimelineProvider {
    func filterShifts(shifts: [Splatoon3Shift], mode: INSplatoon3ShiftMode) -> [Splatoon3Shift] {
        return shifts.filter { shift in
            switch mode {
            case .unknown, .salmonRun:
                return shift._mode == .salmonRun
            case .bigRun:
                return shift._mode == .bigRun
            case .eggstraWork:
                return shift._mode == .eggstraWork
            }
        }
    }
    
    func placeholder(in context: Context) -> Splatoon3ShiftEntry {
        Splatoon3ShiftEntry(date: Date(), configuration: Splatoon3ShiftIntent(), shift: PreviewSplatoon3Shift)
    }

    func getSnapshot(for configuration: Splatoon3ShiftIntent, in context: Context, completion: @escaping (Splatoon3ShiftEntry) -> ()) {
        fetchSplatoon3Shifts(locale: Locale.localizedLocale) { shifts, error in
            guard error == .NoError else {
                completion(Splatoon3ShiftEntry(date: Date(), configuration: configuration, shift: nil))
                
                return
            }
            
            let filtered = filterShifts(shifts: shifts, mode: configuration.mode)
            if !filtered.isEmpty {
                var entry = Splatoon3ShiftEntry(date: Date(), configuration: configuration, shift: filtered.first!)
                var urls: Set<URL> = []
                if let stage = filtered.first!.stage {
                    urls.insert(stage.thumbnail ?? stage.image)
                    for weapon in filtered.first!.weapons! {
                        urls.insert(weapon.thumbnail ?? weapon.image)
                    }
                }
                if filtered.count > 1 {
                    entry.nextShift = filtered.at(index: 1)!
                    if let stage = filtered.at(index: 1)!.stage {
                        urls.insert(stage.thumbnail ?? stage.image)
                        for weapon in filtered.at(index: 1)!.weapons! {
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
                completion(Splatoon3ShiftEntry(date: Date(), configuration: configuration, shift: nil))
            }
        }
    }

    func getTimeline(for configuration: Splatoon3ShiftIntent, in context: Context, completion: @escaping (Timeline<Splatoon3ShiftEntry>) -> ()) {
        fetchSplatoon3Shifts(locale: Locale.localizedLocale) { shifts, error in
            guard error == .NoError else {
                completion(Timeline(entries: [Splatoon3ShiftEntry(date: Date(), configuration: configuration, shift: nil)], policy: .after(Date().addingTimeInterval(300))))
                
                return
            }
            
            var entries: [Splatoon3ShiftEntry] = []
            var urls: Set<URL> = []
            let filtered = filterShifts(shifts: shifts, mode: configuration.mode)
            if !filtered.isEmpty {
                for i in 0..<MaxShiftWidgetEntryCount {
                    if filtered.count <= i {
                        break
                    }
                    var entry = Splatoon3ShiftEntry(date: i == 0 ? Date() : filtered.at(index: i)!.startTime, configuration: configuration, shift: filtered.at(index: i)!)
                    if let stage = filtered.at(index: i)!.stage {
                        urls.insert(stage.thumbnail ?? stage.image)
                        for weapon in filtered.at(index: i)!.weapons! {
                            urls.insert(weapon.thumbnail ?? weapon.image)
                        }
                    }
                    if (filtered.count > i + 1) {
                        entry.nextShift = filtered.at(index: i + 1)!
                        if let stage = filtered.at(index: i + 1)!.stage {
                            urls.insert(stage.thumbnail ?? stage.image)
                            for weapon in filtered.at(index: i + 1)!.weapons! {
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
                completion(Timeline(entries: [Splatoon3ShiftEntry(date: Date(), configuration: configuration, shift: nil)], policy: .after(Date().addingTimeInterval(300))))
            }
        }
    }
}

struct Splatoon3ShiftEntry: TimelineEntry {
    var date: Date
    var configuration: Splatoon3ShiftIntent

    var shift: Splatoon3Shift?
    var nextShift: Splatoon3Shift?
}

struct Splatoon3ShiftWidgetEntryView : View {
    var entry: Splatoon3ShiftProvider.Entry
    
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

struct Splatoon3ShiftWidget: Widget {
    let kind = "Splatoon3ShiftWidget"

    var body: some WidgetConfiguration {
        return IntentConfiguration(kind: kind, intent: Splatoon3ShiftIntent.self, provider: Splatoon3ShiftProvider()) { entry in
            Splatoon3ShiftWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("splatoon_3_shift")
        .description("splatoon_3_shift_widget_description")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct Splatoon3ShiftWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Splatoon3ShiftWidgetEntryView(entry: Splatoon3ShiftEntry(date: Date(), configuration: Splatoon3ShiftIntent(), shift: PreviewSplatoon3Shift, nextShift: PreviewSplatoon3Shift))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            Splatoon3ShiftWidgetEntryView(entry: Splatoon3ShiftEntry(date: Date(), configuration: Splatoon3ShiftIntent(), shift: PreviewSplatoon3Shift, nextShift: PreviewSplatoon3Shift))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
