import WidgetKit
import SwiftUI

struct Splatoon2ScheduleView : View {
    var entry: Splatoon2ScheduleProvider.Entry
    
    @Environment(\.widgetFamily) var family
    @Environment(\.showsWidgetContainerBackground) var showsWidgetContainerBackground

    @ViewBuilder
    var body: some View {
        if #available(iOSApplicationExtension 16.0, *) {
            switch family {
            case .accessoryRectangular:
                AccessoryRectangularScheduleView(mode: Splatoon2ScheduleMode(from: entry.configuration.mode), schedule: entry.schedule)
                    .widgetContainerBackground(padding: false)
            case .systemSmall:
                if showsWidgetContainerBackground {
                    SmallScheduleView(mode: Splatoon2ScheduleMode(from: entry.configuration.mode), schedule: entry.schedule, nextSchedule: entry.nextSchedule)
                        .widgetContainerBackground()
                } else {
                    StandbyScheduleView(mode: Splatoon2ScheduleMode(from: entry.configuration.mode), schedule: entry.schedule, nextSchedule: entry.nextSchedule)
                        .widgetContainerBackground()
                }
            default:
                MediumScheduleView(mode: Splatoon2ScheduleMode(from: entry.configuration.mode), schedule: entry.schedule, nextSchedule: entry.nextSchedule)
                    .widgetContainerBackground()
            }
        } else {
            switch family {
            case .systemSmall:
                SmallScheduleView(mode: Splatoon2ScheduleMode(from: entry.configuration.mode), schedule: entry.schedule, nextSchedule: entry.nextSchedule)
                    .padding()
            default:
                MediumScheduleView(mode: Splatoon2ScheduleMode(from: entry.configuration.mode), schedule: entry.schedule, nextSchedule: entry.nextSchedule)
                    .padding()
            }
        }
    }
}

struct Splatoon2ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        Splatoon2ScheduleView(entry: Splatoon2ScheduleEntry(date: Date(), configuration: Splatoon2ScheduleIntent(), schedule: PreviewSplatoon2Schedule, nextSchedule: PreviewSplatoon2Schedule))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
