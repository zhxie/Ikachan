import SwiftUI
import WidgetKit

// HACK: Wrap WidgetEnvironmentReader on use for environments backporting.
struct MediumShiftView: View {
    var mode: any ShiftMode
    var shift: Shift?
    var nextShift: Shift?
    
    var body: some View {
        WidgetEnvironmentReader {
            MediumShiftView_Inner(mode: mode, shift: shift, nextShift: nextShift)
        }
    }
}

struct MediumShiftView_Inner: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.widgetRenderingMode_Backport) var widgetRenderingMode
    
    var mode: any ShiftMode
    var shift: Shift?
    var nextShift: Shift?

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Image(shift?.mode.image ?? mode.image)
                    .symbolRenderingMode(widgetRenderingMode == .fullColor ? .multicolor : .hierarchical)
                    .monospacedSymbol()
                    .widgetAccentable_Backport()
                    .layoutPriority(1)
                Text(LocalizedStringKey(shift?.mode.name ?? mode.name))
                    .fontWeight(.bold)
                    .foregroundColor(widgetRenderingMode == .fullColor ? (shift?.mode.accentColor ?? mode.accentColor) : .primary)
                    .widgetAccentable_Backport()
                    .lineLimit(1)
                
                Spacer()
                
                if let shift = shift {
                    Text(absoluteTimeSpan(start: shift.startTime, end: shift.endTime))
                        .monospacedDigit()
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                        .layoutPriority(1)
                }
            }
            .layoutPriority(1)
            
            if let shift = shift {
                if let stage = shift.stage {
                    HStack {
                        StageView(stage: stage)
                        
                        WeaponsView(weapons: shift.weapons!, accented: widgetRenderingMode != .fullColor)
                    }
                } else {
                    Spacer()
                }
                
                if let shift = nextShift {
                    if let stage = shift.stage {
                        HStack {
                            Text(LocalizedStringKey("next"))
                                .font(.footnote)
                                .fontWeight(.bold)
                                .foregroundColor(Color(colorScheme == .light ? .systemBackground : .black))
                                .padding(4)
                                .background {
                                    Rectangle()
                                        .fill(widgetRenderingMode == .fullColor ? shift.mode.accentColor : .primary)
                                        .cornerRadius(4)
                                        .widgetAccentable_Backport()
                                }
                                .layoutPriority(1)
                            
                            Spacer()
                            
                            Text(stage.name)
                                .font(.footnote)
                            
                            WeaponsView(weapons: shift.weapons!, accented: widgetRenderingMode != .fullColor)
                                .frame(height: 20)
                                .layoutPriority(1)
                        }
                        .layoutPriority(1)
                    }
                }
            } else {
                NoShiftView()
            }
        }
    }
}

@available(iOSApplicationExtension 17.0, *)
struct MediumShiftView_Previews: PreviewProvider {
    static var previews: some View {
        MediumShiftView(mode: Splatoon3ShiftMode.salmonRun, shift: PreviewSplatoon2Shift, nextShift: PreviewSplatoon3Shift)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
