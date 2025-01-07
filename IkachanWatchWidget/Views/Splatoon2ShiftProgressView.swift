import WidgetKit
import SwiftUI

struct Splatoon2ShiftProgressView : View {
    var entry: Splatoon2ShiftProgressProvider.Entry
    
    @ViewBuilder
    var body: some View {
        AccessoryCircularView(progress: timePassingBy(current: entry.date, start: entry.shift?.startTime ?? entry.date, end: entry.shift?.endTime ?? entry.date), mode: nil, rule: entry.shift?.mode.image ?? nil)
            .widgetContainerBackground(padding: false)
    }
}

struct Splatoon2ShiftProgressView_Previews: PreviewProvider {
    static var previews: some View {
        Splatoon2ShiftProgressView(entry: Splatoon2ShiftEntry(date: Date(), configuration: Splatoon2ShiftIntent(), shift: PreviewSplatoon2Shift))
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
