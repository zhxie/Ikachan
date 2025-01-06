import SwiftUI

struct PaddingModifier: ViewModifier {
    let padding: Bool
    
    func body(content: Content) -> some View {
        if padding {
            content
                .padding()
        } else {
            content
        }
    }
}

@available(iOSApplicationExtension 17.0, *)
struct ContainerBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .containerBackground(for: .widget, content: {})
    }
}

extension View {
    @ViewBuilder
    func widgetContainerBackground() -> some View {
        self.widgetContainerBackground(padding: true)
    }
    
    @ViewBuilder
    func widgetContainerBackground(padding: Bool) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            self.modifier(ContainerBackgroundModifier())
        } else {
            self.modifier(PaddingModifier(padding: padding))
        }
    }
}
