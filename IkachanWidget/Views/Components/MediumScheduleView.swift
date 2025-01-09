import SwiftUI
import WidgetKit

struct MediumScheduleView: View {
    var mode: any ScheduleMode
    var schedule: Schedule?
    var nextSchedule: Schedule?
    var showsModeImage: Bool = true

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                if showsModeImage {
                    Image(mode.image)
                        .symbolRenderingMode(.multicolor)
                        .monospacedSymbol()
                        .foregroundColor(mode.accentColor)
                        .layoutPriority(1)
                }
                Text(LocalizedStringKey(schedule?.rule.name ?? mode.name))
                    .fontWeight(.bold)
                    .foregroundColor(mode.accentColor)
                    .lineLimit(1)
                
                Spacer()
                
                if let schedule = schedule {
                    Text(absoluteTimeSpan(start: schedule.startTime, end: schedule.endTime))
                        .monospacedDigit()
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                        .layoutPriority(1)
                }
            }
            .layoutPriority(1)
            
            if let schedule = schedule {
                HStack {
                    ForEach(schedule.stages, id: \.name) { stage in
                        StageView(stage: stage, style: .Widget)
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
                            .layoutPriority(1)
                        Text(schedule.stages.map({ stage in
                            stage.name
                        }).filter({ name in
                            !name.isEmpty
                        }).joined(separator: " & "))
                        .font(.footnote)
                    }
                    .layoutPriority(1)
                }
            } else {
                NoScheduleView()
            }
        }
    }
}

@available(iOSApplicationExtension 17.0, *)
struct MediumScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        MediumScheduleView(mode: Splatoon3ScheduleMode.regularBattle, schedule: PreviewSplatoon2Schedule, nextSchedule: PreviewSplatoon3Schedule)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
