//
//  ScheduleView.swift
//  Ikachan
//
//  Created by Sketch on 2023/12/11.
//

import SwiftUI

struct ScheduleView: View {
    var schedule: Schedule
    var backgroundColor = Color(.secondarySystemBackground)
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image(schedule.rule.image)
                    .resizedToFit()
                    .frame(width: 16, height: 16)
                    .layoutPriority(1)
                Text(LocalizedStringKey(schedule.challenge ?? schedule.rule.name))
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                Spacer()
                
                Text(timeSpan(start: schedule.startTime, end: schedule.endTime))
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .layoutPriority(1)
            }
            HStack {
                ForEach(schedule.stages, id: \.name) { stage in
                    StageView(stage: stage, backgroundColor: backgroundColor)
                }
            }
        }
    }
}

#Preview {
    ScheduleView(schedule: PreviewSplatoon2Schedule)
}
