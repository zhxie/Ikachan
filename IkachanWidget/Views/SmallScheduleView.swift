import SwiftUI
import WidgetKit

struct SmallScheduleView: View {
    var schedule: Schedule?
    var nextSchedule: Schedule?
    
    var body: some View {
        if let schedule = schedule {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    HStack {
                        Image(schedule.mode.image)
                            .resizedToFit()
                            .frame(width: 16, height: 16)
                            .layoutPriority(1)
                        Text(LocalizedStringKey(schedule.rule.name))
                            .fontWeight(.bold)
                            .foregroundColor(schedule.mode.accentColor)
                            .lineLimit(1)
                    }
                    .layoutPriority(1)
                    
                    Spacer()
                        .frame(minWidth: 0)
                }
                .layoutPriority(1)
                
                ForEach(schedule.stages, id: \.name) { stage in
                    StageView(stage: stage)
                }
            }
        } else {
            Text(LocalizedStringKey("no_schedule"))
        }
    }
}

@available(iOSApplicationExtension 17.0, *)
struct SmallScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        SmallScheduleView(schedule: PreviewSplatoon2Schedule, nextSchedule: PreviewSplatoon3Schedule)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
