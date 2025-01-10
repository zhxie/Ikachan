import WidgetKit
import SwiftUI

struct Splatoon3ShiftView : View {
    var entry: Splatoon3ShiftProvider.Entry
    
    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        if #available(iOSApplicationExtension 16.0, *) {
            switch family {
            case .accessoryRectangular:
                AccessoryRectangularShiftView(mode: Splatoon3ShiftMode(from: entry.configuration.mode), shift: entry.shift)
                    .widgetContainerBackground(padding: false)
            case .systemSmall:
                // StandBy widgets are only available for iOS StandBy mode.
                if #available(iOSApplicationExtension 17.0, *) {
                    StandBySelectorView {
                        SmallShiftView(mode: Splatoon3ShiftMode(from: entry.configuration.mode), shift: entry.shift, nextShift: entry.nextShift)
                            .widgetContainerBackground()
                    } standBy: {
                        StandByShiftView(mode: Splatoon3ShiftMode(from: entry.configuration.mode), shift: entry.shift)
                            .widgetContainerBackground()
                    }
                } else {
                    SmallShiftView(mode: Splatoon3ShiftMode(from: entry.configuration.mode), shift: entry.shift, nextShift: entry.nextShift)
                        .widgetContainerBackground()
                }
            default:
                MediumShiftView(mode: Splatoon3ShiftMode(from: entry.configuration.mode), shift: entry.shift, nextShift: entry.nextShift)
                    .widgetContainerBackground()
            }
        } else {
            switch family {
            case .systemSmall:
                SmallShiftView(mode: Splatoon3ShiftMode(from: entry.configuration.mode), shift: entry.shift, nextShift: entry.nextShift)
                    .padding()
            default:
                MediumShiftView(mode: Splatoon3ShiftMode(from: entry.configuration.mode), shift: entry.shift, nextShift: entry.nextShift)
                    .padding()
            }
        }
    }
}

struct Splatoon3ShiftView_Previews: PreviewProvider {
    static var previews: some View {
        Splatoon3ShiftView(entry: Splatoon3ShiftEntry(date: Date(), configuration: Splatoon3ShiftIntent(), shift: PreviewSplatoon3Shift, nextShift: PreviewSplatoon3Shift))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
