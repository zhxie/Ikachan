import SwiftUI

struct SwappableView<Content: View, Content2: View>: View {
    var isSwapped: Bool
    var content: () -> Content
    var content2: () -> Content2
    
    init(isSwapped: Bool, @ViewBuilder content: @escaping () -> Content, @ViewBuilder content2: @escaping () -> Content2) {
        self.isSwapped = isSwapped
        self.content = content
        self.content2 = content2
    }
    
    var body: some View {
        if isSwapped {
            content2()
            content()
        } else {
            content()
            content2()
        }
    }
}

#Preview {
    SwappableView(isSwapped: false) {
        Text("1")
    } content2: {
        Text("2")
    }

}
