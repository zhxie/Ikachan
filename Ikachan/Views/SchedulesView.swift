import SwiftUI

struct SchedulesView: View {
    var mode: any ScheduleMode
    var schedules: [Schedule]
    
    var body: some View {
        List {
            ForEach(schedules, id: \.startTime) { schedule in
                ScheduleView(schedule: schedule, backgroundColor: Color(.secondarySystemGroupedBackground), shrinkToFit: true)
            }
        }
        .navigationTitle(LocalizedStringKey(mode.name))
    }
}

#Preview {
    SchedulesView(mode: Splatoon2ScheduleMode.regularBattle, schedules: [PreviewSplatoon2Schedule, PreviewSplatoon3Schedule])
}
