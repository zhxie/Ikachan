//
//  StageView.swift
//  IkachanWidget
//
//  Created by Sketch on 2023/12/13.
//

import SwiftUI
import Kingfisher

struct StageView: View {
    var stage: Stage
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Rectangle()
                .foregroundColor(.clear)
                .overlay (
                    KFImage(stage.thumbnail ?? stage.image)
                        .placeholder {
                            Rectangle()
                                .foregroundColor(Color(.secondarySystemGroupedBackground))
                        }
                        .resizedToFill()
                        .clipped()
                        .accessibilityLabel(stage.name)
                )
                .cornerRadius(8)
            
            Text(stage.name)
                .font(.footnote)
                .lineLimit(1)
                .padding(4)
                .background {
                    Rectangle()
                        .foregroundColor(Color(.systemBackground))
                        .cornerRadius(8, corners: .topLeft)
                        .cornerRadius(7, corners: .bottomRight)
                }
                .padding([.leading], 16)
        }
    }
}
