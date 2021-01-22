//
//  SchedulesView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/18.
//

import SwiftUI

struct SchedulesView: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.scenePhase) var scenePhase
    
    @State var gameMode = Schedule.GameMode.regular
    // HACK: Consider rule turfWar as no filtering
    @State var rule = Schedule.Rule.turfWar
    
    @State var showModal = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(schedules, id: \.self) { schedule in
                        VStack {
                            Divider()
                            
                            ScheduleView(schedule: schedule)
                            
                            Spacer()
                                .frame(height: 15)
                        }
                        .animation(.easeInOut)
                    }
                }
                .padding()
                .navigationTitle(gameMode.longDescription)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker(selection: $gameMode, label: Text("")) {
                        ForEach(Schedule.GameMode.allCases, id: \.self) { gameMode in
                            Text(gameMode.description)
                                .tag(gameMode)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                ToolbarItem(placement: .primaryAction) {
                    if rule == Schedule.Rule.turfWar {
                        Menu(content: {
                            ForEach(Schedule.Rule.allCases.filter { r in
                                r != Schedule.Rule.turfWar
                            }, id: \.self) { r in
                                Button(action: {
                                    Impact(style: .light)
                                    rule = r
                                }) {
                                    Text(r.description)
                                    Image(r.rawValue)
                                }
                            }
                        }) {
                            Image(systemName: "line.horizontal.3.decrease.circle")
                                .imageScale(.large)
                        }
                        .accessibility(label: Text("filter"))
                        .animation(.easeInOut(duration: 0.2))
                    } else {
                        Button(action: {
                            Impact(style: .light)
                            rule = Schedule.Rule.turfWar
                        }) {
                            Image(systemName: "line.horizontal.3.decrease.circle.fill")
                        }
                        .animation(.easeInOut(duration: 0.2))
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showModal.toggle()
                    }) {
                        Image(systemName: "info.circle")
                    }.sheet(isPresented: $showModal) {
                        AboutModalView()
                    }
                    .animation(.easeInOut(duration: 0.2))
                }
            }
        }
        .onAppear(perform: update)
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                update()
            }
        }
    }
    
    var schedules: [Schedule] {
        modelData.schedules.filter { schedule in
            schedule.gameMode == gameMode && (rule == Schedule.Rule.turfWar || rule == schedule.rule)
        }
    }
    
    func update() {
        modelData.updateSchedules()
    }
}

struct SchedulesView_Previews: PreviewProvider {
    static var previews: some View {
        let modelData = ModelData()
        
        let asset = NSDataAsset(name: "schedules", bundle: Bundle.main)!
        
        _ = modelData.loadSchedules(data: asset.data)
        
        return SchedulesView()
            .environmentObject(modelData)
    }
}
