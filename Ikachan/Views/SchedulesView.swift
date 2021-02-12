//
//  SchedulesView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/18.
//

import SwiftUI
import Intents

struct SchedulesView: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.scenePhase) var scenePhase
    
    // HACK: Consider rule turfWar as no filtering
    @State var rule = Schedule.Rule.turfWar
    
    @Binding var showModal: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: ComponentMinWidth))]) {
                    ForEach(schedules, id: \.self) { schedule in
                        VStack {
                            Divider()
                            
                            ScheduleView(schedule: schedule)
                            
                            Spacer()
                                .frame(height: 15)
                        }
                    }
                }
                .animation(.default)
                .padding([.horizontal, .bottom])
                .navigationTitle(modelData.gameMode.longDescription)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker(selection: $modelData.gameMode, label: Text("")) {
                        ForEach(Schedule.GameMode.allCases, id: \.self) { gameMode in
                            Text(gameMode.description)
                                .tag(gameMode)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onChange(of: modelData.gameMode, perform: { gameMode in
                        interact(gameMode: gameMode)
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if rule == .turfWar {
                        Menu(content: {
                            ForEach(Schedule.Rule.allCases.filter { r in
                                r != .turfWar
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
                    } else {
                        Button(action: {
                            Impact(style: .light)
                            rule = .turfWar
                        }) {
                            Image(systemName: "line.horizontal.3.decrease.circle.fill")
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showModal.toggle()
                    }) {
                        Image(systemName: "info.circle")
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: {
            interact(gameMode: modelData.gameMode)
            
            update()
        })
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                update()
            }
        }
        .onOpenURL { url in
            guard let gameMode = url.gameMode else {
                return
            }
            
            modelData.gameMode = gameMode
        }
    }
    
    var schedules: [Schedule] {
        modelData.schedules.filter { schedule in
            schedule.gameMode == modelData.gameMode && (rule == .turfWar || rule == schedule.rule)
        }
    }
    
    func update() {
        modelData.updateSchedules()
    }
    
    func interact(gameMode: Schedule.GameMode) {
        let intent = ScheduleIntent()
        intent.gameMode = ScheduleIntentHandler.gameModeConvertFrom(gameMode: gameMode)
        
        INInteraction(intent: intent, response: nil).donate(completion: nil)
    }
}

struct SchedulesView_Previews: PreviewProvider {
    static var previews: some View {
        SchedulesView(showModal: .constant(false))
            .environmentObject(ModelData())
    }
}
