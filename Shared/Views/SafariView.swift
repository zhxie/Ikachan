import SwiftUI
import SafariServices

// Referenced from https://www.danijelavrzan.com/posts/2023/03/in-app-safari-view.
struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}

struct SafariButton: View {
    @State var showSafari = false
    
    var title: LocalizedStringKey
    var url: URL
    
    var body: some View {
        Button(title) {
            showSafari = true
        }
        .popover(isPresented: $showSafari) {
            SafariView(url: url)
                .ignoresSafeArea(.all)
        }
    }
}
