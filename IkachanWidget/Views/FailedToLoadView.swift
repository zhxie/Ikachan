//
//  FailedToLoadView.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/2/2.
//

import SwiftUI
import WidgetKit

struct FailedToLoadView: View {
    var accentColor: Color
    var transparent: Bool = false
    
    var body: some View {
        ZStack {
            if !transparent {
                Color(UIColor.systemBackground)
                    .ignoresSafeArea(edges: .all)
            }
            
            GeometryReader { g in
                VStack {
                    Spacer()
                    
                    ZStack {
                        Image("inkling_splatted")
                            .resizedToFit()
                            .blending(color: accentColor)
                            .accessibilityLabel("failed_to_load")
                    }
                    .frame(height: g.size.height / 3)
                    Text("failed_to_load")
                        .font(.footnote)
                        .foregroundColor(accentColor)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                }
            }
        }
    }
}

struct FailedToLoadView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FailedToLoadView(accentColor: Splatoon2ScheduleMode.regular.accentColor)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            FailedToLoadView(accentColor: Splatoon2ScheduleMode.regular.accentColor)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
