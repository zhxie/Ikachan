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
    var mode: Mode?
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea(edges: .all)
            
            if let mode = mode {
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
                                    StageView(stage: schedule.stages[0])
                                    StageView(stage: schedule.stages[1])
                                }
                            }
                            .frame(width: g.size.width / 2 - 5)
                            
                            Spacer()
                                .frame(width: 15)
                            
                            SmallScheduleView(current: current, schedule: schedule, mode: mode, subview: true)
                        }
                    }
                    .padding()
                } else {
                    FailedToLoadView(accentColor: mode.accentColor, error: .noSchedule)
                        .padding()
                }
            } else {
                FailedToLoadView(accentColor: Color(UIColor.label), error: .failedToLoad)
                    .padding()
            }
        }
    }
}

struct MediumScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        MediumScheduleView(current: Date(), schedule: SchedulePlaceholder, mode: SchedulePlaceholder.mode)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
