import SwiftUI
import WidgetKit

struct SmallShiftView: View {
    var shift: Shift?
    var nextShift: Shift?
    
    var body: some View {
        if let shift = shift {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    HStack {
                        Image(shift.mode.image)
                            .resizedToFit()
                            .frame(width: 16, height: 16)
                            .layoutPriority(1)
                        Text(LocalizedStringKey(shift.mode.name))
                            .fontWeight(.bold)
                            .foregroundColor(shift.mode.accentColor)
                            .lineLimit(1)
                    }
                    .layoutPriority(1)
                    
                    Spacer()
                        .frame(minWidth: 0)
                }
                .layoutPriority(1)
                
                if let stage = shift.stage {
                    StageView(stage: stage, style: .Widget)
                    
                    WeaponsView(weapons: shift.weapons!, style: .Widget)
                        .layoutPriority(1)
                }
            }
        } else {
            Text(LocalizedStringKey("no_shift"))
        }
    }
}

@available(iOSApplicationExtension 17.0, *)
struct SmallShiftView_Previews: PreviewProvider {
    static var previews: some View {
        SmallShiftView(shift: PreviewSplatoon2Shift, nextShift: PreviewSplatoon3Shift)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
