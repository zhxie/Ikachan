//
//  ScheduleView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/18.
//

import SwiftUI

struct ScheduleView: View {
    var schedule: Schedule
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(schedule.rule.description)
                        .font(.title2)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Text(status(startTime: schedule.startTime, endTime: schedule.endTime))
                        .font(.callout)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                .layoutPriority(1)
                
                Spacer()
                
                Image(schedule.rule.rawValue)
                    .resizedToFit()
                    .frame(width: 50, height: 50)
            }
            
            ScheduleImages(imageA: schedule.stageA.url, titleA: schedule.stageA.description, imageB: schedule.stageB.url, titleB: schedule.stageB.description)
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
