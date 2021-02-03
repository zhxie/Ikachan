//
//  SmallScheduleView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/21.
//

import SwiftUI
import Kingfisher

struct SmallScheduleView: View {
    var current: Date
    var schedule: Schedule?
    var gameMode: Schedule.GameMode
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea(edges: .all)
            
            if schedule != nil {
                GeometryReader { g in
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Text(g.size.width >= CompactSmallWidgetSafeWidth ? scheduleTimePeriod(startTime: schedule?.startTime ?? Date(timeIntervalSince1970: 0), endTime: schedule?.endTime ?? Date(timeIntervalSince1970: 0)) : scheduleTimePeriod2(startTime: schedule?.startTime ?? Date(timeIntervalSince1970: 0), endTime: schedule?.endTime ?? Date(timeIntervalSince1970: 0)))
                                .accessibility(label: Text(scheduleTimePeriod(startTime: schedule?.startTime ?? Date(timeIntervalSince1970: 0), endTime: schedule?.endTime ?? Date(timeIntervalSince1970: 0))))
                                .layoutPriority(1)
                                .font(.caption2)
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                            
                            Spacer()
                            
                            Text((g.size.width >= CompactSmallWidgetSafeWidth ? schedule?.rule.shortDescription : schedule?.rule.shorterDescription) ?? "")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(schedule?.gameMode.accentColor ?? Color.accentColor)
                                .lineLimit(1)
                                .layoutPriority(2)
                        }
                        .layoutPriority(1)
                        
                        if g.size.width >= 137 {
                            Spacer()
                                .frame(height: 8)
                                .layoutPriority(1)
                            
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
                                .accessibility(label: Text(schedule?.gameMode.longDescription ?? ""))
                                .font(.footnote)
                                .foregroundColor(schedule?.gameMode.accentColor ?? Color.accentColor)
                        }
                        .layoutPriority(1)
                        
                        if g.size.height < IPhone12ProMaxSmallWidgetSafeWidth {
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
            } else {
                FailedToLoadView(accentColor: gameMode.accentColor)
                    .padding()
            }
            
        }
    }
}

struct SmallScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SmallScheduleView(current: Date(), schedule: SchedulePlaceholder, gameMode: SchedulePlaceholder.gameMode)
                .previewLayout(.fixed(width: 169, height: 169))
            SmallScheduleView(current: Date(), schedule: SchedulePlaceholder, gameMode: SchedulePlaceholder.gameMode)
                .previewLayout(.fixed(width: 141, height: 141))
        }
    }
}