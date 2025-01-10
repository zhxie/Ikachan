import SwiftUI
import WidgetKit
import Kingfisher

@available(iOSApplicationExtension 17.0, *)
struct StandByShiftView: View {
    @Environment(\.widgetRenderingMode) var widgetRenderingMode
    @Environment(\.widgetContentMargins) var widgetContentMargins
    
    var mode: any ShiftMode
    var shift: Shift?
    
    var body: some View {
        VStack(alignment: .leading) {
            // HACK: To occupy horizontal space in advance.
            HStack {
                Spacer()
            }
            
            Spacer()
                .frame(minHeight: 0)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    Image(shift?.mode.image ?? mode.image)
                        .symbolRenderingMode(.hierarchical)
                        .monospacedSymbol(.footnote)
                    
                    Text(LocalizedStringKey(shift?.stage?.name ?? mode.shortName))
                        .font(.footnote)
                        .fontWeight(.bold)
                        .lineLimit(1)
                }
                
                if let shift = shift {
                    if let weapons = shift.weapons {
                        WeaponsView(weapons: weapons, style: .StandbyWidget)
                            .frame(height: 24)
                    }
                } else {
                    Text(LocalizedStringKey("no_schedules"))
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            .padding([.leading, .bottom], 8)
        }
        .background {
            if let stage = shift?.stage {
                KFImage(stage.thumbnail ?? stage.image)
                    .resizedToFill()
                    .clipped()
                    .brightness(widgetRenderingMode == .fullColor ? -0.25 : -0.75)
                    .accessibilityLabel(stage.name)
                    .padding(-widgetContentMargins)
            }
        }
    }
}

@available(iOSApplicationExtension 17.0, *)
struct StandByShiftView_Previews: PreviewProvider {
    static var previews: some View {
        StandByShiftView(mode: Splatoon3ShiftMode.salmonRun, shift: PreviewSplatoon2Shift)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
