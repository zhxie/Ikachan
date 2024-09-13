import SwiftUI
import Kingfisher

struct StageView: View {
    var stage: Stage
    var backgroundColor = Color(.secondarySystemBackground)
    var aspectRatio: CGFloat?
    
    @ViewBuilder
    var image: some View {
        if let aspectRatio = aspectRatio {
            KFImage(stage.image)
                .fade(duration: 0.5)
                .resizedToFit(aspectRatio)
                .accessibilityLabel(stage.name)
        } else {
            KFImage(stage.image)
                .fade(duration: 0.5)
                .resizedToFill()
                .clipped()
                .accessibilityLabel(stage.name)
        }
    }
    
    @ViewBuilder
    var rectangle: some View {
        if let aspectRatio = aspectRatio {
            Rectangle()
                .fill(.clear)
                .aspectRatio(aspectRatio, contentMode: .fit)
        } else {
            Rectangle()
                .fill(.clear)
        }
    }
    
    var body: some View {
        rectangle
            .overlay {
                image
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
