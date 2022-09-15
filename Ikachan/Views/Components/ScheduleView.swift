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
        ScheduleBaseView(title: schedule.rule.name, subtitle: status(startTime: schedule.startTime, endTime: schedule.endTime), image: schedule.rule.image) {
            HStack {
                StageView(stage: schedule.stages[0])
                StageView(stage: schedule.stages[1])
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
