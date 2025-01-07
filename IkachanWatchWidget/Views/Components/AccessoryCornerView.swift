import SwiftUI
import WidgetKit

struct AccessoryCornerView: View {
    var progress: Double
    var mode: Color
    var rule: String?
    
    var body: some View {
        VStack {
            if let rule = rule {
                Image(rule)
                    .resizedToFit()
                    .padding(4)
            } else {
                Image(systemName: "xmark")
                    .resizedToFit()
                    .fontWeight(.bold)
                    .padding(6)
            }
        }
        .widgetLabel {
            Gauge(value: progress) {}
                .tint(mode)
                .gaugeStyle(.linearCapacity)
        }
    }
}

@available(watchOSApplicationExtension 10.0, *)
struct AccessoryCornerView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryCornerView(progress: 0.5, mode: PreviewSplatoon3Schedule.mode.accentColor, rule: PreviewSplatoon3Schedule.rule.image)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .accessoryCorner))
    }
}
