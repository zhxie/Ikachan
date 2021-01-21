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
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea(edges: .all)
            
            VStack(spacing: 0) {
                HStack {
                    Text(scheduleTimePeriod(startTime: schedule.startTime, endTime: schedule.endTime))
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                        .layoutPriority(1)
                    
                    Spacer()
                    
                    Text(schedule.rule.shortDescription)
                        .font(.caption)
                        .foregroundColor(schedule.gameMode.accentColor)
                        .lineLimit(1)
                }
                
                Spacer()
                    .frame(height: 8)
                
                Rectangle()
                    .fill(Color(UIColor.secondarySystemBackground))
                    .frame(height: 48)
                    .cornerRadius(7.5)
                
                Spacer()
                    .frame(height: 2)
                
                HStack {
                    Text(timeSpan(startTime: schedule.startTime, endTime: schedule.endTime))
                        .fontWeight(.light)
                        .font(.largeTitle)
                        .lineLimit(1)
                        .layoutPriority(1)
                    
                    Spacer()
                    
                    Image(systemName: "circle.fill")
                        .font(.footnote)
                        .foregroundColor(schedule.gameMode.accentColor)
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(schedule.stageA.description)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                        Text(schedule.stageB.description)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                    .layoutPriority(1)
                    
                    Spacer()
                }
            }
            .padding()
        }
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
