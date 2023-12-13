//
//  IkachanWidgetBundle.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/1/24.
//

import SwiftUI

@main
struct IkachanWidgetBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        Splatoon3ScheduleWidget()
        Splatoon3ShiftWidget()
        Splatoon2ScheduleWidget()
        Splatoon2ShiftWidget()
    }
}
