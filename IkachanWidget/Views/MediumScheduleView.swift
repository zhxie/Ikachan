import SwiftUI
import WidgetKit

struct MediumScheduleView: View {
    var schedule: Schedule?
    var nextSchedule: Schedule?

    var body: some View {
        if let schedule = schedule {
            VStack(spacing: 8) {
                HStack(alignment: .center) {
                    Image(schedule.mode.image)
                        .resizedToFit()
                        .frame(width: 20, height: 20)
                        .layoutPriority(1)
                    Text(LocalizedStringKey(schedule.challenge ?? schedule.rule.name))
                        .fontWeight(.bold)
                        .foregroundColor(schedule.mode.accentColor)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Text(absoluteTimeSpan(start: schedule.startTime, end: schedule.endTime))
                        .monospacedDigit()
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                        .layoutPriority(1)
                }
                .layoutPriority(1)
                
                HStack {
                    ForEach(schedule.stages, id: \.name) { stage in
                        StageView(stage: stage)
                    }
                }
                
                if let schedule = nextSchedule {
                    HStack(alignment: .center) {
                        Text(LocalizedStringKey("next"))
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(Color(.systemBackground))
                            .padding(4)
                            .background {
                                Rectangle()
                                    .foregroundColor(schedule.mode.accentColor)
                                    .cornerRadius(4)
                            }
                            .layoutPriority(1)
                        
                        Spacer()
                        
                        Image(schedule.rule.image)
                            .resizedToFit()
                            .frame(width: 20, height: 20)
                            .layoutPriority(1)
                        Text(schedule.stages.map({ stage in
                            stage.name
                        }).joined(separator: " & "))
                        .font(.footnote)
                    }
                    .layoutPriority(1)
                }
            }
        } else {
            Text(LocalizedStringKey("no_schedule"))
        }
    }
}

@available(iOSApplicationExtension 17.0, *)
struct MediumScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        MediumScheduleView(schedule: PreviewSplatoon2Schedule, nextSchedule: PreviewSplatoon3Schedule)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
