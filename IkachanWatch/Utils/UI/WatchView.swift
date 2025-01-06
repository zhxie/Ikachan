import SwiftUI

struct CarouselTabViewStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .tabViewStyle(.carousel)
    }
}

@available(watchOS 10, *)
struct VerticalPageTabViewStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .tabViewStyle(.verticalPage)
    }
}

extension View {
    @ViewBuilder
    func verticalPageTabViewStyle() -> some View {
        if #available(watchOS 10, *) {
            self.modifier(VerticalPageTabViewStyleModifier())
        } else {
            self.modifier(CarouselTabViewStyleModifier())
        }
    }
}
