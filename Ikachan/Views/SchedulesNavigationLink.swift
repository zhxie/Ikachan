import SwiftUI

struct SchedulesNavigationLink: View {
    var schedules: [Schedule]
    
    var body: some View {
        NavigationLink {
            SchedulesView(mode: schedules.first!.mode, schedules: schedules)
        } label: {
            CardView(image: schedules.first!.mode.image, accentColor: schedules.first!.mode.accentColor, name: schedules.first!.mode.name) {
                ScheduleView(schedule: schedules.first!, nextSchedule: schedules.suffix(from: 1).first(where: { schedule in
                    schedule.challenge == nil || schedule.challenge != schedules.first!.challenge
                }))
            }
        }
        .buttonStyle(CardButtonStyle())
    }
}

#Preview {
    SchedulesNavigationLink(schedules: [PreviewSplatoon2Schedule, PreviewSplatoon3Schedule])
}
