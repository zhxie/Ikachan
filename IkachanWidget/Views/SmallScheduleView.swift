//
//  SmallScheduleView.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/1/21.
//

import SwiftUI
import WidgetKit

struct SmallScheduleView: View {
    let current: Date
    let schedule: Schedule?
    let gameMode: Schedule.GameMode
    var subview: Bool = false
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea(edges: .all)
            
            if let schedule = schedule {
                SmallBaseView(text: absoluteTimeSpan(current: current, startTime: schedule.startTime, endTime: schedule.endTime), indicatorText: schedule.gameMode.description, color: schedule.gameMode.accentColor) {
                    HStack {
                        VStack(alignment: .leading) {
                            BottomView(text: schedule.stageA.description)
                            BottomView(text: schedule.stageB.description)
                        }
                        .layoutPriority(1)
                        
                        Spacer()
                            .frame(minWidth: 0)
                    }
                } leadingLeft: {
                    if subview {
                        TopLeadingView(text: LocalizedStringKey(timeSpanDescriptor(current: current, startTime: schedule.startTime)))
                    } else {
                        TopLeadingView(text: scheduleTimePeriod(startTime: schedule.startTime, endTime: schedule.endTime))
                    }
                } leadingRight: {
                    TopTrailingView(text: subview ? schedule.rule.shortDescription : schedule.rule.shorterDescription, color: schedule.gameMode.accentColor)
                }
                .padding(subview ? [] : [.all])
            } else {
                FailedToLoadView(accentColor: gameMode.accentColor)
                    .padding()
            }
        }
    }
}

struct SmallScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        SmallScheduleView(current: Date(), schedule: SchedulePlaceholder, gameMode: SchedulePlaceholder.gameMode)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
