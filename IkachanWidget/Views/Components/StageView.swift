import SwiftUI
import Kingfisher

struct StageView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var stage: Stage
    
    var body: some View {
        Rectangle()
            .fill(.clear)
            .overlay {
                Image(uiImage: UIImage(contentsOfFile: ImageCache.default.cachePath(forKey: (stage.thumbnail ?? stage.image).cacheKey)) ?? UIImage())
                    .resizable()
                    .widgetAccentedRenderingMode_Backport(.accentedDesaturated)
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .accessibilityLabel(stage.name)
            }
            // TODO: Clean masks.
            .mask {
                Rectangle()
                    .mask {
                        Rectangle()
                            .overlay(alignment: .bottomTrailing) {
                                if !stage.name.isEmpty {
                                    Text(stage.name)
                                        .font(.footnote)
                                        .lineLimit(1)
                                        .padding([.top], 4)
                                        .padding([.leading], 6)
                                        .background {
                                            Rectangle()
                                                .cornerRadius(8, corners: .topLeft)
                                        }
                                        .padding([.leading], 8)
                                        .blendMode(.destinationOut)
                                }
                            }
                    }
            }
            .cornerRadius(8)
            .overlay(alignment: .bottomTrailing) {
                if !stage.name.isEmpty {
                    Text(stage.name)
                        .font(.footnote)
                        .lineLimit(1)
                        .padding([.top], 4)
                        .padding([.leading], 14)
                        // HACK: There may be edge overflow on scale effect.
                        .offset(x: 1, y: 1)
                }
            }
    }
}

#Preview {
    StageView(stage: PreviewStage)
}
