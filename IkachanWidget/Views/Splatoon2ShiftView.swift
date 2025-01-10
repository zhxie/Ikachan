import WidgetKit
import SwiftUI

struct Splatoon2ShiftView : View {
    var entry: Splatoon2ShiftProvider.Entry
    
    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        if #available(iOSApplicationExtension 16.0, *) {
            switch family {
            case .accessoryRectangular:
                AccessoryRectangularShiftView(mode: Splatoon2ShiftMode.salmonRun, shift: entry.shift)
                    .widgetContainerBackground(padding: false)
            case .systemSmall:
                // StandBy widgets are only available for iOS StandBy mode.
                if #available(iOSApplicationExtension 17.0, *) {
                    StandBySelectorView {
                        SmallShiftView(mode: Splatoon2ShiftMode.salmonRun, shift: entry.shift, nextShift: entry.nextShift)
                            .widgetContainerBackground()
                    } standBy: {
                        StandByShiftView(mode: Splatoon2ShiftMode.salmonRun, shift: entry.shift)
                            .widgetContainerBackground()
                    }
                } else {
                    SmallShiftView(mode: Splatoon2ShiftMode.salmonRun, shift: entry.shift, nextShift: entry.nextShift)
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

struct Splatoon2ShiftView_Previews: PreviewProvider {
    static var previews: some View {
        Splatoon2ShiftView(entry: Splatoon2ShiftEntry(date: Date(), configuration: Splatoon2ShiftIntent(), shift: PreviewSplatoon2Shift, nextShift: PreviewSplatoon2Shift))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
