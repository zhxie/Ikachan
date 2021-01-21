//
//  MediumScheduleView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/21.
//

import SwiftUI

struct MediumScheduleView: View {
    var schedule: Schedule
    
    var body: some View {
        GeometryReader { g in
            HStack {
                VStack(spacing: 0) {
                    HStack {
                        Text(scheduleTimePeriod(startTime: schedule.startTime, endTime: schedule.endTime))
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                            .layoutPriority(1)
                        
                        Spacer()
                    }
                    
                    Spacer()
                        .frame(height: 8)
                    
                    VStack {
                        Rectangle()
                            .fill(Color(UIColor.systemGroupedBackground))
                            .cornerRadius(7.5)
                        Rectangle()
                            .fill(Color(UIColor.systemGroupedBackground))
                            .cornerRadius(7.5)
                    }
                }
                .frame(width: g.size.width / 2 - 10)
                
                Spacer()
                    .frame(width: 20)
                
                VStack(spacing: 0) {
                    HStack {
                        Text(time.0)
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
                    .layoutPriority(1)
                    
                    Spacer()
                        .frame(height: 4)
                    
                    HStack {
                        Text(time.1)
                            .fontWeight(.light)
                            .font(.largeTitle)
                            .lineLimit(1)
                            .layoutPriority(1)
                        
                        Spacer()
                        
                        Circle()
                            .fill(schedule.gameMode.accentColor)
                            .frame(width: 13, height: 13)
                    }
                    .layoutPriority(1)
                    
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Text(schedule.stageA.description)
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                            
                            Spacer()
                                .frame(height: 2)
                            
                            Text(schedule.stageB.description)
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                        }
                        .layoutPriority(1)
                        
                        Spacer()
                    }
                }
            }
        }
        .padding()
    }
    
    var time: (LocalizedStringKey, String) {
        naturalTimeSpan2(startTime: schedule.startTime, endTime: schedule.endTime)
    }
}

struct MediumScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        let modelData = ModelData()
        
        let asset = NSDataAsset(name: "schedules", bundle: Bundle.main)!
        
        _ = modelData.loadSchedules(data: asset.data)
        
        return MediumScheduleView(schedule: modelData.schedules[0])
            .previewLayout(.fixed(width: 360, height: 169))
    }
}
