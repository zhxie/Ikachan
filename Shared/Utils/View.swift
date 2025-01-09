import SwiftUI

extension View {
    // Referenced from https://stackoverflow.com/a/58606176.
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct MonospacedSymbolModifier: ViewModifier {
    @ScaledMetric var width: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(width: width)
    }
}

extension View {
    @ViewBuilder
    func monospacedSymbol() -> some View {
        self.monospacedSymbol(.body)
    }
    
    func monospacedSymbol(_ textStyle: Font.TextStyle) -> some View {
        var width: CGFloat
        // A approximation from https://developer.apple.com/design/human-interface-guidelines/typography for iOS.
        switch textStyle {
        case .largeTitle:
            width = 40
        case .title:
            width = 32
        case .title2:
            width = 26
        case .title3:
            width = 24
        case .headline, .body, .callout:
            width = 20
        case .subheadline:
            width = 18
        case .footnote:
            width = 16
        case .caption:
            width = 14
        case .caption2:
            width = 12
        @unknown default:
            fatalError()
        }
        
        return self
            .font(.system(textStyle))
            .modifier(MonospacedSymbolModifier(width: width))
    }
}
