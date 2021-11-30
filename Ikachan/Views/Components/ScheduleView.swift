//
//  ScheduleView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/18.
//

import SwiftUI

struct ScheduleView: View {
    let schedule: Schedule
    
    var body: some View {
        ScheduleBaseView(title: schedule.rule.description, subtitle: status(startTime: schedule.startTime, endTime: schedule.endTime), image: schedule.rule.rawValue) {
            HStack {
                StageView(image: schedule.stageA.url, title: schedule.stageA.description)
                StageView(image: schedule.stageB.url, title: schedule.stageB.description)
            }
        }
    }
    
    func status(startTime: Date, endTime: Date) -> String {
        let current = Date()
        
        if startTime < current {
            return naturalTimeSpan(startTime: startTime, endTime: endTime)
        } else {
            return scheduleTimePeriod(startTime: startTime, endTime: endTime)
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(schedule: SchedulePlaceholder)
    }
}
