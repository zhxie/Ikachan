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
            TabView {
                NavigationView {
                    SchedulesView()
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Label("schedule", systemImage: "calendar")
                }
                
                NavigationView {
                    ShiftsView()
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Label("shift", systemImage: "lifepreserver")
                }
                
                NavigationView {
                    AboutView()
                }
                .navigationViewStyle(.stack)
                .tabItem {
                    Label("ikachan", systemImage: "info.circle")
                }
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
