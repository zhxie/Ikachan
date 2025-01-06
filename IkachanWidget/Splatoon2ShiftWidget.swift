import WidgetKit
import SwiftUI
import Intents
import Kingfisher

struct Splatoon2ShiftProvider: IntentTimelineProvider {
    func filterShifts(shifts: [Splatoon2Shift]) -> [Splatoon2Shift] {
        return shifts.filter { schedule in
            schedule.endTime > Date()
        }
    }
    
    func placeholder(in context: Context) -> Splatoon2ShiftEntry {
        Splatoon2ShiftEntry(date: Date(), configuration: Splatoon2ShiftIntent(), shift: PreviewSplatoon2Shift, nextShift: PreviewSplatoon2Shift)
    }

    func getSnapshot(for configuration: Splatoon2ShiftIntent, in context: Context, completion: @escaping (Splatoon2ShiftEntry) -> ()) {
        fetchSplatoon2Shifts(locale: Locale.localizedLocale) { shifts, error in
            guard error == .NoError else {
                completion(Splatoon2ShiftEntry(date: Date(), configuration: configuration, shift: nil))
                
                return
            }
            
            let filtered = filterShifts(shifts: shifts)
            if !filtered.isEmpty {
                var entry = Splatoon2ShiftEntry(date: Date(), configuration: configuration, shift: filtered.first!)
                var urls: Set<URL> = []
                if let stage = filtered.first!.stage {
                    urls.insert(stage.thumbnail ?? stage.image)
                    for weapon in filtered.first!.weapons! {
                        urls.insert(weapon.thumbnail ?? weapon.image)
                    }
                }
                if filtered.count > 1 {
                    entry.nextShift = filtered.at(index: 1)!
                    if let weapons = filtered.at(index: 1)!.weapons {
                        for weapon in weapons {
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
            let filtered = filterShifts(shifts: shifts)
            if !filtered.isEmpty {
                for i in 0..<MaxShiftWidgetEntryCount {
                    if filtered.count <= i {
                        break
                    }
                    var entry = Splatoon2ShiftEntry(date: i == 0 ? Date() : filtered.at(index: i)!.startTime, configuration: configuration, shift: filtered.at(index: i)!)
                    if filtered.at(index: i)!.stage != nil {
                        for weapon in filtered.at(index: i)!.weapons! {
                            urls.insert(weapon.thumbnail ?? weapon.image)
                        }
                    }
                    if (filtered.count > i + 1) {
                        entry.nextShift = filtered.at(index: i + 1)!
                        if let weapons = filtered.at(index: i + 1)!.weapons {
                            for weapon in weapons {
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
    @Environment(\.showsWidgetContainerBackground) var showsWidgetContainerBackground

    @ViewBuilder
    var body: some View {
        if #available(iOSApplicationExtension 16.0, *) {
            switch family {
            case .accessoryRectangular:
                AccessoryRectangularShiftView(mode: Splatoon2ShiftMode.salmonRun, shift: entry.shift)
                    .widgetContainerBackground(padding: false)
            case .systemSmall:
                if showsWidgetContainerBackground {
                    SmallShiftView(mode: Splatoon2ShiftMode.salmonRun, shift: entry.shift, nextShift: entry.nextShift)
                        .widgetContainerBackground()
                } else {
                    StandbyShiftView(mode: Splatoon2ShiftMode.salmonRun, shift: entry.shift, nextShift: entry.nextShift)
                        .widgetContainerBackground()
                }
            default:
                MediumShiftView(mode: Splatoon2ShiftMode.salmonRun, shift: entry.shift, nextShift: entry.nextShift)
                    .widgetContainerBackground()
            }
        } else {
            switch family {
            case .systemSmall:
                SmallShiftView(mode: Splatoon2ShiftMode.salmonRun, shift: entry.shift, nextShift: entry.nextShift)
                    .padding()
            default:
                MediumShiftView(mode: Splatoon2ShiftMode.salmonRun, shift: entry.shift, nextShift: entry.nextShift)
                    .padding()
            }
        }
    }
}

struct Splatoon2ShiftWidget: Widget {
    let kind = "Splatoon2ShiftWidget"
    
    var supportedFamilies: [WidgetFamily] {
        if #available(iOSApplicationExtension 16.0, *) {
            return [.systemSmall, .systemMedium, .accessoryRectangular]
        } else {
            return [.systemSmall, .systemMedium]
        }
    }

    var body: some WidgetConfiguration {
        return IntentConfiguration(kind: kind, intent: Splatoon2ShiftIntent.self, provider: Splatoon2ShiftProvider()) { entry in
            Splatoon2ShiftWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("splatoon_2_shift")
        .description("splatoon_2_shift_widget_description")
        .supportedFamilies(supportedFamilies)
    }
}

struct Splatoon2ShiftWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        Splatoon2ShiftWidgetEntryView(entry: Splatoon2ShiftEntry(date: Date(), configuration: Splatoon2ShiftIntent(), shift: PreviewSplatoon2Shift, nextShift: PreviewSplatoon2Shift))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
