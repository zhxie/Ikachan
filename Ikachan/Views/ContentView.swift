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
        case current
        case regular
        case ranked
        case league
        case salmon_run
    }
    
    var body: some View {
        TabView(selection: $selection) {
            SchedulesView(gameMode: Schedule.GameMode.regular)
                .tabItem {
                    Label("regular", systemImage: "star")
                }
                .tag(Tab.regular)
            SchedulesView(gameMode: Schedule.GameMode.gachi)
                .tabItem {
                    Label("ranked", systemImage: "star")
                }
                .tag(Tab.ranked)
            SchedulesView(gameMode: Schedule.GameMode.league)
                .tabItem {
                    Label("league", systemImage: "star")
                }
                .tag(Tab.league)
            ShiftsView()
                .tabItem {
                    Label("salmon_run", systemImage: "star")
                }
                .tag(Tab.salmon_run)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
