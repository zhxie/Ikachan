//
//  CardView.swift
//  Ikachan
//
//  Created by Sketch on 2023/12/12.
//

import SwiftUI

struct CardView<Content: View>: View {
    var image: String
    var name: String
    var content: () -> Content
    
    init(image: String, name: String, @ViewBuilder content: @escaping () -> Content) {
        self.image = image
        self.name = name
        self.content = content
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image(image)
                    .resizedToFit()
                    .frame(width: 24, height: 24)
                Text(LocalizedStringKey(name))
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(1)
            }
            content()
        }
        .padding()
        .background {
            Rectangle()
                .foregroundColor(Color(.secondarySystemBackground))
                .cornerRadius(16)
        }
    }
}

#Preview {
    CardView(image: PreviewSplatoon2Schedule.mode.image, name: PreviewSplatoon2Schedule.mode.name) {
        ScheduleView(schedule: PreviewSplatoon2Schedule)
    }
}
