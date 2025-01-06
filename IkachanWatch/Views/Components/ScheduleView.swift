import SwiftUI

struct ScheduleView: View {
    var schedule: Schedule
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .center) {
                Image(schedule.rule.image)
                    .resizedToFit()
                    .frame(width: 24, height: 24)
                    .layoutPriority(1)
                Text(LocalizedStringKey(schedule.challenge ?? schedule.rule.name))
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(1)
            }
            
            Text(timeSpan(start: schedule.startTime, end: schedule.endTime))
                .monospacedDigit()
                .foregroundColor(.secondary)
                .lineLimit(1)
                .layoutPriority(1)
            
            VStack {
                ForEach(schedule.stages, id: \.name) { stage in
                    Text(stage.name)
                        .lineLimit(1)
                }
            }
        }
    }
}

#Preview {
    ScheduleView(schedule: PreviewSplatoon2Schedule)
}
