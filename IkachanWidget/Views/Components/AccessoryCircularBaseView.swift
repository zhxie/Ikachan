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
                GeometryReader { g in
                    VStack {
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            Image(image)
                                .resizedToFit()
                                .frame(height: g.size.height * 0.67)
                                .layoutPriority(1)
                            
                            Spacer()
                        }
                        .layoutPriority(1)
                        
                        Spacer()
                    }
                }
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
