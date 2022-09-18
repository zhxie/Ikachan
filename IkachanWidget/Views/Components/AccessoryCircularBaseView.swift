//
//  AccessoryCircularBaseView.swift
//  IkachanWidget
//
//  Created by Sketch on 2022/9/18.
//

import SwiftUI

struct AccessoryCircularBaseView: View {
    var value: Double
    var image: String
    var text: String
    
    var body: some View {
        if #available(iOSApplicationExtension 16.0, *) {
            Gauge(value: value) {
                Text(LocalizedStringKey(text))
            } currentValueLabel: {
                Image(image)
                    .resizedToFit()
                    .frame(width: 28, height: 28)
            }
            .gaugeStyle(.accessoryCircular)
        } else {
            EmptyView()
        }
    }
}

struct AccessoryCircularBaseView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryCircularBaseView(value: 0.5, image: "turf_war", text: "R.")
    }
}
