import SwiftUI
import WidgetKit

// HACK: Wrap WidgetEnvironmentReader on use for environments backporting.
struct SmallShiftView: View {
    var mode: any ShiftMode
    var shift: Shift?
    var nextShift: Shift?
    
    var body: some View {
        WidgetEnvironmentReader {
            SmallShiftView_Inner(mode: mode, shift: shift, nextShift: nextShift)
        }
    }
}

struct SmallShiftView_Inner: View {
    @Environment(\.widgetRenderingMode_Backport) var widgetRenderingMode
    
    var mode: any ShiftMode
    var shift: Shift?
    var nextShift: Shift?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                HStack {
                    Image(shift?.mode.image ?? mode.image)
                        .symbolRenderingMode(widgetRenderingMode == .fullColor ? .multicolor : .hierarchical)
                        .monospacedSymbol()
                        .widgetAccentable_Backport()
                    Text(LocalizedStringKey(shift?.mode.name ?? mode.name))
                        .fontWeight(.bold)
                        .foregroundColor(widgetRenderingMode == .fullColor ? (shift?.mode.accentColor ?? mode.accentColor) : .primary)
                        .widgetAccentable_Backport()
                        .lineLimit(1)
                }
                .layoutPriority(1)
                
                Spacer()
                    .frame(minWidth: 0)
            }
            .layoutPriority(1)
            
            if let shift = shift {
                if let stage = shift.stage {
                    StageView(stage: stage)
                    
                    WeaponsView(weapons: shift.weapons!, accented: widgetRenderingMode != .fullColor)
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
