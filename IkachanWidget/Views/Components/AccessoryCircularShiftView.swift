import SwiftUI
import WidgetKit

@available(iOSApplicationExtension 16.0, *)
struct AccessoryCircularShiftView: View {
    @Environment(\.widgetRenderingMode) var widgetRenderingMode
    
    var progress: Double
    var mode: any ShiftMode
    var shift: Shift?
    
    var body: some View {
        Gauge(value: progress) {} currentValueLabel: {
            if let shift = shift {
                Image(shift.mode.image)
                    .symbolRenderingMode(widgetRenderingMode == .fullColor ? .multicolor : .hierarchical)
                    .widgetAccentable()
                    .padding(10)
            } else {
                Image(systemName: "xmark")
                    .resizedToFit()
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                    .padding(10)
            }
        }
        .tint(widgetRenderingMode == .fullColor ? shift?.mode.accentColor ?? mode.accentColor : .primary)
        .gaugeStyle(.accessoryCircular)
    }
}

@available(iOSApplicationExtension 17.0, watchOSApplicationExtension 10.0, *)
struct AccessoryCircularShiftView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryCircularShiftView(progress: 0.5, mode: PreviewSplatoon3Shift.mode, shift: PreviewSplatoon3Shift)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
