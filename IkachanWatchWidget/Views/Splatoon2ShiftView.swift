import WidgetKit
import SwiftUI

struct Splatoon2ShiftView : View {
    var entry: Splatoon2ShiftProvider.Entry
    
    @ViewBuilder
    var body: some View {
        AccessoryRectangularShiftView(mode: Splatoon2ShiftMode.salmonRun, shift: entry.shift)
            .widgetContainerBackground(padding: false)
    }
}

struct Splatoon2ShiftView_Previews: PreviewProvider {
    static var previews: some View {
        Splatoon2ShiftView(entry: Splatoon2ShiftEntry(date: Date(), configuration: Splatoon2ShiftIntent(), shift: PreviewSplatoon2Shift, nextShift: PreviewSplatoon2Shift))
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
    }
}
