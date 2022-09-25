//
//  ContentView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/14.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ZStack {
            TabView(selection: $modelData.tab) {
                NavigationView {
                    SchedulesView()
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Label("schedule", systemImage: "calendar")
                }
                .tag(Tab.schedule)
                
                NavigationView {
                    ShiftsView()
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Label("shift", systemImage: "lifepreserver")
                }
                .tag(Tab.shift)
                
                NavigationView {
                    AboutView()
                }
                .navigationViewStyle(.stack)
                .tabItem {
                    Label("ikachan", systemImage: "info.circle")
                }
                .tag(Tab.about)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
