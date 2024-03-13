import SwiftUI

@main
struct IkachanWidgetBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        if #available(iOSApplicationExtension 16.0, *) {
            Splatoon3ScheduleDynamicWidget()
        }
        Splatoon3ScheduleWidget()
        if #available(iOSApplicationExtension 17.0, *) {
            Splatoon3ScheduleInteractiveWidget()
        }
        if #available(iOSApplicationExtension 16.0, *) {
            Splatoon3ShiftDynamicWidget()
        }
        Splatoon3ShiftWidget()
        if #available(iOSApplicationExtension 16.0, *) {
            Splatoon2ScheduleDynamicWidget()
        }
        Splatoon2ScheduleWidget()
        if #available(iOSApplicationExtension 17.0, *) {
            Splatoon2ScheduleInteractiveWidget()
        }
        if #available(iOSApplicationExtension 16.0, *) {
            Splatoon2ShiftDynamicWidget()
        }
        Splatoon2ShiftWidget()
    }
}
