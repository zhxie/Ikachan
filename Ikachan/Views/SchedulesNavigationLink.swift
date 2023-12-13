//
//  SchedulesNavigationLink.swift
//  Ikachan
//
//  Created by Sketch on 2023/12/12.
//

import SwiftUI

struct SchedulesNavigationLink: View {
    var schedules: [Schedule]
    
    var body: some View {
        NavigationLink {
            SchedulesView(mode: schedules.first!.mode, schedules: schedules)
        } label: {
            CardView(image: schedules.first!.mode.image, name: schedules.first!.mode.name) {
                ScheduleView(schedule: schedules.first!)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    SchedulesNavigationLink(schedules: [PreviewSplatoon2Schedule, PreviewSplatoon3Schedule])
}
