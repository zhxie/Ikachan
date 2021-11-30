//
//  ScheduleBaseView.swift
//  Ikachan
//
//  Created by Sketch on 2021/11/29.
//

import SwiftUI

struct ScheduleBaseView<Content: View>: View {
    let title: String
    let subtitle: String
    let image: String
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(LocalizedStringKey(title))
                        .font(.title2)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Text(subtitle)
                        .font(.callout)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                .layoutPriority(1)
                
                Spacer()
                
                Image(image)
                    .resizedToFit()
                    .frame(width: 50, height: 50)
            }
            
            content()
        }
    }
}

struct ScheduleBaseView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleBaseView(title: "", subtitle: "", image: "") {
            EmptyView()
        }
    }
}
