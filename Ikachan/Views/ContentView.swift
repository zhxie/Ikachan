//
//  ContentView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/14.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .schedule
    
    enum Tab {
        case schedule
        case shift
    }
    
    var body: some View {
        TabView(selection: $selection) {
            SchedulesView()
                .tabItem {
                    Label("schedule", systemImage: "calendar")
                }
                .tag(Tab.schedule)
            ShiftsView()
                .tabItem {
                    Label("shift", systemImage: "hammer")
                }
                .tag(Tab.shift)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
