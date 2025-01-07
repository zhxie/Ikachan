import WidgetKit
import SwiftUI

struct Splatoon2ScheduleView : View {
    var entry: Splatoon2ScheduleProvider.Entry

    @ViewBuilder
    var body: some View {
        AccessoryRectangularScheduleView(mode: Splatoon2ScheduleMode(from: entry.configuration.mode), schedule: entry.schedule)
            .widgetContainerBackground(padding: false)
    }
}

struct Splatoon2ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        Splatoon2ScheduleView(entry: Splatoon2ScheduleEntry(date: Date(), configuration: Splatoon2ScheduleIntent(), schedule: PreviewSplatoon2Schedule, nextSchedule: PreviewSplatoon2Schedule))
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
    }
}
