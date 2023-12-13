//
//  SmallScheduleView.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/1/21.
//

import SwiftUI
import WidgetKit

struct SmallScheduleView: View {
    var schedule: Schedule?
    
    var body: some View {
        if let schedule = schedule {
            VStack(spacing: 8) {
                HStack(alignment: .center) {
                    Image(schedule.mode.image)
                        .resizedToFit()
                        .frame(width: 16, height: 16)
                        .layoutPriority(1)
                    Text(LocalizedStringKey(schedule.rule.name))
                        .fontWeight(.bold)
                        .foregroundColor(schedule.mode.accentColor)
                        .lineLimit(1)
                    
                    Spacer()
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
        SmallScheduleView(schedule: PreviewSplatoon2Schedule)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
