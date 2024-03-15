import SwiftUI

@main
struct IkachanWidgetBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        Splatoon3ScheduleWidget()
        Splatoon3ShiftWidget()
        Splatoon2ScheduleWidget()
        Splatoon2ShiftWidget()
        if #available(iOSApplicationExtension 16.0, *) {
            Splatoon3ScheduleDynamicWidget()
            Splatoon3ShiftDynamicWidget()
            Splatoon2ScheduleDynamicWidget()
            Splatoon2ShiftDynamicWidget()
        }
//        if #available(iOSApplicationExtension 17.0, *) {
//            Splatoon3ScheduleInteractiveWidget()
//            Splatoon2ScheduleInteractiveWidget()
//        }
    }
}
