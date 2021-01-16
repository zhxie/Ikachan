//
//  IkachanApp.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/14.
//

import SwiftUI

@main
struct IkachanApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ModelData)
        }
    }
}
