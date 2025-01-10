import SwiftUI
import WidgetKit

@available(iOSApplicationExtension 17.0, *)
struct StandBySelectorView<Small: View, StandBy: View>: View {
    // HACK: Referenced from https://forums.developer.apple.com/forums/thread/735473?answerId=766406022.
    @Environment(\.isActivityFullscreen) var isActivityFullscreen
    
    var small: () -> Small
    var standBy: () -> StandBy
    
    init(@ViewBuilder small: @escaping () -> Small, @ViewBuilder standBy: @escaping () -> StandBy) {
        self.small = small
        self.standBy = standBy
    }
    
    var body: some View {
        if isActivityFullscreen {
            standBy()
        } else {
            small()
        }
    }
}

@available(iOSApplicationExtension 17.0, *)
struct StandBySelectorView_Previews: PreviewProvider {
    static var previews: some View {
        StandBySelectorView() {
            Text("1")
        } standBy: {
            Text("2")
        }
        .containerBackground(for: .widget, content: {})
        .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
