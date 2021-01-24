//
//  IkachanWidgetBundle.swift
//  ScheduleWidgetExtension
//
//  Created by Sketch on 2021/1/24.
//

import SwiftUI

@main
struct IkachanWidgetBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        ScheduleWidget()
        ShiftWidget()
    }
}
