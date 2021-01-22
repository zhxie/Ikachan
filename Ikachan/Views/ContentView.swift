//
//  ContentView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/14.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: TabIdentifier = .schedule
    
    var body: some View {
        TabView(selection: $selection) {
            SchedulesView()
                .tabItem {
                    Label("schedule", systemImage: "calendar")
                }
                .tag(TabIdentifier.schedule)
            ShiftsView()
                .tabItem {
                    Label("shift", systemImage: "person.crop.square.fill.and.at.rectangle")
                }
                .tag(TabIdentifier.shift)
        }
        .onOpenURL { url in
            guard let tabIdentifier = url.tabIdentifier else {
                return
            }
            
            selection = tabIdentifier
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
