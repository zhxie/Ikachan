import SwiftUI

struct ScheduleView: View {
    var schedule: Schedule
    var nextSchedule: Schedule? = nil
    var backgroundColor = Color(.secondarySystemBackground)
    var shrinkToFit = false
    
    var body: some View {
        VStack {
            HStack {
                Image(schedule.rule.image)
                    .symbolRenderingMode(.multicolor)
                    .monospacedSymbol()
                    .layoutPriority(1)
                Text(LocalizedStringKey(schedule.challenge ?? schedule.rule.name))
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                Spacer()
                
                Text(timeSpan(start: schedule.startTime, end: schedule.endTime))
                    .monospacedDigit()
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .layoutPriority(1)
            }
            
            HStack {
                if shrinkToFit {
                    Spacer()
                        .frame(width: 16)
                        .layoutPriority(1)
                    
                    Spacer()
                }
                
                ForEach(schedule.stages, id: \.name) { stage in
                    StageView(stage: stage, backgroundColor: backgroundColor)
                }
            }
            
            if let schedule = nextSchedule {
                HStack {
                    Text(LocalizedStringKey("next"))
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(Color(.systemBackground))
                        .padding(4)
                        .background {
                            schedule.mode.accentColor
                                .cornerRadius(4)
                        }
                        .layoutPriority(1)
                    
                    Spacer()
                    
                    Image(schedule.rule.image)
                        .symbolRenderingMode(.multicolor)
                        .font(.headline)
                        .layoutPriority(1)
                    Text(schedule.stages.map({ stage in
                        stage.name
                    }).filter({ name in
                        !name.isEmpty
                    }).joined(separator: " & "))
                    .font(.footnote)
                }
                // HACK: I do not know why but we need this padding to make spacing in the VStack equal.
                .padding([.top], 2)
            }
        }
    }
}

#Preview {
    ScheduleView(schedule: PreviewSplatoon2Schedule, nextSchedule: PreviewSplatoon3Schedule)
}
