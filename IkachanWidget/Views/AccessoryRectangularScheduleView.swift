//
//  AccessoryRectangularScheduleView.swift
//  IkachanWidget
//
//  Created by Sketch on 2022/9/18.
//

import SwiftUI

struct AccessoryRectangularScheduleView: View {
    var schedule: Schedule?
    
    var body: some View {
        if let schedule = schedule {
            AccessoryRectangularBaseView(image: schedule.rule.image, title: schedule.localizedShorterDescription, text: schedule.stages[0].name, text2: schedule.stages[1].name)
        } else {
            FailedToLoadView(accentColor: .white, transparent: true)
        }
    }
}

struct AccessoryRectangularScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryRectangularScheduleView(schedule: SchedulePlaceholder)
    }
}
