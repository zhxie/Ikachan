//
//  MediumScheduleView.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/1/21.
//

import SwiftUI
import WidgetKit

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
                                TopLeadingView(text: scheduleTimePeriod(startTime: schedule.startTime, endTime: schedule.endTime))
                                    .layoutPriority(1)
                                
                                Spacer()
                                    .frame(minWidth: 0)
                            }
                            
                            Spacer()
                                .frame(height: 8)
                            
                            VStack {
                                StageView(image: schedule.stageA.url, title: schedule.stageA.description)
                                StageView(image: schedule.stageB.url, title: schedule.stageB.description)
                            }
                        }
                        .frame(width: g.size.width / 2 - 5)
                        
                        Spacer()
                            .frame(width: 15)
                        
                        SmallScheduleView(current: current, schedule: schedule, gameMode: gameMode, subview: true)
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
