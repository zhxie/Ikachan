import SwiftUI
import WidgetKit

@available(iOSApplicationExtension 16.0, *)
struct StandbyShiftView: View {
    @Environment(\.widgetRenderingMode) var widgetRenderingMode
    
    var shift: Shift?
    var nextShift: Shift?
    
    var body: some View {
        if let shift = shift {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    HStack {
                        Text(LocalizedStringKey(shift.mode.name))
                            .fontWeight(.bold)
                            .foregroundColor(widgetRenderingMode == .fullColor ? shift.mode.accentColor : .white)
                    }
                    .layoutPriority(1)
                    
                    Spacer()
                        .frame(minWidth: 0)
                }
                .layoutPriority(1)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .top) {
                        Image(shift.mode.image)
                            .resizedToFit()
                            .frame(width: 16, height: 16)
                            .layoutPriority(1)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            if let stage = shift.stage {
                                Text(stage.name)
                                    .font(.footnote)
                                    .lineLimit(1)
                            }
                            
                            VStack(alignment: .leading, spacing: 1) {
                                if let weapons = shift.weapons {
                                    ForEach(weapons, id: \.name) { weapon in
                                        Text(weapon.name)
                                            .font(.caption2)
                                            .lineLimit(1)
                                    }
                                }
                            }
                        }
                    }
                    
                    if let shift = nextShift {
                        HStack(alignment: .top) {
                            Image(shift.mode.image)
                                .resizedToFit()
                                .frame(width: 16, height: 16)
                                .layoutPriority(1)
                            
                            if let stage = shift.stage {
                                Text(stage.name)
                                    .font(.footnote)
                                    .lineLimit(1)
                            }
                        }
                    }
                }
            }
        } else {
            Text(LocalizedStringKey("no_shift"))
        }
    }
}

@available(iOSApplicationExtension 17.0, *)
struct StandbyShiftView_Previews: PreviewProvider {
    static var previews: some View {
        StandbyShiftView(shift: PreviewSplatoon2Shift, nextShift: PreviewSplatoon3Shift)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
