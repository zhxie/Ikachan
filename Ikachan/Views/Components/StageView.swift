import SwiftUI
import Kingfisher

enum StageViewStyle {
    case Home
    case List
    case Widget
}

struct StageView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var stage: Stage
    var backgroundColor: Color?
    var style: StageViewStyle = .Home
    
    @ViewBuilder
    var image: some View {
        switch style {
        case .Home:
            KFImage(stage.image)
                .fade(duration: 0.5)
                .resizedToFill()
                .clipped()
                .accessibilityLabel(stage.name)
        case .List:
            KFImage(stage.image)
                .fade(duration: 0.5)
                .resizedToFit(16 / 9)
                .accessibilityLabel(stage.name)
        case .Widget:
            KFImage(stage.thumbnail ?? stage.image)
                .resizedToFill()
                .clipped()
                .accessibilityLabel(stage.name)
        }
    }
    
    @ViewBuilder
    var rectangle: some View {
        switch style {
        case .Home, .Widget:
            Rectangle()
                .fill(.clear)
        case .List:
            Rectangle()
                .fill(.clear)
                .aspectRatio(16 / 9, contentMode: .fit)
        }
    }
    
    var backgroundColorView: some View {
        if let backgroundColor = backgroundColor {
            backgroundColor
        } else {
            switch style {
            case .Home, .List:
                Color(.secondarySystemBackground)
            case .Widget:
                // HACK: .systemBackground in widgets is not pure black which is different from the widget's background.
                Color(colorScheme == .light ? .systemBackground : .black)
            }
        }
    }
    
    var body: some View {
        rectangle
            .overlay {
                image
            }
            .cornerRadius(style == .Widget ? 8 : 16)
            .overlay(alignment: .bottomTrailing) {
                if !stage.name.isEmpty {
                    Text(stage.name)
                        .font(.footnote)
                        .lineLimit(1)
                        .padding([.top], 4)
                        .padding([.leading], 6)
                        .background {
                            backgroundColorView
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
