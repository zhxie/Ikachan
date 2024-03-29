import SwiftUI
import Kingfisher

struct StageView: View {
    var stage: Stage
    var backgroundColor = Color(.secondarySystemBackground)
    
    var body: some View {
        Rectangle()
            .fill(.clear)
            .aspectRatio(16 / 9, contentMode: .fit)
            .overlay {
                KFImage(stage.image)
                    .fade(duration: 0.5)
                    .resizedToFit(16 / 9)
                    .accessibilityLabel(stage.name)
            }
            .cornerRadius(16)
            .overlay(alignment: .bottomTrailing) {
                if !stage.name.isEmpty {
                    Text(stage.name)
                        .font(.footnote)
                        .lineLimit(1)
                        .padding([.top], 4)
                        .padding([.leading], 6)
                        .background {
                            backgroundColor
                                .cornerRadius(8, corners: .topLeft)
                        }
                        .padding([.leading], 8)
                        // HACK: There may be edge overflow on scale effect.
                        .offset(x: 1, y: 1)
                }
            }
    }
}

#Preview {
    StageView(stage: PreviewStage)
}
