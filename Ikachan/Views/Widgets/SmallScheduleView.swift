//
//  SmallScheduleView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/21.
//

import SwiftUI

struct SmallScheduleView: View {
    var current: Date
    var schedule: Schedule?
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea(edges: .all)
            
            GeometryReader { g in
                VStack(spacing: 0) {
                    HStack {
                        Text(scheduleTimePeriod(startTime: schedule?.startTime ?? Date(timeIntervalSince1970: 0), endTime: schedule?.endTime ?? Date(timeIntervalSince1970: 0)))
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                            .layoutPriority(1)
                        
                        Spacer()
                        
                        Text(schedule?.rule.shortDescription ?? "")
                            .font(.caption)
                            .foregroundColor(schedule?.gameMode.accentColor ?? Color.accentColor)
                            .lineLimit(1)
                            .layoutPriority(2)
                    }
                    .layoutPriority(1)
                    
                    if g.size.height > 126 {
                        Spacer()
                            .frame(height: 8)
                            .layoutPriority(1)
                        
                        Rectangle()
                            .fill(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(7.5)
                            .layoutPriority(1)
                        
                        Spacer()
                            .frame(height: 2)
                            .layoutPriority(1)
                    } else {
                        Spacer()
                            .frame(height: 4)
                            .layoutPriority(1)
                    }
                    
                    HStack {
                        Text(timeSpan(current: current, startTime: schedule?.startTime ?? Date(), endTime: schedule?.endTime ?? Date()))
                            .fontWeight(.light)
                            .font(.largeTitle)
                            .lineLimit(1)
                            .layoutPriority(1)
                        
                        Spacer()
                        
                        Image(systemName: "circle.fill")
                            .font(.footnote)
                            .foregroundColor(schedule?.gameMode.accentColor ?? Color.accentColor)
                    }
                    .layoutPriority(1)
                    
                    if g.size.height <= 126 {
                        Spacer()
                    }
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(schedule?.stageA.description ?? "")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                            Text(schedule?.stageB.description ?? "")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                        }
                        .layoutPriority(1)
                        
                        Spacer()
                    }
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
        
        return Group {
            SmallScheduleView(current: Date(), schedule: modelData.schedules[0])
                .previewLayout(.fixed(width: 169, height: 169))
            SmallScheduleView(current: Date(), schedule: modelData.schedules[0])
                .previewLayout(.fixed(width: 141, height: 141))
        }
    }
}
