//
//  StageView.swift
//  Ikachan
//
//  Created by Sketch on 2021/11/29.
//

import SwiftUI
import Kingfisher

struct StageView: View {
    var stage: Stage
    var backgroundColor = Color(.secondarySystemBackground)
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            KFImage(stage.image)
                .placeholder {
                    Rectangle()
                        .foregroundColor(backgroundColor)
                        .aspectRatio(16 / 9, contentMode: .fit)
                }
                .fade(duration: 0.5)
                .resizedToFit(16 / 9)
                .cornerRadius(16)
                .accessibilityLabel(stage.name)
            
            Text(stage.name)
                .font(.footnote)
                .lineLimit(1)
                .padding(4)
                .background {
                    Rectangle()
                        .foregroundColor(backgroundColor)
                        .cornerRadius(8, corners: .topLeft)
                        .cornerRadius(16, corners: .bottomRight)
                }
                .padding([.leading], 16)
        }
    }
}

#Preview {
    StageView(stage: PreviewStage)
}
