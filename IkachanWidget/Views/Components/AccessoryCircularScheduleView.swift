import SwiftUI
import WidgetKit

@available(iOSApplicationExtension 16.0, *)
struct AccessoryCircularScheduleView: View {
    @Environment(\.widgetRenderingMode) var widgetRenderingMode
    
    var progress: Double
    var mode: any ScheduleMode
    var schedule: Schedule?
    
    var body: some View {
        Gauge(value: progress) {
            Image(mode.image)
                .symbolRenderingMode(widgetRenderingMode == .fullColor ? .multicolor : .hierarchical)
                .foregroundColor(widgetRenderingMode == .fullColor ? mode.accentColor : .primary)
                .widgetAccentable()
        } currentValueLabel: {
            if let schedule = schedule {
                Image(schedule.rule.image)
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
        .tint(widgetRenderingMode == .fullColor ? mode.accentColor : .primary)
        .gaugeStyle(.accessoryCircular)
    }
}

@available(iOSApplicationExtension 17.0, watchOSApplicationExtension 10.0, *)
struct AccessoryCircularScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryCircularScheduleView(progress: 0.5, mode: PreviewSplatoon3Schedule.mode, schedule: PreviewSplatoon3Schedule)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
