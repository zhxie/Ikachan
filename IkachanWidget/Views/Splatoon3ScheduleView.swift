import WidgetKit
import SwiftUI

struct Splatoon3ScheduleView : View {
    var entry: Splatoon3ScheduleProvider.Entry
    
    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        if #available(iOSApplicationExtension 16.0, *) {
            switch family {
            case .accessoryRectangular:
                AccessoryRectangularScheduleView(mode: Splatoon3ScheduleMode(from: entry.configuration.mode), schedule: entry.schedule)
                    .widgetContainerBackground(padding: false)
            case .systemSmall:
                // StandBy widgets are only available for iOS StandBy mode.
                if #available(iOSApplicationExtension 17.0, *) {
                    StandBySelectorView {
                        SmallScheduleView(mode: Splatoon3ScheduleMode(from: entry.configuration.mode), schedule: entry.schedule, nextSchedule: entry.nextSchedule)
                            .widgetContainerBackground()
                    } standBy: {
                        StandByScheduleView(mode: Splatoon3ScheduleMode(from: entry.configuration.mode), schedule: entry.schedule)
                            .widgetContainerBackground()
                    }
                } else {
                    SmallScheduleView(mode: Splatoon3ScheduleMode(from: entry.configuration.mode), schedule: entry.schedule, nextSchedule: entry.nextSchedule)
                        .widgetContainerBackground()
                }
            default:
                MediumScheduleView(mode: Splatoon3ScheduleMode(from: entry.configuration.mode), schedule: entry.schedule, nextSchedule: entry.nextSchedule)
                    .widgetContainerBackground()
            }
        } else {
            switch family {
            case .systemSmall:
                SmallScheduleView(mode: Splatoon3ScheduleMode(from: entry.configuration.mode), schedule: entry.schedule, nextSchedule: entry.nextSchedule)
                    .padding()
            default:
                MediumScheduleView(mode: Splatoon3ScheduleMode(from: entry.configuration.mode), schedule: entry.schedule, nextSchedule: entry.nextSchedule)
                    .padding()
            }
        }
    }
}

struct Splatoon3ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        Splatoon3ScheduleView(entry: Splatoon3ScheduleEntry(date: Date(), configuration: Splatoon3ScheduleIntent(), schedule: PreviewSplatoon3Schedule, nextSchedule: PreviewSplatoon3Schedule))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
