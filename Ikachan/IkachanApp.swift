//
//  IkachanApp.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/14.
//

import SwiftUI
import Kingfisher

@main
struct IkachanApp: App {
    @StateObject var modelData = ModelData()
    
    init() {
        KingfisherManager.shared.downloader.downloadTimeout = Timeout
        KingfisherManager.shared.cache.diskStorage.config.expiration = .never
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
