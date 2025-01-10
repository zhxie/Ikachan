import SwiftUI
import WidgetKit

// Referenced from https://developer.apple.com/forums/thread/733780?answerId=759064022.
enum WidgetRenderingMode_Backport {
    case unknown
    case fullColor
    case accented
    case vibrant
}

struct WidgetRenderingModeEnvironmentKey_Backport: EnvironmentKey {
    static let defaultValue: WidgetRenderingMode_Backport = .fullColor
}

extension EnvironmentValues {
    var widgetRenderingMode_Backport: WidgetRenderingMode_Backport {
        set {
            self[WidgetRenderingModeEnvironmentKey_Backport.self] = newValue
        }
        get {
            self[WidgetRenderingModeEnvironmentKey_Backport.self]
        }
    }
}

extension View {
    func envWidgetRenderingMode_Backport(_ value: WidgetRenderingMode_Backport) -> some View {
        environment(\.widgetRenderingMode_Backport, value)
    }
}

struct WidgetEnvironmentReader<Content: View>: View {
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        if #available(iOSApplicationExtension 16.0, *) {
            WidgetEnvironmentViewBuilder(content: content)
        } else {
            content()
        }
    }
    
    @available(iOSApplicationExtension 16.0, *)
    struct WidgetEnvironmentViewBuilder<C: View>: View {
        @Environment(\.widgetRenderingMode) var widgetRenderingMode
        
        var content: () -> C
        
        init(@ViewBuilder content: @escaping () -> C) {
            self.content = content
        }
        
        var body: some View {
            content()
                .envWidgetRenderingMode_Backport(widgetRenderingMode_Backport)
        }
        
        var widgetRenderingMode_Backport: WidgetRenderingMode_Backport {
            switch widgetRenderingMode {
            case .fullColor:
                return .fullColor
            case .accented:
                return .accented
            case .vibrant:
                return .vibrant
            default:
                return .unknown
            }
        }
    }
}
