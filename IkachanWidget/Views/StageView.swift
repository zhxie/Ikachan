import SwiftUI
import Kingfisher

struct StageView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var stage: Stage
    
    var body: some View {
        Rectangle()
            .fill(.clear)
            .overlay (
                KFImage(stage.thumbnail ?? stage.image)
                    .resizedToFill()
                    .clipped()
                    .accessibilityLabel(stage.name)
            )
            .cornerRadius(8)
            .overlay(alignment: .bottomTrailing) {
                if !stage.name.isEmpty {
                    Text(stage.name)
                        .font(.footnote)
                        .lineLimit(1)
                        .padding([.top], 4)
                        .padding([.leading], 6)
                        .background {
                            // HACK: .systemBackground in widgets is not pure black which is different from the widget's background.
                            Color(colorScheme == .light ? .systemBackground : .black)
                                .cornerRadius(8, corners: .topLeft)
                        }
                        .padding([.leading], 8)
                        // HACK: There may be edge overflow on scale effect.
                        .offset(x: 1, y: 1)
                }
            }
    }
}
