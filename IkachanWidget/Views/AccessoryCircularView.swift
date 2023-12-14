//
//  AccessoryCircularView.swift
//  IkachanWidget
//
//  Created by Sketch on 2023/12/14.
//

import SwiftUI
import WidgetKit

@available(iOSApplicationExtension 16.0, *)
struct AccessoryCircularView: View {
    var progress: Double
    var mode: String?
    var rule: String?
    
    var body: some View {
        Gauge(value: progress) {
            if let mode = mode {
                Image(mode)
                    .resizedToFit()
                    // HACK: Using a fixed size since some mode image looks smaller than others.
                    .frame(width: 12, height: 12)
            }
        } currentValueLabel: {
            if let rule = rule {
                Image(rule)
                    .resizedToFit()
                    .padding(8)
            } else {
                Image(systemName: "xmark")
                    .resizedToFit()
                    .fontWeight(.bold)
                    .padding(10)
            }
        }
        .gaugeStyle(.accessoryCircular)
    }
}

@available(iOSApplicationExtension 17.0, *)
struct AccessoryCircularView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryCircularView(progress: 0.5, mode: PreviewSplatoon3Schedule.mode.image, rule: PreviewSplatoon3Schedule.rule.image)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
