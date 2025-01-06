import SwiftUI

struct SchedulesView: View {
    var mode: any ScheduleMode
    var schedules: [Schedule]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [mode.accentColor, .black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            List {
                ForEach(schedules.prefix(2), id: \.startTime) { schedule in
                    HStack {
                        ScheduleView(schedule: schedule)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
        }
    }
}

#Preview {
    SchedulesView(mode: Splatoon2ScheduleMode.regularBattle, schedules: [PreviewSplatoon2Schedule, PreviewSplatoon3Schedule])
}
