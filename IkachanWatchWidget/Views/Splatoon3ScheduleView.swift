import WidgetKit
import SwiftUI

struct Splatoon3ScheduleView : View {
    var entry: Splatoon3ScheduleProvider.Entry
    
    @ViewBuilder
    var body: some View {
        AccessoryRectangularScheduleView(mode: Splatoon3ScheduleMode(from: entry.configuration.mode), schedule: entry.schedule)
            .widgetContainerBackground(padding: false)

    }
}

struct Splatoon3ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        Splatoon3ScheduleView(entry: Splatoon3ScheduleEntry(date: Date(), configuration: Splatoon3ScheduleIntent(), schedule: PreviewSplatoon3Schedule, nextSchedule: PreviewSplatoon3Schedule))
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
    }
}
