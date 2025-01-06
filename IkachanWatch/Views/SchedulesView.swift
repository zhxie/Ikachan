import SwiftUI

struct SchedulesView: View {
    var mode: any ScheduleMode
    var schedules: [Schedule]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [mode.accentColor, .black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            List {
                ForEach(schedules, id: \.startTime) { schedule in
                    HStack {
                        ScheduleView(schedule: schedule)
                            .padding()
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
