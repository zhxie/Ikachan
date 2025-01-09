import WidgetKit
import SwiftUI

struct Splatoon2ScheduleProgressView : View {
    var entry: Splatoon2ScheduleProgressProvider.Entry
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .accessoryCircular:
            AccessoryCircularScheduleView(progress: timePassingBy(current: entry.date, start: entry.schedule?.startTime ?? entry.date, end: entry.schedule?.endTime ?? entry.date), mode: Splatoon2ScheduleMode(from: entry.configuration.mode), schedule: entry.schedule)
                .widgetContainerBackground(padding: false)
        default:
            AccessoryCornerView(progress: timePassingBy(current: entry.date, start: entry.schedule?.startTime ?? entry.date, end: entry.schedule?.endTime ?? entry.date), accentColor: Splatoon2ScheduleMode(from: entry.configuration.mode).accentColor, icon: entry.schedule?.rule.image ?? nil)
                .widgetContainerBackground(padding: false)
        }
    }
}

struct Splatoon2ScheduleProgressView_Previews: PreviewProvider {
    static var previews: some View {
        Splatoon2ScheduleProgressView(entry: Splatoon2ScheduleEntry(date: Date(), configuration: Splatoon2ScheduleIntent(), schedule: PreviewSplatoon2Schedule))
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
