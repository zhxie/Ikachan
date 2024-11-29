import SwiftUI
import Kingfisher

@main
struct IkachanApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

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

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        configuration.delegateClass = SceneDelegate.self
        return configuration
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    func sceneDidDisconnect(_ scene: UIScene) {
        if ProcessInfo.processInfo.isiOSAppOnMac {
            exit(0)
        }
    }
}
