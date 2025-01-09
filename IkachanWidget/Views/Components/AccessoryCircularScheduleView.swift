import SwiftUI
import WidgetKit

@available(iOSApplicationExtension 16.0, *)
struct AccessoryCircularScheduleView: View {
    var progress: Double
    var mode: any ScheduleMode
    var schedule: Schedule?
    
    var body: some View {
        Gauge(value: progress) {
            Image(mode.image)
                .symbolRenderingMode(.multicolor)
                .accentColor(mode.accentColor)
        } currentValueLabel: {
            if let schedule = schedule {
                Image(schedule.rule.image)
                    .symbolRenderingMode(.multicolor)
                    .padding(10)
            } else {
                Image(systemName: "xmark")
                    .resizedToFit()
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                    .padding(10)
            }
        }
        .tint(mode.accentColor)
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
