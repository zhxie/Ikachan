import SwiftUI
import WidgetKit

@available(iOSApplicationExtension 16.0, *)
struct StandbyShiftView: View {
    @Environment(\.widgetRenderingMode) var widgetRenderingMode
    
    var mode: any ShiftMode
    var shift: Shift?
    var nextShift: Shift?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                HStack {
                    Text(LocalizedStringKey(mode.name))
                        .fontWeight(.bold)
                        .foregroundColor(widgetRenderingMode == .fullColor ? mode.accentColor : .white)
                }
                .layoutPriority(1)
                
                Spacer()
                    .frame(minWidth: 0)
            }
            .layoutPriority(1)
            
            if let shift = shift {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .top) {
                        Image(shift.mode.image)
                            .symbolRenderingMode(.multicolor)
                            .font(.footnote)
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
                                .symbolRenderingMode(.multicolor)
                                .font(.footnote)
                                .layoutPriority(1)
                            
                            if let stage = shift.stage {
                                Text(stage.name)
                                    .font(.footnote)
                                    .lineLimit(1)
                            }
                        }
                    }
                }
            } else {
                Text(LocalizedStringKey("no_shifts"))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

@available(iOSApplicationExtension 17.0, *)
struct StandbyShiftView_Previews: PreviewProvider {
    static var previews: some View {
        StandbyShiftView(mode: Splatoon3ShiftMode.salmonRun, shift: PreviewSplatoon2Shift, nextShift: PreviewSplatoon3Shift)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
