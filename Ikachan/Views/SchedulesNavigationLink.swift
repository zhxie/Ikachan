import SwiftUI

struct SchedulesNavigationLink: View {
    var schedules: [Schedule]
    
    @State var showSheet = false
    
    var body: some View {
        Button {
            showSheet = true
        } label: {
            CardView(image: schedules.first!.mode.image, accentColor: schedules.first!.mode.accentColor, name: schedules.first!.mode.name) {
                ScheduleView(schedule: schedules.first!, nextSchedule: schedules.suffix(from: 1).first(where: { schedule in
                    schedule.challenge == nil || schedule.challenge != schedules.first!.challenge
                }))
            }
        }
        .buttonStyle(CardButtonStyle())
        .sheet(isPresented: $showSheet) {
            NavigationView {
                SchedulesView(mode: schedules.first!.mode, schedules: schedules)
            }
        }
    }
}

#Preview {
    SchedulesNavigationLink(schedules: [PreviewSplatoon2Schedule, PreviewSplatoon3Schedule])
}
