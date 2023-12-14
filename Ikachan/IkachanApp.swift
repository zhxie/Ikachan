import SwiftUI
import Kingfisher

@main
struct IkachanApp: App {
    init() {
        KingfisherManager.shared.downloader.downloadTimeout = Timeout
        KingfisherManager.shared.cache.diskStorage.config.expiration = .never
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
