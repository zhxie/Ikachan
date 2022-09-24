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
    let mode: Mode?
    var subview = false
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea(edges: .all)
            
            if let schedule = schedule {
                SmallBaseView(text: absoluteTimeSpan(current: current, startTime: schedule.startTime, endTime: schedule.endTime), indicatorText: schedule.mode.name, color: schedule.mode.accentColor) {
                    HStack {
                        VStack(alignment: .leading) {
                            BottomView(text: schedule.stages[0].name)
                            BottomView(text: schedule.stages[1].name)
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
                    TopTrailingView(text: subview ? schedule.localizedShorterDescription : schedule.rule.shorterName, color: schedule.mode.accentColor)
                }
                .padding(subview ? [] : [.all])
            } else {
                FailedToLoadView(accentColor: mode?.accentColor ?? Color(UIColor.label), error: .noSchedule)
                    .padding()
            }
        }
    }
}

struct SmallScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        SmallScheduleView(current: Date(), schedule: SchedulePlaceholder, mode: SchedulePlaceholder.mode)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
