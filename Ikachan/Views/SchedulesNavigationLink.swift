import SwiftUI

struct SchedulesNavigationLink: View {
    var schedules: [Schedule]
    
    var body: some View {
        NavigationLink {
            SchedulesView(mode: schedules.first!.mode, schedules: schedules)
        } label: {
            CardView(image: schedules.first!.mode.image, name: schedules.first!.mode.name) {
                ScheduleView(schedule: schedules.first!, nextSchedule: schedules.at(index: 1))
            }
        }
        .buttonStyle(CardButtonStyle())
    }
}

#Preview {
    SchedulesNavigationLink(schedules: [PreviewSplatoon2Schedule, PreviewSplatoon3Schedule])
}
