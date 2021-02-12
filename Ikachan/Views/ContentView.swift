//
//  ContentView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/14.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var modelData: ModelData
    
    @State var showAbout = false
    
    var body: some View {
        ZStack {
            if horizontalSizeClass == .compact {
                TabView(selection: $modelData.tab) {
                    NavigationView {
                        SchedulesView(showModal: $showAbout)
                    }
                    .tabItem {
                        Label("schedule", systemImage: "calendar")
                    }
                    .tag(Tab.schedule)
                    NavigationView {
                        ShiftsView(showModal: $showAbout)
                    }
                    .tabItem {
                        Label("shift", systemImage: "lifepreserver")
                    }
                    .tag(Tab.shift)
                }
            } else {
                NavigationView {
                    List {
                        NavigationLink(
                            destination: SchedulesView(),
                            tag: Tab.schedule,
                            selection: $modelData.nullableTab,
                            label: {
                                Label("schedule", systemImage: "calendar")
                            })
                        NavigationLink(
                            destination: ShiftsView(),
                            tag: Tab.shift,
                            selection: $modelData.nullableTab,
                            label: {
                                Label("shift", systemImage: "lifepreserver")
                            })
                    }
                    .listStyle(SidebarListStyle())
                    .navigationTitle("ikachan")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                showAbout.toggle()
                            }) {
                                Image(systemName: "info.circle")
                            }
                        }
                    }
                    EmptyView()
                }
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
