import SwiftUI
import WidgetKit

struct SmallScheduleView: View {
    var mode: any ScheduleMode
    var schedule: Schedule?
    var nextSchedule: Schedule?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                HStack {
                    Image(mode.image)
                        .symbolRenderingMode(.multicolor)
                        .foregroundColor(mode.accentColor)
                        .layoutPriority(1)
                    Text(LocalizedStringKey(schedule?.rule.name ?? mode.name))
                        .fontWeight(.bold)
                        .foregroundColor(mode.accentColor)
                        .lineLimit(1)
                }
                .layoutPriority(1)
                
                Spacer()
                    .frame(minWidth: 0)
            }
            .layoutPriority(1)
            
            if let schedule = schedule {
                ForEach(schedule.stages, id: \.name) { stage in
                    StageView(stage: stage, style: .Widget)
                }
            } else {
                NoScheduleView()
            }
        }
    }
}

@available(iOSApplicationExtension 17.0, *)
struct SmallScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        SmallScheduleView(mode: Splatoon3ScheduleMode.regularBattle, schedule: PreviewSplatoon2Schedule, nextSchedule: PreviewSplatoon3Schedule)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
