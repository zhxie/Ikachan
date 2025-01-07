import SwiftUI

struct SchedulesView: View {
    var mode: any ScheduleMode
    var schedules: [Schedule]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [mode.accentColor, mode.accentColor.opacity(0)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            ScrollView {
                ScheduleView(schedule: schedules.first!)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                if schedules.count > 1 {
                    Separator()
                    
                    ScheduleView(schedule: schedules.at(index: 1)!)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
    }
}

#Preview {
    SchedulesView(mode: Splatoon2ScheduleMode.regularBattle, schedules: [PreviewSplatoon2Schedule, PreviewSplatoon3Schedule])
}
