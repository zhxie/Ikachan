import WidgetKit
import SwiftUI

@available(iOSApplicationExtension 16.0, *)
struct Splatoon3ShiftProgressView : View {
    var entry: Splatoon3ShiftProgressProvider.Entry
    
    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        AccessoryCircularShiftView(progress: timePassingBy(current: entry.date, start: entry.shift?.startTime ?? entry.date, end: entry.shift?.endTime ?? entry.date), mode: Splatoon3ShiftMode(from: entry.configuration.mode), shift: entry.shift)
            .widgetContainerBackground(padding: false)
    }
}

@available(iOSApplicationExtension 16.0, *)
struct Splatoon3ShiftProgressView_Previews: PreviewProvider {
    static var previews: some View {
        Splatoon3ShiftProgressView(entry: Splatoon3ShiftEntry(date: Date(), configuration: Splatoon3ShiftIntent(), shift: PreviewSplatoon3Shift))
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
