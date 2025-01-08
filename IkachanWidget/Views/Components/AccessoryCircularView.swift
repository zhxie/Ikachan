import SwiftUI
import WidgetKit

@available(iOSApplicationExtension 16.0, *)
struct AccessoryCircularView: View {
    var progress: Double
    var mode: String?
    var accentColor: Color?
    var rule: String?
    
    var body: some View {
        Gauge(value: progress) {
            if let mode = mode {
                Image(mode)
                    .symbolRenderingMode(.multicolor)
                    .accentColor(accentColor)
            }
        } currentValueLabel: {
            if let rule = rule {
                Image(rule)
                    .symbolRenderingMode(.multicolor)
                    .padding(10)
            } else {
                Image(systemName: "xmark")
                    .resizedToFit()
                    .fontWeight(.bold)
                    .padding(10)
            }
        }
        .gaugeStyle(.accessoryCircular)
    }
}

@available(iOSApplicationExtension 17.0, watchOSApplicationExtension 10.0, *)
struct AccessoryCircularView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryCircularView(progress: 0.5, mode: PreviewSplatoon3Schedule.mode.image, accentColor: PreviewSplatoon3Schedule.mode.accentColor, rule: PreviewSplatoon3Schedule.rule.image)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
