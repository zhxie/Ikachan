import SwiftUI
import WidgetKit

struct SmallScheduleView: View {
    @Environment(\.showsWidgetContainerBackground) var showsWidgetContainerBackground
    
    var schedule: Schedule?
    var nextSchedule: Schedule?
    
    var body: some View {
        if let schedule = schedule {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    HStack(alignment: .center) {
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
                
                if showsWidgetContainerBackground {
                    ForEach(schedule.stages, id: \.name) { stage in
                        StageView(stage: stage)
                    }
                } else {
                    VStack(spacing: 4) {
                        ForEach(schedule.stages, id: \.name) { stage in
                            Text(stage.name)
                                .lineLimit(1)
                        }
                    }
                    
                    if let schedule = nextSchedule {
                        HStack {
                            HStack(alignment: .center) {
                                Image(schedule.mode.image)
                                    .resizedToFit()
                                    .frame(width: 12, height: 12)
                                    .layoutPriority(1)
                                Text(LocalizedStringKey(schedule.rule.name))
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                    .foregroundColor(schedule.mode.accentColor)
                                    .lineLimit(1)
                            }
                            .layoutPriority(1)
                            
                            Spacer()
                                .frame(minWidth: 0)
                        }
                        .layoutPriority(1)
                        
                        VStack(spacing: 4) {
                            ForEach(schedule.stages, id: \.name) { stage in
                                Text(stage.name)
                                    .font(.footnote)
                                    .lineLimit(1)
                            }
                        }
                    }
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
