import SwiftUI
import WidgetKit
import Kingfisher

@available(iOSApplicationExtension 17.0, *)
struct StandByScheduleView: View {
    @Environment(\.widgetRenderingMode) var widgetRenderingMode
    @Environment(\.widgetContentMargins) var widgetContentMargins
    
    var mode: any ScheduleMode
    var schedule: Schedule?
    
    var body: some View {
        VStack(alignment: .leading) {
            // HACK: To occupy horizontal space in advance.
            HStack {
                Spacer()
            }
            
            Spacer()
                .frame(minHeight: 0)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    Image(schedule?.rule.image ?? mode.image)
                        .symbolRenderingMode(.hierarchical)
                        .monospacedSymbol(.footnote)
                    
                    Text(LocalizedStringKey(schedule?.rule.name ?? mode.shortName))
                        .font(.footnote)
                        .fontWeight(.bold)
                        .lineLimit(1)
                }
                
                if let schedule = schedule {
                    VStack(alignment: .leading, spacing: 2) {
                        ForEach(schedule.stages, id: \.name) { stage in
                            Text(stage.name)
                                .font(.caption2)
                        }
                    }
                } else {
                    Text(LocalizedStringKey("no_schedules"))
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            .padding([.leading, .bottom], 8)
        }
        .background {
            if let stage = schedule?.stages.first {
                KFImage(stage.thumbnail ?? stage.image)
                    .resizedToFill()
                    .clipped()
                    .brightness(widgetRenderingMode == .fullColor ? -0.25 : -0.75)
                    .accessibilityLabel(stage.name)
                    .padding(-widgetContentMargins)
            }
        }
    }
}

@available(iOSApplicationExtension 17.0, *)
struct StandByScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        StandByScheduleView(mode: Splatoon3ScheduleMode.regularBattle, schedule: PreviewSplatoon2Schedule)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
