import SwiftUI
import WidgetKit

@available(iOSApplicationExtension 16.0, *)
struct AccessoryRectangularShiftView: View {
    var mode: any ShiftMode
    var shift: Shift?
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                HStack(spacing: 4) {
                    Image(mode.image)
                        .symbolRenderingMode(.multicolor)
                        .font(.headline)
                    
                    if let stage = shift?.stage {
                        Text(stage.name)
                            .font(.headline)
                            .fontWeight(.bold)
                            .lineLimit(1)
                    } else {
                        Text(LocalizedStringKey(mode.name))
                            .font(.headline)
                            .fontWeight(.bold)
                            .lineLimit(1)
                    }
                }
                
                if let shift = shift {
                    if let weapons = shift.weapons {
                        WeaponsView(weapons: weapons, style: .Widget)
                    }
                } else {
                    NoShiftView()
                }
            }
            .layoutPriority(1)
            
            Spacer()
                .frame(minWidth: 0)
        }
    }
}

@available(iOSApplicationExtension 17.0, watchOSApplicationExtension 10.0, *)
struct AccessoryRectangularShiftView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryRectangularShiftView(mode: Splatoon3ShiftMode.salmonRun, shift: PreviewSplatoon3Shift)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
    }
}
