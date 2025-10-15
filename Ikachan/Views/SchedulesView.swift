import SwiftUI

struct SchedulesView: View {
    @Environment(\.dismiss) private var dismiss
    
    var mode: any ScheduleMode
    var schedules: [Schedule]
    
    var body: some View {
        List {
            ForEach(schedules, id: \.startTime) { schedule in
                ScheduleView(schedule: schedule, shrinkToFit: true)
            }
        }
        .navigationTitle(LocalizedStringKey(mode.name))
        .toolbar {
            ToolbarItem {
                Button {
                    dismiss()
                } label: {
                    if #available(iOS 26.0, *) {
                        Image(systemName: "xmark")
                    } else {
                        Text(LocalizedStringKey("close"))
                    }
                }
            }
        }
    }
}

#Preview {
    SchedulesView(mode: Splatoon2ScheduleMode.regularBattle, schedules: [PreviewSplatoon2Schedule, PreviewSplatoon3Schedule])
}
