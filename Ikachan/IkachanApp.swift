//
//  IkachanApp.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/14.
//

import SwiftUI

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
        }
        .onChange(of: scenePhase) { (phase) in
            if phase == .active {
                guard let type = shortcutItemToProcess?.type else {
                    return
                }
                shortcutItemToProcess = nil
                
                if let gameMode = Schedule.GameMode(rawValue: type) {
                    modelData.tab = Tab.schedule
                    modelData.gameMode = gameMode
                }
                
                if type == Shift.subURL {
                    modelData.tab = Tab.shift
                }
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
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
