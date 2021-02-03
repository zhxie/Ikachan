//
//  IkachanApp.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/14.
//

import SwiftUI
import Intents
import Kingfisher

let modelData = ModelData()
var shortcutItemToProcess: UIApplicationShortcutItem?

@main
struct IkachanApp: App {
    @Environment(\.scenePhase) var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .onContinueUserActivity("name.sketch.Ikachan.schedule.regular") { _ in
                    modelData.tab = .schedule
                    modelData.gameMode = .regular
                }
                .onContinueUserActivity("name.sketch.Ikachan.schedule.gachi") { _ in
                    modelData.tab = .schedule
                    modelData.gameMode = .gachi
                }
                .onContinueUserActivity("name.sketch.Ikachan.schedule.league") { _ in
                    modelData.tab = .schedule
                    modelData.gameMode = .league
                }
                .onContinueUserActivity("name.sketch.Ikachan.shift") { _ in
                    modelData.tab = .shift
                }
        }
        .onChange(of: scenePhase) { (phase) in
            if phase == .active {
                guard let type = shortcutItemToProcess?.type else {
                    return
                }
                shortcutItemToProcess = nil
                
                if let gameMode = Schedule.GameMode(rawValue: type) {
                    modelData.tab = .schedule
                    modelData.gameMode = gameMode
                }
                
                if type == Shift.rawValue {
                    modelData.tab = .shift
                }
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        KingfisherManager.shared.downloader.downloadTimeout = Timeout
        KingfisherManager.shared.cache.diskStorage.config.expiration = .never
        
        if let shortcutItem = options.shortcutItem {
            shortcutItemToProcess = shortcutItem
        }
        
        let sceneConfiguration = UISceneConfiguration(name: "Custom Configuration", sessionRole: connectingSceneSession.role)
        sceneConfiguration.delegateClass = CustomSceneDelegate.self
        
        return sceneConfiguration
    }
}

class CustomSceneDelegate: UIResponder, UIWindowSceneDelegate {
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        shortcutItemToProcess = shortcutItem
    }
}
