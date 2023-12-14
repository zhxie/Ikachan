import SwiftUI
import WidgetKit

struct SmallShiftView: View {
    @Environment(\.showsWidgetContainerBackground) var showsWidgetContainerBackground
    
    var shift: Shift?
    var nextShift: Shift?
    
    var body: some View {
        if let shift = shift {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    HStack(alignment: .center) {
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
                
                if showsWidgetContainerBackground {
                    if let stage = shift.stage {
                        StageView(stage: stage)
                        
                        HStack {
                            ForEach(shift.weapons!, id: \.name) { weapon in
                                WeaponView(weapon: weapon)
                            }
                        }
                        .layoutPriority(1)
                    }
                } else {
                    if let stage = shift.stage {
                        Text(stage.name)
                            .lineLimit(1)
                        
                        if let shift = nextShift {
                            HStack {
                                HStack(alignment: .center) {
                                    Image(shift.mode.image)
                                        .resizedToFit()
                                        .frame(width: 12, height: 12)
                                        .layoutPriority(1)
                                    Text(LocalizedStringKey(shift.mode.name))
                                        .font(.footnote)
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
struct SmallShiftView_Previews: PreviewProvider {
    static var previews: some View {
        SmallShiftView(shift: PreviewSplatoon2Shift, nextShift: PreviewSplatoon3Shift)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
