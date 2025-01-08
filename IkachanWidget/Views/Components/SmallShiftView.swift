import SwiftUI
import WidgetKit

struct SmallShiftView: View {
    var mode: any ShiftMode
    var shift: Shift?
    var nextShift: Shift?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                HStack {
                    Image(shift?.mode.image ?? mode.image)
                        .resizedToFit()
                        .frame(width: 16, height: 16)
                        .layoutPriority(1)
                    Text(LocalizedStringKey(shift?.mode.name ?? mode.name))
                        .fontWeight(.bold)
                        .foregroundColor(mode.accentColor)
                        .lineLimit(1)
                }
                .layoutPriority(1)
                
                Spacer()
                    .frame(minWidth: 0)
            }
            .layoutPriority(1)
            
            if let shift = shift {
                if let stage = shift.stage {
                    StageView(stage: stage, style: .Widget)
                    
                    WeaponsView(weapons: shift.weapons!, style: .Widget)
                        .layoutPriority(1)
                }
            } else {
                NoShiftView()
            }
        }
    }
}

@available(iOSApplicationExtension 17.0, *)
struct SmallShiftView_Previews: PreviewProvider {
    static var previews: some View {
        SmallShiftView(mode: Splatoon3ShiftMode.salmonRun, shift: PreviewSplatoon2Shift, nextShift: PreviewSplatoon3Shift)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
