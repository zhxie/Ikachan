import WidgetKit
import SwiftUI

@available(iOSApplicationExtension 16.0, *)
struct Splatoon3ScheduleProgressView : View {
    var entry: Splatoon3ScheduleProgressProvider.Entry
    
    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        AccessoryCircularScheduleView(progress: timePassingBy(current: entry.date, start: entry.schedule?.startTime ?? entry.date, end: entry.schedule?.endTime ?? entry.date), mode: Splatoon3ScheduleMode(from: entry.configuration.mode), schedule: entry.schedule)
            .widgetContainerBackground(padding: false)
    }
}

@available(iOSApplicationExtension 16.0, *)
struct Splatoon3ScheduleProgressView_Previews: PreviewProvider {
    static var previews: some View {
        Splatoon3ScheduleProgressView(entry: Splatoon3ScheduleEntry(date: Date(), configuration: Splatoon3ScheduleIntent(), schedule: PreviewSplatoon3Schedule))
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
