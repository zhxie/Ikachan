import WidgetKit
import SwiftUI
import Intents

struct Splatoon3ShiftDynamicProvider: IntentTimelineProvider {
    func filterShifts(shifts: [Splatoon3Shift], mode: INSplatoon3ShiftMode) -> [Splatoon3Shift] {
        return shifts.filter { shift in
            switch mode {
            case .unknown, .salmonRunAndBigRun:
                return shift._mode == .salmonRun || shift._mode == .bigRun
            case .eggstraWork:
                return shift._mode == .eggstraWork
            }
        }.filter { shift in
            shift.endTime > Date()
        }.sorted { a, b in
            a.startTime < b.startTime
        }
    }
    
    func placeholder(in context: Context) -> Splatoon3ShiftDynamicEntry {
        Splatoon3ShiftDynamicEntry(date: Date(), configuration: Splatoon3ShiftIntent(), shift: PreviewSplatoon3Shift)
    }

    func getSnapshot(for configuration: Splatoon3ShiftIntent, in context: Context, completion: @escaping (Splatoon3ShiftDynamicEntry) -> ()) {
        fetchSplatoon3Shifts(locale: Locale.localizedLocale) { shifts, error in
            guard error == .NoError else {
                completion(Splatoon3ShiftDynamicEntry(date: Date(), configuration: configuration, shift: nil))
                
                return
            }
            
            let filtered = filterShifts(shifts: shifts, mode: configuration.mode)
            if !filtered.isEmpty {
                completion(Splatoon3ShiftDynamicEntry(date: Date(), configuration: configuration, shift: filtered.first!))
            } else {
                completion(Splatoon3ShiftDynamicEntry(date: Date(), configuration: configuration, shift: nil))
            }
        }
    }

    func getTimeline(for configuration: Splatoon3ShiftIntent, in context: Context, completion: @escaping (Timeline<Splatoon3ShiftDynamicEntry>) -> ()) {
        fetchSplatoon3Shifts(locale: Locale.localizedLocale) { shifts, error in
            guard error == .NoError else {
                completion(Timeline(entries: [Splatoon3ShiftDynamicEntry(date: Date(), configuration: configuration, shift: nil)], policy: .after(Date().addingTimeInterval(300))))
                
                return
            }
            
            var entries: [Splatoon3ShiftDynamicEntry] = []
            let filtered = filterShifts(shifts: shifts, mode: configuration.mode)
            if !filtered.isEmpty {
                var current = Date().floorToMin()
                for shift in filtered {
                    while current < shift.endTime && entries.count < MaxDynamicWidgetEntryCount {
                        let entry = Splatoon3ShiftDynamicEntry(date: current, configuration: configuration, shift: shift)
                        entries.append(entry)
                        
                        current = current.addingTimeInterval(60)
                    }
                }
                
                completion(Timeline(entries: entries, policy: .atEnd))
            } else {
                completion(Timeline(entries: [Splatoon3ShiftDynamicEntry(date: Date(), configuration: configuration, shift: nil)], policy: .after(Date().addingTimeInterval(300))))
            }
        }
    }
}

struct Splatoon3ShiftDynamicEntry: TimelineEntry {
    var date: Date
    var configuration: Splatoon3ShiftIntent

    var shift: Splatoon3Shift?
}

@available(iOSApplicationExtension 16.0, *)
struct Splatoon3ShiftDynamicWidgetEntryView : View {
    var entry: Splatoon3ShiftDynamicProvider.Entry
    
    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        if #available(iOSApplicationExtension 17.0, *) {
            AccessoryCircularView(progress: timePassingBy(current: entry.date, start: entry.shift?.startTime ?? entry.date, end: entry.shift?.endTime ?? entry.date), mode: nil, rule: entry.shift?.mode.image ?? nil)
                .containerBackground(for: .widget, content: {})
        } else {
            AccessoryCircularView(progress: timePassingBy(current: entry.date, start: entry.shift?.startTime ?? entry.date, end: entry.shift?.endTime ?? entry.date), mode: nil, rule: entry.shift?.mode.image ?? nil)
        }
    }
}

@available(iOSApplicationExtension 16.0, *)
struct Splatoon3ShiftDynamicWidget: Widget {
    let kind = "Splatoon3ShiftDynamicWidget"

    var body: some WidgetConfiguration {
        return IntentConfiguration(kind: kind, intent: Splatoon3ShiftIntent.self, provider: Splatoon3ShiftDynamicProvider()) { entry in
            Splatoon3ShiftDynamicWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("splatoon_3_shift")
        .description("splatoon_3_shift_widget_description")
        .supportedFamilies([.accessoryCircular])
    }
}

@available(iOSApplicationExtension 16.0, *)
struct Splatoon3ShiftDynamicWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        Splatoon3ShiftDynamicWidgetEntryView(entry: Splatoon3ShiftDynamicEntry(date: Date(), configuration: Splatoon3ShiftIntent(), shift: PreviewSplatoon3Shift))
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
