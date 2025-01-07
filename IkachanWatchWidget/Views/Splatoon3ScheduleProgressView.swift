import WidgetKit
import SwiftUI

struct Splatoon3ScheduleProgressView : View {
    var entry: Splatoon3ScheduleProgressProvider.Entry
    
    @ViewBuilder
    var body: some View {
        AccessoryCircularView(progress: timePassingBy(current: entry.date, start: entry.schedule?.startTime ?? entry.date, end: entry.schedule?.endTime ?? entry.date), mode: entry.schedule?.mode.image ?? nil, rule: entry.schedule?.rule.image ?? nil)
            .widgetContainerBackground(padding: false)
    }
}

struct Splatoon3ScheduleProgressView_Previews: PreviewProvider {
    static var previews: some View {
        Splatoon3ScheduleProgressView(entry: Splatoon3ScheduleEntry(date: Date(), configuration: Splatoon3ScheduleIntent(), schedule: PreviewSplatoon3Schedule))
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
