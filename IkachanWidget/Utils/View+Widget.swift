import SwiftUI
import WidgetKit

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

@available(iOSApplicationExtension 17.0, watchOSApplicationExtension 10.0, *)
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
        if #available(iOSApplicationExtension 17.0, watchOSApplicationExtension 10.0, *) {
            self.modifier(ContainerBackgroundModifier())
        } else {
            self.modifier(PaddingModifier(padding: padding))
        }
    }
}

@available(iOSApplicationExtension 16.0, *)
struct WidgetAccentableModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .widgetAccentable()
    }
}

extension View {
    @ViewBuilder
    func widgetAccentable_Backport() -> some View {
        if #available(iOSApplicationExtension 16.0, *) {
            self.modifier(WidgetAccentableModifier())
        } else {
            self
        }
    }
}

enum WidgetAccentedRenderingMode_Backport {
    case unknown
    case accented
    case desaturated
    case accentedDesaturated
    case fullColor

    @available(iOSApplicationExtension 18.0, watchOSApplicationExtension 11.0, *)
    func widgetAccenetedRenderingMode() -> WidgetAccentedRenderingMode {
        switch self {
        case .accented:
            return WidgetAccentedRenderingMode.accented
        case .desaturated:
            return WidgetAccentedRenderingMode.desaturated
        case .accentedDesaturated:
            return WidgetAccentedRenderingMode.accentedDesaturated
        case .unknown, .fullColor:
            return WidgetAccentedRenderingMode.fullColor
        }
    }
}

extension Image {
    @ViewBuilder
    func widgetAccentedRenderingMode_Backport(_ widgetAccentedRenderingMode: WidgetAccentedRenderingMode_Backport) -> some View {
        if #available(iOSApplicationExtension 18.0, watchOSApplicationExtension 11.0, *) {
            self
                .widgetAccentedRenderingMode(widgetAccentedRenderingMode.widgetAccenetedRenderingMode())
        } else {
            self
        }
    }
}
