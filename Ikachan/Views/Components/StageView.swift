import SwiftUI
import Kingfisher

struct StageView: View {
    var stage: Stage
    var backgroundColor = Color(.secondarySystemBackground)
    
    var body: some View {
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
            .overlay(alignment: .bottomTrailing) {
                Text(stage.name)
                    .font(.footnote)
                    .lineLimit(1)
                    .padding([.top], 4)
                    .padding([.leading], 6)
                    .background {
                        Rectangle()
                            .foregroundColor(backgroundColor)
                            .cornerRadius(8, corners: .topLeft)
                    }
                    .padding([.leading], 8)
                    // HACK: There may be edge overflow on scale effect.
                    .offset(x: 1, y: 1)
            }
    }
}

#Preview {
    StageView(stage: PreviewStage)
}
