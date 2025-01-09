import SwiftUI
import WidgetKit

@available(iOSApplicationExtension 16.0, *)
struct AccessoryRectangularScheduleView: View {
    @Environment(\.widgetRenderingMode) var widgetRenderingMode
    
    var mode: any ScheduleMode
    var schedule: Schedule?
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                HStack(spacing: 4) {
                    Image(mode.image)
                        .symbolRenderingMode(widgetRenderingMode == .fullColor ? .multicolor : .hierarchical)
                        .monospacedSymbol(.headline)
                        .foregroundColor(widgetRenderingMode == .fullColor ? mode.accentColor : .primary)
                        .widgetAccentable()
                    
                    Text(LocalizedStringKey(schedule?.rule.name ?? mode.name))
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(widgetRenderingMode == .fullColor ? mode.accentColor : .primary)
                        .widgetAccentable()
                        .lineLimit(1)
                }
                
                if let schedule = schedule {
                    ForEach(schedule.stages, id: \.name) { stage in
                        Text(stage.name)
                            .lineLimit(1)
                    }
                } else {
                    NoScheduleView()
                }
            }
            .layoutPriority(1)
            
            Spacer()
                .frame(minWidth: 0)
        }
    }
}

@available(iOSApplicationExtension 17.0, watchOSApplicationExtension 10.0, *)
struct AccessoryRectangularScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryRectangularScheduleView(mode: Splatoon3ScheduleMode.regularBattle, schedule: PreviewSplatoon3Schedule)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
    }
}
