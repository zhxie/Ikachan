//
//  StageView.swift
//  IkachanWidget
//
//  Created by Sketch on 2023/12/13.
//

import SwiftUI
import Kingfisher

struct StageView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var stage: Stage
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Rectangle()
                .foregroundColor(.clear)
                .overlay (
                    KFImage(stage.thumbnail ?? stage.image)
                        .placeholder {
                            Rectangle()
                        }
                        .resizedToFill()
                        .clipped()
                        .accessibilityLabel(stage.name)
                )
                .cornerRadius(8)
            
            Text(stage.name)
                .font(.footnote)
                .lineLimit(1)
                .padding([.vertical, .trailing], 4)
                .padding([.leading], 6)
                .background {
                    Rectangle()
                        // HACK: .systemBackground in widgets is not pure black which is different from the widget's background.
                        .foregroundColor(colorScheme == .light ? Color(.systemBackground) : .black)
                        .cornerRadius(8, corners: .topLeft)
                        .cornerRadius(7, corners: .bottomRight)
                }
                .padding([.leading], 16)
        }
    }
}
