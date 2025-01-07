import WidgetKit
import SwiftUI

struct Splatoon3ShiftView : View {
    var entry: Splatoon3ShiftProvider.Entry
    
    @ViewBuilder
    var body: some View {
        AccessoryRectangularShiftView(mode: Splatoon3ShiftMode(from: entry.configuration.mode), shift: entry.shift)
            .widgetContainerBackground(padding: false)
    }
}

struct Splatoon3ShiftView_Previews: PreviewProvider {
    static var previews: some View {
        Splatoon3ShiftView(entry: Splatoon3ShiftEntry(date: Date(), configuration: Splatoon3ShiftIntent(), shift: PreviewSplatoon3Shift, nextShift: PreviewSplatoon3Shift))
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
    }
}
