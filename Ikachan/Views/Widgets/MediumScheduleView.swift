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
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea(edges: .all)
            
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
                            Rectangle()
                                .fill(Color(UIColor.secondarySystemBackground))
                                .overlay (
                                    KFImage(URL(string: Splatnet2URL + (schedule?.stageB.image ?? ""))!)
                                        .placeholder {
                                            Rectangle()
                                                .foregroundColor(Color(UIColor.secondarySystemBackground))
                                        }
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                        .accessibility(label: Text(schedule?.stageB.description ?? ""))
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
                                .frame(minWidth: 0)
                            
                            Text(schedule?.rule.shortDescription ?? "")
                                .font(.caption)
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
                                .font(.footnote)
                                .foregroundColor(schedule?.gameMode.accentColor ?? Color.accentColor)
                                .accessibility(label: Text(schedule?.gameMode.longDescription ?? ""))
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
        }
    }
}

struct MediumScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        let modelData = ModelData()
        
        let asset = NSDataAsset(name: "schedules", bundle: Bundle.main)!
        
        _ = modelData.loadSchedules(data: asset.data)
        
        return Group {
            MediumScheduleView(current: Date(), schedule: modelData.schedules[0])
                .previewLayout(.fixed(width: 360, height: 169))
            MediumScheduleView(current: Date(), schedule: modelData.schedules[0])
                .previewLayout(.fixed(width: 291, height: 141))
        }
    }
}