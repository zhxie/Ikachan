//
//  ContentView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/14.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    
    @State var showAbout = false
    
    var body: some View {
        ZStack {
            TabView(selection: $modelData.tab) {
                NavigationView {
                    SchedulesView(showModal: $showAbout)
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Label("schedule", systemImage: "calendar")
                }
                .tag(Tab.schedule)
                NavigationView {
                    ShiftsView(showModal: $showAbout)
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Label("shift", systemImage: "lifepreserver")
                }
                .tag(Tab.shift)
            }
        }
        .sheet(isPresented: $showAbout) {
            AboutView(showModal: $showAbout)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
