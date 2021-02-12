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
        TabView(selection: $modelData.tab) {
            SchedulesView(showModal: $showAbout)
                .tabItem {
                    Label("schedule", systemImage: "calendar")
                }
                .tag(Tab.schedule)
            ShiftsView(showModal: $showAbout)
                .tabItem {
                    Label("shift", systemImage: "lifepreserver")
                }
                .tag(Tab.shift)
        }
        .sheet(isPresented: $showAbout) {
            AboutView(showModal: $showAbout)
        }
        .onOpenURL { url in
            guard let tab = url.tab else {
                return
            }
            
            modelData.tab = tab
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
