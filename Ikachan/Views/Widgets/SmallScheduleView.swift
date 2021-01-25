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
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea(edges: .all)
            
            GeometryReader { g in
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text(g.size.width >= CompactSmallWidgetSafeWidth ? scheduleTimePeriod(startTime: schedule?.startTime ?? Date(timeIntervalSince1970: 0), endTime: schedule?.endTime ?? Date(timeIntervalSince1970: 0)) : scheduleTimePeriod2(startTime: schedule?.startTime ?? Date(timeIntervalSince1970: 0), endTime: schedule?.endTime ?? Date(timeIntervalSince1970: 0)))
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                            .accessibility(label: Text(scheduleTimePeriod(startTime: schedule?.startTime ?? Date(timeIntervalSince1970: 0), endTime: schedule?.endTime ?? Date(timeIntervalSince1970: 0))))
                            .layoutPriority(1)
                        
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
                                KFImage(URL(string: Splatnet2URL + (schedule?.stageA.image ?? ""))!)
                                    .placeholder {
                                        Rectangle()
                                            .foregroundColor(Color(UIColor.secondarySystemBackground))
                                    }
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                                    .accessibility(label: Text(schedule?.stageA.description ?? ""))
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
                            .font(.footnote)
                            .foregroundColor(schedule?.gameMode.accentColor ?? Color.accentColor)
                            .accessibility(label: Text(schedule?.gameMode.longDescription ?? ""))
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
        }
    }
}

struct SmallScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SmallScheduleView(current: Date(timeIntervalSince1970: 60), schedule: SchedulePlaceholder)
                .previewLayout(.fixed(width: 169, height: 169))
            SmallScheduleView(current: Date(timeIntervalSince1970: 60), schedule: SchedulePlaceholder)
                .previewLayout(.fixed(width: 141, height: 141))
        }
    }
}
