//
//  MediumScheduleView.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/1/21.
//

import SwiftUI
import WidgetKit
import Kingfisher

struct MediumScheduleView: View {
    var current: Date
    var schedule: Schedule?
    var gameMode: Schedule.GameMode
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea(edges: .all)
            
            if let schedule = schedule {
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
                                    .frame(minWidth: 0)
                            }
                            
                            Spacer()
                                .frame(height: 8)
                            
                            VStack {
                                Rectangle()
                                    .fill(Color(UIColor.secondarySystemBackground))
                                    .overlay (
                                        KFImage(URL(string: schedule.stageA.url)!)
                                            .placeholder {
                                                Rectangle()
                                                    .foregroundColor(Color(UIColor.secondarySystemBackground))
                                            }
                                            .resizedToFill()
                                            .clipped()
                                            .accessibility(label: Text(schedule.stageA.description))
                                    )
                                    .cornerRadius(7.5)
                                Rectangle()
                                    .fill(Color(UIColor.secondarySystemBackground))
                                    .overlay (
                                        KFImage(URL(string: schedule.stageB.url)!)
                                            .placeholder {
                                                Rectangle()
                                                    .foregroundColor(Color(UIColor.secondarySystemBackground))
                                            }
                                            .resizedToFill()
                                            .clipped()
                                            .accessibility(label: Text(schedule.stageB.description))
                                    )
                                    .cornerRadius(7.5)
                            }
                        }
                        .frame(width: g.size.width / 2 - 5)
                        
                        Spacer()
                            .frame(width: 15)
                        
                        VStack(spacing: 0) {
                            HStack {
                                Text(timeSpanDescriptor(current: current, startTime: schedule.startTime))
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                                    .layoutPriority(1)
                                
                                Spacer()
                                
                                Text(schedule.shortDescription)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(schedule.gameMode.accentColor)
                                    .lineLimit(1)
                                    .layoutPriority(2)
                            }
                            .layoutPriority(1)
                            
                            Spacer()
                                .frame(height: 4)
                            
                            HStack {
                                Text(absoluteTimeSpan(current: current, startTime: schedule.startTime, endTime: schedule.endTime))
                                    .fontWeight(.light)
                                    .font(.largeTitle)
                                    .lineLimit(1)
                                    .layoutPriority(1)
                                
                                Spacer()
                                
                                Image(systemName: "circle.fill")
                                    .font(.footnote)
                                    .foregroundColor(schedule.gameMode.accentColor)
                                    .accessibility(label: Text(schedule.gameMode.description))
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
                                    .frame(minWidth: 0)
                            }
                        }
                    }
                }
                .padding()
            } else {
                FailedToLoadView(accentColor: gameMode.accentColor)
                    .padding()
            }
        }
    }
}

struct MediumScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        MediumScheduleView(current: Date(), schedule: SchedulePlaceholder, gameMode: SchedulePlaceholder.gameMode)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
