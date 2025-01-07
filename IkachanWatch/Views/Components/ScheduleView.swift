import SwiftUI

struct ScheduleView: View {
    var schedule: Schedule
    
    var body: some View {
        VStack(spacing: 8) {
            if let challenge = schedule.challenge {
                Text(challenge)
                    .font(.caption2)
                    .lineLimit(1)
            }
            
            HStack(alignment: .center) {
                Image(schedule.rule.image)
                    .resizedToFit()
                    .frame(width: 24, height: 24)
                Text(LocalizedStringKey(schedule.rule.name))
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(1)
            }
            
            Text(timeSpan(start: schedule.startTime, end: schedule.endTime))
                .font(.caption2)
                .monospacedDigit()
                .foregroundColor(.secondary)
                .lineLimit(1)
            
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
    ScheduleView(schedule: PreviewSplatoon3Schedule)
}
