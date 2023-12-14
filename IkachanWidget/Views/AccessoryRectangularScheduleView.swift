import SwiftUI
import WidgetKit

@available(iOSApplicationExtension 16.0, *)
struct AccessoryRectangularScheduleView: View {
    var schedule: Schedule?
    
    var body: some View {
        if let schedule = schedule {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    HStack(spacing: 4) {
                        Image(schedule.mode.image)
                            .resizedToFit()
                            .frame(width: 16, height: 16)
                        
                        Text(LocalizedStringKey(schedule.rule.name))
                            .font(.headline)
                            .fontWeight(.bold)
                            .lineLimit(1)
                    }
                    
                    ForEach(schedule.stages, id: \.name) { stage in
                        Text(stage.name)
                            .lineLimit(1)
                    }
                }
                .layoutPriority(1)
                
                Spacer()
                    .frame(minWidth: 0)
            }
        } else {
            Text(LocalizedStringKey("no_schedule"))
        }
    }
}

@available(iOSApplicationExtension 17.0, *)
struct AccessoryRectangularScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryRectangularScheduleView(schedule: PreviewSplatoon3Schedule)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
    }
}
