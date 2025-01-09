import SwiftUI
import WidgetKit

@available(iOSApplicationExtension 17.0, *)
struct StandbyScheduleView: View {
    @Environment(\.widgetRenderingMode) var widgetRenderingMode
    
    var mode: any ScheduleMode
    var schedule: Schedule?
    var nextSchedule: Schedule?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                HStack {
                    Text(LocalizedStringKey(mode.name))
                        .fontWeight(.bold)
                        .foregroundColor(widgetRenderingMode == .fullColor ? mode.accentColor : .primary)
                }
                .layoutPriority(1)
                
                Spacer()
                    .frame(minWidth: 0)
            }
            .layoutPriority(1)
            
            if let schedule = schedule {
                VStack(alignment: .leading) {
                    HStack {
                        Image(schedule.rule.image)
                            .symbolRenderingMode(widgetRenderingMode == .fullColor ? .multicolor : .hierarchical)
                            .monospacedSymbol(.footnote)
                            .layoutPriority(1)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            ForEach(schedule.stages, id: \.name) { stage in
                                Text(stage.name)
                                    .font(.footnote)
                                    .lineLimit(1)
                            }
                        }
                    }
                    
                    if let schedule = nextSchedule {
                        Separator(accentColor: widgetRenderingMode == .fullColor ? .secondary : .primary)
                            .font(.caption2)
                            .opacity(widgetRenderingMode == .fullColor ? 0.5 : 1)
                        
                        HStack {
                            Image(schedule.rule.image)
                                .symbolRenderingMode(widgetRenderingMode == .fullColor ? .multicolor : .hierarchical)
                                .monospacedSymbol(.footnote)
                                .layoutPriority(1)
                            
                            VStack(alignment: .leading, spacing: 2) {
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
                Text(LocalizedStringKey("no_schedules"))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

@available(iOSApplicationExtension 17.0, *)
struct StandbyScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        StandbyScheduleView(mode: Splatoon3ScheduleMode.regularBattle, schedule: PreviewSplatoon2Schedule, nextSchedule: PreviewSplatoon3Schedule)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
