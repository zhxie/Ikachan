import WidgetKit
import SwiftUI

@available(iOSApplicationExtension 16.0, *)
struct Splatoon2ScheduleProgressView : View {
    var entry: Splatoon2ScheduleProgressProvider.Entry
    
    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        AccessoryCircularView(progress: timePassingBy(current: entry.date, start: entry.schedule?.startTime ?? entry.date, end: entry.schedule?.endTime ?? entry.date), mode: entry.schedule?.mode.image ?? nil, accentColor: entry.schedule?.mode.accentColor ?? nil, rule: entry.schedule?.rule.image ?? nil)
            .widgetContainerBackground(padding: false)
    }
}

@available(iOSApplicationExtension 16.0, *)
struct Splatoon2ScheduleProgressView_Previews: PreviewProvider {
    static var previews: some View {
        Splatoon2ScheduleProgressView(entry: Splatoon2ScheduleEntry(date: Date(), configuration: Splatoon2ScheduleIntent(), schedule: PreviewSplatoon2Schedule))
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
