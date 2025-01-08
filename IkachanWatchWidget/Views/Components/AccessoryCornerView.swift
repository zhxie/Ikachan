import SwiftUI
import WidgetKit

struct AccessoryCornerView: View {
    var progress: Double
    var accentColor: Color
    var rule: String?
    
    var body: some View {
        ZStack {
            AccessoryWidgetBackground()
            if let rule = rule {
                Image(rule)
                    .symbolRenderingMode(.multicolor)
                    .font(.title)
            } else {
                Image(systemName: "xmark")
                    .font(.title)
                    .fontWeight(.bold)
            }
        }
        .widgetLabel {
            Gauge(value: progress) {}
                .tint(accentColor)
        }
    }
}

@available(watchOSApplicationExtension 10.0, *)
struct AccessoryCornerView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryCornerView(progress: 0.5, accentColor: PreviewSplatoon3Schedule.mode.accentColor, rule: PreviewSplatoon3Schedule.rule.image)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .accessoryCorner))
    }
}
