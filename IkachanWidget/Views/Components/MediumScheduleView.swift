import SwiftUI
import WidgetKit

// HACK: Wrap WidgetEnvironmentReader on use for environments backporting.
struct MediumScheduleView: View {
    var mode: any ScheduleMode
    var schedule: Schedule?
    var nextSchedule: Schedule?
    
    var body: some View {
        WidgetEnvironmentReader {
            MediumScheduleView_Inner(mode: mode, schedule: schedule, nextSchedule: nextSchedule)
        }
    }
}

struct MediumScheduleView_Inner: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.widgetRenderingMode_Backport) var widgetRenderingMode
    
    var mode: any ScheduleMode
    var schedule: Schedule?
    var nextSchedule: Schedule?

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Image(mode.image)
                    .symbolRenderingMode(widgetRenderingMode == .fullColor ? .multicolor : .hierarchical)
                    .monospacedSymbol()
                    .foregroundColor(widgetRenderingMode == .fullColor ? mode.accentColor : .primary)
                    .widgetAccentable_Backport()
                    .layoutPriority(1)
                Text(LocalizedStringKey(schedule?.rule.name ?? mode.name))
                    .fontWeight(.bold)
                    .foregroundColor(widgetRenderingMode == .fullColor ? mode.accentColor : .primary)
                    .widgetAccentable_Backport()
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
                            .foregroundColor(Color(colorScheme == .light ? .systemBackground : .black))
                            .padding(4)
                            .background {
                                Rectangle()
                                    .fill(widgetRenderingMode == .fullColor ? schedule.mode.accentColor : .primary)
                                    .cornerRadius(4)
                            }
                            .layoutPriority(1)
                        
                        Spacer()
                        
                        Image(schedule.rule.image)
                            .symbolRenderingMode(widgetRenderingMode == .fullColor ? .multicolor : .hierarchical)
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
