//
//  SmallDayView.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/1/24.
//

import SwiftUI
import WidgetKit

struct SmallDayView: View {
    var current: Date
    var schedule: Schedule?
    
    var body: some View {
        ZStack {
            ZStack {
                switch hour {
                case 5..<7:
                    LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hex: "e8cab4"), location: 0), Gradient.Stop(color: Color(hex: "6ea7d8"), location: 0.69)]), startPoint: .bottom, endPoint: .top)
                case 7..<9:
                    LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hex: "95d5d7"), location: 0), Gradient.Stop(color: Color(hex: "53b5ee"), location: 0.86)]), startPoint: .bottom, endPoint: .top)
                case 9..<11:
                    LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hex: "6fcbff"), location: 0), Gradient.Stop(color: Color(hex: "53b0ec"), location: 1)]), startPoint: .bottom, endPoint: .top)
                case 11..<13:
                    LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hex: "5fbaf4"), location: 0), Gradient.Stop(color: Color(hex: "52afee"), location: 0.95)]), startPoint: .bottom, endPoint: .top)
                case 13..<15:
                    LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hex: "5fbaf4"), location: 0), Gradient.Stop(color: Color(hex: "3494d5"), location: 0.97)]), startPoint: .bottom, endPoint: .top)
                case 15..<17:
                    LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hex: "b0c8e8"), location: 0), Gradient.Stop(color: Color(hex: "5cb8f3"), location: 0.66), Gradient.Stop(color: Color(hex: "339ee7"), location: 0.97)]), startPoint: .bottom, endPoint: .top)
                case 17..<19:
                    LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hex: "f5d6bc"), location: 0), Gradient.Stop(color: Color(hex: "dbb0be"), location: 0.26), Gradient.Stop(color: Color(hex: "4a94d3"), location: 1)]), startPoint: .bottom, endPoint: .top)
                case 19..<21:
                    LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hex: "bea1c4"), location: 0), Gradient.Stop(color: Color(hex: "617db6"), location: 0.49), Gradient.Stop(color: Color(hex: "326eb2"), location: 0.99)]), startPoint: .bottom, endPoint: .top)
                case 21..<23:
                    LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hex: "0c2442"), location: 0), Gradient.Stop(color: Color(hex: "3f638e"), location: 0.98)]), startPoint: .bottom, endPoint: .top)
                case 23..<25, -1..<1:
                    LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hex: "152437"), location: 0), Gradient.Stop(color: Color(hex: "3b506b"), location: 1)]), startPoint: .bottom, endPoint: .top)
                case 1..<3:
                    LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hex: "060e19"), location: 0.07), Gradient.Stop(color: Color(hex: "11253c"), location: 0.81)]), startPoint: .bottom, endPoint: .top)
                case 3..<5:
                    LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hex: "5f82c2"), location: 0), Gradient.Stop(color: Color(hex: "152437"), location: 0.89)]), startPoint: .bottom, endPoint: .top)
                default:
                    Color(.black)
                }
            }
            .ignoresSafeArea(edges: .all)
            
            if let schedule = schedule {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        TopLeadingView(text: LocalizedStringKey(timeSpanDescriptor(current: current, startTime: schedule.startTime)), color: .white)
                            .layoutPriority(1)
                        
                        Spacer()
                        
                        TopTrailingView(text: schedule.shortDescription, color: .white)
                            .layoutPriority(2)
                    }
                    .layoutPriority(1)
                    
                    Spacer()
                        .frame(height: 4)
                        .layoutPriority(1)
                    
                    HStack {
                        Text(timeSpan(current: current, startTime: schedule.startTime, endTime: schedule.endTime))
                            .fontWeight(.light)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .layoutPriority(1)
                        
                        Spacer()
                        
                        Image(systemName: icon)
                            .font(.footnote)
                            .foregroundColor(Color(red: 247 / 255, green: 209 / 255, blue: 87 / 255))
                            .accessibility(label: Text(LocalizedStringKey(iconText)))
                    }
                    .layoutPriority(1)
                    
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            BottomView(text: schedule.stageA.description, color: .white)
                            BottomView(text: schedule.stageB.description, color: .white)
                        }
                        .layoutPriority(1)
                        
                        Spacer()
                            .frame(minWidth: 0)
                    }
                }
                .padding()
            } else {
                FailedToLoadView(accentColor: .white)
                    .padding()
            }
            
        }
    }
    
    var hour: Int {
        Calendar.current.component(.hour, from: current)
    }
    
    var isDay: Bool {
        return hour >= 5 && hour < 19
    }
    
    var icon: String {
        if isDay {
            return "circle.fill"
        } else {
            return "moon.fill"
        }
    }
    
    var iconText: String {
        if isDay {
            return "in_the_day"
        } else {
            return "at_night"
        }
    }
}

struct SmallDayView_Previews: PreviewProvider {
    static var previews: some View {
        SmallDayView(current: Date(), schedule: SchedulePlaceholder)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
