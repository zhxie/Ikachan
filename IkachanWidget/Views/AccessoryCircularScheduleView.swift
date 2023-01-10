//
//  AccessoryCircularScheduleView.swift
//  IkachanWidget
//
//  Created by Sketch on 2022/9/18.
//

import SwiftUI

struct AccessoryCircularScheduleView: View {
    let current: Date
    let schedule: Schedule?
    let mode: Mode?
    
    var body: some View {
        if let mode = mode {
            AccessoryCircularBaseView(value: percent, image: schedule?.rule.image ?? "inkling_splatted", text: mode.shorterName)
        } else {
            AccessoryCircularBaseView(value: 0, image: "inkling_splatted", text: "error")
        }
        
    }
    
    var percent: Double {
        guard let schedule = schedule else {
            return 0
        }
        
        let current = current - schedule.startTime
        let total = schedule.endTime - schedule.startTime
        return min(max(current / total, 0), 1)
    }
}

struct AccessoryCircularScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryCircularScheduleView(current: Date(), schedule: SchedulePlaceholder, mode: Splatoon2ScheduleMode.regular)
    }
}
