import SwiftUI

@main
struct IkachanWidgetBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        Splatoon3ScheduleWidget()
        Splatoon3ShiftWidget()
        Splatoon2ScheduleWidget()
        Splatoon2ShiftWidget()
        if #available(iOS 16.1, *) {
            Splatoon3ScheduleDynamicWidget()
            Splatoon3ShiftDynamicWidget()
            Splatoon2ScheduleDynamicWidget()
            Splatoon2ShiftDynamicWidget()
        }
    }
}
