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
            ZStack {
                switch hour {
                case 0..<5:
                    Midnight()
                case 5..<7:
                    Dawn()
                case 7..<9:
                    Daylight()
                case 9..<15:
                    Daylight()
                case 15..<17:
                    SunSet()
                case 17..<19:
                    Dusk()
                case 19..<24, 24:
                    Nightfall()
                default:
                    Daylight()
                }
            }
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
                        .fontWeight(.bold)
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
    
    var hour: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        
        let hourString = dateFormatter.string(from: current)
        
        return Int(hourString)!
    }
    
    var isDay: Bool {
        return hour >= 6 && hour < 18
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

struct Dawn: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(red: 138 / 255, green: 172 / 255, blue: 207 / 255), Color(red: 232 / 255, green: 202 / 255, blue: 181 / 255)]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea(edges: .all)
    }
}

struct Daylight: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(red: 120 / 255, green: 178 / 255, blue: 234 / 255), Color(red: 115 / 255, green: 204 / 255, blue: 253 / 255)]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea(edges: .all)
    }
}

struct SunSet: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(red: 46 / 255, green: 129 / 255, blue: 178 / 255), Color(red: 202 / 255, green: 186 / 255, blue: 203 / 255)]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea(edges: .all)
    }
}

struct Dusk: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(red: 27 / 255, green: 63 / 255, blue: 137 / 255), Color(red: 164 / 255, green: 158 / 255, blue: 196 / 255)]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea(edges: .all)
    }
}

struct Nightfall: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(red: 81 / 255, green: 117 / 255, blue: 144 / 255), Color(red: 13 / 255, green: 36 / 255, blue: 65 / 255)]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea(edges: .all)
    }
}

struct Midnight: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(red: 13 / 255, green: 36 / 255, blue: 65 / 255), Color(red: 22 / 255, green: 36 / 255, blue: 54 / 255)]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea(edges: .all)
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
