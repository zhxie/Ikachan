import SwiftUI

@main
struct IkachanWidgetBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        Splatoon3ScheduleWidget()
        Splatoon3ShiftWidget()
        Splatoon2ScheduleWidget()
        Splatoon2ShiftWidget()
        Splatoon3ScheduleProgressWidget()
        Splatoon3ShiftProgressWidget()
        Splatoon2ScheduleProgressWidget()
        Splatoon2ShiftProgressWidget()
    }
}
