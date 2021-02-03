//
//  MediumScheduleView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/21.
//

import SwiftUI
import Kingfisher

struct MediumScheduleView: View {
    var current: Date
    var schedule: Schedule?
    var gameMode: Schedule.GameMode
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea(edges: .all)
            
            if schedule != nil {
                GeometryReader { g in
                    HStack {
                        VStack(spacing: 0) {
                            HStack {
                                Text(scheduleTimePeriod(startTime: schedule?.startTime ?? Date(timeIntervalSince1970: 0), endTime: schedule?.endTime ?? Date(timeIntervalSince1970: 0)))
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
                                    .fill(Color(UIColor.secondarySystemBackground))
                                    .overlay (
                                        KFImage(URL(string: schedule?.stageA.url ?? "")!)
                                            .placeholder {
                                                Rectangle()
                                                    .foregroundColor(Color(UIColor.secondarySystemBackground))
                                            }
                                            .resizable()
                                            .accessibility(label: Text(schedule?.stageA.description ?? ""))
                                            .aspectRatio(contentMode: .fill)
                                            .clipped()
                                    )
                                    .cornerRadius(7.5)
                                Rectangle()
                                    .fill(Color(UIColor.secondarySystemBackground))
                                    .overlay (
                                        KFImage(URL(string: schedule?.stageB.url ?? "")!)
                                            .placeholder {
                                                Rectangle()
                                                    .foregroundColor(Color(UIColor.secondarySystemBackground))
                                            }
                                            .resizable()
                                            .accessibility(label: Text(schedule?.stageB.description ?? ""))
                                            .aspectRatio(contentMode: .fill)
                                            .clipped()
                                    )
                                    .cornerRadius(7.5)
                            }
                        }
                        .frame(width: g.size.width / 2 - 5)
                        
                        Spacer()
                            .frame(width: 15)
                        
                        VStack(spacing: 0) {
                            HStack {
                                Text(timeSpanDescriptor(current: current, startTime: schedule?.startTime ?? current))
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                                    .layoutPriority(1)
                                
                                Spacer()
                                
                                Text(schedule?.rule.shortDescription ?? "")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(schedule?.gameMode.accentColor ?? Color.accentColor)
                                    .lineLimit(1)
                                    .layoutPriority(2)
                            }
                            .layoutPriority(1)
                            
                            Spacer()
                                .frame(height: 4)
                            
                            HStack {
                                Text(absoluteTimeSpan(current: current, startTime: schedule?.startTime ?? current, endTime: schedule?.endTime ?? current))
                                    .fontWeight(.light)
                                    .font(.largeTitle)
                                    .lineLimit(1)
                                    .layoutPriority(1)
                                
                                Spacer()
                                
                                Image(systemName: "circle.fill")
                                    .accessibility(label: Text(schedule?.gameMode.longDescription ?? ""))
                                    .font(.footnote)
                                    .foregroundColor(schedule?.gameMode.accentColor ?? Color.accentColor)
                            }
                            .layoutPriority(1)
                            
                            Spacer()
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text(schedule?.stageA.description ?? "")
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                        .lineLimit(1)
                                    
                                    Spacer()
                                        .frame(height: 2)
                                    
                                    Text(schedule?.stageB.description ?? "")
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
            } else {
                FailedToLoadView(accentColor: gameMode.accentColor)
                    .padding()
            }
        }
    }
}

struct MediumScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MediumScheduleView(current: Date(), schedule: SchedulePlaceholder, gameMode: SchedulePlaceholder.gameMode)
                .previewLayout(.fixed(width: 360, height: 169))
            MediumScheduleView(current: Date(), schedule: SchedulePlaceholder, gameMode: SchedulePlaceholder.gameMode)
                .previewLayout(.fixed(width: 291, height: 141))
        }
    }
}