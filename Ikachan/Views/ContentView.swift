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
        TabView(selection: $modelData.tab) {
            SchedulesView()
                .tabItem {
                    Label("schedule", systemImage: "calendar")
                }
                .tag(Tab.schedule)
            ShiftsView()
                .tabItem {
                    Label("shift", systemImage: "lifepreserver")
                }
                .tag(Tab.shift)
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
