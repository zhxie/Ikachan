import WidgetKit
import SwiftUI

struct Splatoon2ShiftView : View {
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
                // Standby widgets are only available for iOS StandBy mode and iPadOS lockscreen widget in landscape mode.
                if #available(iOSApplicationExtension 17.0, *) {
                    if showsWidgetContainerBackground {
                        SmallShiftView(mode: Splatoon2ShiftMode.salmonRun, shift: entry.shift, nextShift: entry.nextShift)
                            .widgetContainerBackground()
                    } else {
                        StandbyShiftView(mode: Splatoon2ShiftMode.salmonRun, shift: entry.shift, nextShift: entry.nextShift)
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
