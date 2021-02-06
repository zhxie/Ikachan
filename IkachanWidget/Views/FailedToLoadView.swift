//
//  FailedToLoadView.swift
//  IkachanWidgetExtension
//
//  Created by Sketch on 2021/2/2.
//

import SwiftUI
import WidgetKit

struct FailedToLoadView: View {
    var accentColor: Color
    
    var body: some View {
        GeometryReader { g in
            VStack {
                Spacer()
                
                ZStack {
                    Image("inkling_splatted")
                        .resizable()
                        .scaledToFit()
                        .accessibility(label: Text("failed_to_load"))
                        .blending(color: accentColor)
                }
                .frame(height: g.size.height / 3)
                Text("failed_to_load")
                    .font(.footnote)
                    .foregroundColor(accentColor)
                
                Spacer()
            }
        }
    }
}

struct FailedToLoadView_Previews: PreviewProvider {
    static var previews: some View {
        FailedToLoadView(accentColor: .black)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        FailedToLoadView(accentColor: .black)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
