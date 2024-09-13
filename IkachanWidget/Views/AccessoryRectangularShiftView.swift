import SwiftUI
import WidgetKit

@available(iOSApplicationExtension 16.0, *)
struct AccessoryRectangularShiftView: View {
    var shift: Shift?
    
    var body: some View {
        if let shift = shift {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    HStack(spacing: 4) {
                        Image(shift.mode.image)
                            .resizedToFit()
                            .frame(width: 16, height: 16)
                        
                        if let stage = shift.stage {
                            Text(stage.name)
                                .font(.headline)
                                .fontWeight(.bold)
                                .lineLimit(1)
                        } else {
                            Text(LocalizedStringKey(shift.mode.name))
                                .font(.headline)
                                .fontWeight(.bold)
                                .lineLimit(1)
                        }
                    }
                    
                    if let weapons = shift.weapons {
                        WeaponsView(weapons: weapons, style: .Widget)
                    }
                }
                .layoutPriority(1)
                
                Spacer()
                    .frame(minWidth: 0)
            }
        } else {
            Text(LocalizedStringKey("no_shift"))
        }
    }
}

@available(iOSApplicationExtension 17.0, *)
struct AccessoryRectangularShiftView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryRectangularShiftView(shift: PreviewSplatoon3Shift)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
    }
}
