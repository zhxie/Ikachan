//
//  SchedulesView.swift
//  Ikachan
//
//  Created by Sketch on 2023/12/12.
//

import SwiftUI

struct SchedulesView: View {
    var mode: any ScheduleMode
    var schedules: [Schedule]
    
    var body: some View {
        List {
            ForEach(schedules, id: \.startTime) { schedule in
                ScheduleView(schedule: schedule, backgroundColor: Color(.secondarySystemGroupedBackground))
            }
        }
        .navigationTitle(LocalizedStringKey(mode.name))
    }
}

#Preview {
    SchedulesView(mode: Splatoon2ScheduleMode.regularBattle, schedules: [PreviewSplatoon2Schedule, PreviewSplatoon3Schedule])
}
