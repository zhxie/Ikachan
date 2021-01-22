//
//  ContentView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/14.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .schedule
    
    var body: some View {
        TabView(selection: $selection) {
            SchedulesView()
                .tabItem {
                    Label("schedule", systemImage: "calendar")
                }
                .tag(Tab.schedule)
            ShiftsView()
                .tabItem {
                    Label("shift", systemImage: "person.crop.square.fill.and.at.rectangle")
                }
                .tag(Tab.shift)
        }
        .onOpenURL { url in
            guard let tab = url.tab else {
                return
            }
            
            selection = tab
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
