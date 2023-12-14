import WidgetKit
import SwiftUI
import Intents

struct Splatoon2ShiftDynamicProvider: IntentTimelineProvider {
    func filterShifts(shifts: [Splatoon2Shift]) -> [Splatoon2Shift] {
        return shifts.filter { shift in
            shift.endTime > Date()
        }
    }
    
    func placeholder(in context: Context) -> Splatoon2ShiftDynamicEntry {
        Splatoon2ShiftDynamicEntry(date: Date(), configuration: Splatoon2ShiftIntent(), shift: PreviewSplatoon2Shift)
    }

    func getSnapshot(for configuration: Splatoon2ShiftIntent, in context: Context, completion: @escaping (Splatoon2ShiftDynamicEntry) -> ()) {
        fetchSplatoon2Shifts(locale: Locale.localizedLocale) { shifts, error in
            guard error == .NoError else {
                completion(Splatoon2ShiftDynamicEntry(date: Date(), configuration: configuration, shift: nil))
                
                return
            }
            
            let filtered = filterShifts(shifts: shifts)
            if !filtered.isEmpty {
                completion(Splatoon2ShiftDynamicEntry(date: Date(), configuration: configuration, shift: filtered.first!))
            } else {
                completion(Splatoon2ShiftDynamicEntry(date: Date(), configuration: configuration, shift: nil))
            }
        }
    }

    func getTimeline(for configuration: Splatoon2ShiftIntent, in context: Context, completion: @escaping (Timeline<Splatoon2ShiftDynamicEntry>) -> ()) {
        fetchSplatoon2Shifts(locale: Locale.localizedLocale) { shifts, error in
            guard error == .NoError else {
                completion(Timeline(entries: [Splatoon2ShiftDynamicEntry(date: Date(), configuration: configuration, shift: nil)], policy: .after(Date().addingTimeInterval(300))))
                
                return
            }
            
            var entries: [Splatoon2ShiftDynamicEntry] = []
            let filtered = filterShifts(shifts: shifts)
            if !filtered.isEmpty {
                var current = Date().floorToMin()
                for shift in filtered {
                    while current < shift.endTime && entries.count < MaxDynamicWidgetEntryCount {
                        let entry = Splatoon2ShiftDynamicEntry(date: current, configuration: configuration, shift: shift)
                        entries.append(entry)
                        
                        current = current.addingTimeInterval(60)
                    }
                }
                
                completion(Timeline(entries: entries, policy: .atEnd))
            } else {
                completion(Timeline(entries: [Splatoon2ShiftDynamicEntry(date: Date(), configuration: configuration, shift: nil)], policy: .after(Date().addingTimeInterval(300))))
            }
        }
    }
}

struct Splatoon2ShiftDynamicEntry: TimelineEntry {
    var date: Date
    var configuration: Splatoon2ShiftIntent

    var shift: Splatoon2Shift?
}

@available(iOSApplicationExtension 16.0, *)
struct Splatoon2ShiftDynamicWidgetEntryView : View {
    var entry: Splatoon2ShiftDynamicProvider.Entry
    
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
struct Splatoon2ShiftDynamicWidget: Widget {
    let kind = "Splatoon2ShiftDynamicWidget"

    var body: some WidgetConfiguration {
        return IntentConfiguration(kind: kind, intent: Splatoon2ShiftIntent.self, provider: Splatoon2ShiftDynamicProvider()) { entry in
            Splatoon2ShiftDynamicWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("splatoon_2_shift")
        .description("splatoon_2_shift_widget_description")
        .supportedFamilies([.accessoryCircular])
    }
}

@available(iOSApplicationExtension 16.0, *)
struct Splatoon2ShiftDynamicWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        Splatoon2ShiftDynamicWidgetEntryView(entry: Splatoon2ShiftDynamicEntry(date: Date(), configuration: Splatoon2ShiftIntent(), shift: PreviewSplatoon2Shift))
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
