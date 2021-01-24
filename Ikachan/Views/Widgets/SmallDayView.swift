//
//  SmallDayView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/24.
//

import SwiftUI

struct SmallDayView: View {
    var current: Date
    var schedule: Schedule?
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea(edges: .all)
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text(timeSpanDescriptor(current: current, startTime: schedule?.startTime ?? current))
                        .font(.caption2)
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .layoutPriority(1)
                    
                    Spacer()
                        .frame(minWidth: 0)
                    
                    Text(schedule?.rule.shorterDescription ?? "")
                        .font(.caption)
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .layoutPriority(2)
                }
                .layoutPriority(1)
                
                Spacer()
                    .frame(height: 4)
                    .layoutPriority(1)
                
                HStack {
                    Text(timeSpan(current: current, startTime: schedule?.startTime ?? Date(), endTime: schedule?.endTime ?? Date()))
                        .fontWeight(.light)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .layoutPriority(1)
                    
                    Spacer()
                    
                    Image(systemName: icon)
                        .font(.footnote)
                        .foregroundColor(Color(red: 247 / 255, green: 209 / 255, blue: 87 / 255))
                        .accessibility(label: Text(iconText))
                }
                .layoutPriority(1)
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(schedule?.stageA.description ?? "")
                            .font(.caption)
                            .foregroundColor(.white)
                            .lineLimit(1)
                        Text(schedule?.stageB.description ?? "")
                            .font(.caption)
                            .foregroundColor(.white)
                            .lineLimit(1)
                    }
                    .layoutPriority(1)
                    
                    Spacer()
                }
            }
            .padding()
        }
    }
    
    var isDay: Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        
        let hourString = dateFormatter.string(from: current)
        
        let hour = Int(hourString)!
        
        return hour >= 6 && hour <= 18
    }
    
    var icon: String {
        if isDay {
            return "circle.fill"
        } else {
            return "moon.fill"
        }
    }
    
    var iconText: LocalizedStringKey {
        if isDay {
            return "in_the_day"
        } else {
            return "at_night"
        }
    }
}

struct SmallDayView_Previews: PreviewProvider {
    static var previews: some View {
        let modelData = ModelData()
        
        let asset = NSDataAsset(name: "schedules", bundle: Bundle.main)!
        
        _ = modelData.loadSchedules(data: asset.data)
        
        return Group {
            SmallDayView(current: Date(), schedule: modelData.schedules[0]).previewLayout(.fixed(width: 169, height: 169))
            SmallDayView(current: Date(), schedule: modelData.schedules[0]).previewLayout(.fixed(width: 141, height: 141))
        }
    }
}
