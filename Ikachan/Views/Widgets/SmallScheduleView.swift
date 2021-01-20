//
//  SmallScheduleView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/21.
//

import SwiftUI

struct SmallScheduleView: View {
    var schedule: Schedule
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(scheduleTimePeriod(startTime: schedule.startTime, endTime: schedule.endTime))
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .layoutPriority(1)
                
                Spacer()
                
                Text(schedule.rule.shortDescription)
                    .foregroundColor(schedule.gameMode.accentColor)
                    .font(.caption)
            }
            
            Spacer()
                .frame(height: 8)
            
            Rectangle()
                .fill(Color(UIColor.systemGroupedBackground))
                .frame(height: 48)
                .cornerRadius(7.5)
            
            Spacer()
                .frame(height: 2)
            
            HStack {
                Text(timeSpan(startTime: schedule.startTime, endTime: schedule.endTime))
                    .fontWeight(.light)
                    .font(.largeTitle)
                    .layoutPriority(1)
                
                Spacer()
                
                Circle()
                    .fill(schedule.gameMode.accentColor)
                    .frame(width: 10, height: 10)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(schedule.stageA.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(schedule.stageB.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .layoutPriority(1)
                
                Spacer()
            }
        }
        .padding()
    }
}

struct SmallScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        let modelData = ModelData()
        
        let asset = NSDataAsset(name: "schedules", bundle: Bundle.main)!
        
        _ = modelData.loadSchedules(data: asset.data)
        
        return SmallScheduleView(schedule: modelData.schedules[0])
            .previewLayout(.fixed(width: 169, height: 169))
    }
}
