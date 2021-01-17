//
//  ContentView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/14.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .regular
    
    enum Tab {
        case regular
        case ranked
        case league
        case salmon_run
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ScheduleView(gameMode: Schedule.GameMode.regular)
                .tabItem {
                    Label("regular", systemImage: "star")
                }
                .tag(Tab.regular)
            ScheduleView(gameMode: Schedule.GameMode.gachi)
                .tabItem {
                    Label("ranked", systemImage: "star")
                }
                .tag(Tab.regular)
            ScheduleView(gameMode: Schedule.GameMode.league)
                .tabItem {
                    Label("league", systemImage: "star")
                }
                .tag(Tab.regular)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
