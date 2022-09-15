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

    @Binding var showModal: Bool?
    
    @State var mode = "regular"
    // HACK: Consider rule turfWar as no filtering
    @State var rule = "turfWar"
    
    init() {
        _showModal = .constant(nil)
    }
    init(showModal: Binding<Bool>) {
        _showModal = Binding(showModal)
    }
    
    var body: some View {
        SchedulesScrollView(data: schedules, title: mode) { schedule in
            ScheduleView(schedule: schedule)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Picker(selection: $mode, label: Text("")) {
                    ForEach(Splatoon2ScheduleMode.allCases, id: \.self) { mode in
                        Text(LocalizedStringKey(mode.shortName))
                            .tag(mode.name)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                if rule == "" {
                    Menu(content: {
                        ForEach(Splatoon2Rule.allCases.filter { rule in
                            rule.name != "turfWar"
                        }, id: \.self) { rule in
                            Button(action: {
                                Impact(style: .light)
                                self.rule = rule.name
                            }) {
                                Text(LocalizedStringKey(rule.name))
                                Image(rule.image)
                            }
                        }
                    }) {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .imageScale(.large)
                    }
                    .accessibilityLabel("filter")
                } else {
                    Button(action: {
                        Impact(style: .light)
                        rule = "turfWar"
                    }) {
                        Image(systemName: "line.horizontal.3.decrease.circle.fill")
                    }
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                if showModal != nil {
                    Button(action: {
                        showModal!.toggle()
                    }) {
                        Image(systemName: "info.circle")
                    }
                }
            }
        }
        .onAppear(perform: {
            update()
        })
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                update()
            }
        }
    }
    
    var schedules: [Schedule] {
        modelData.schedules.filter { schedule in
            schedule.mode.name == mode && (rule == "turfWar" || schedule.rule.name == rule)
        }
    }
    
    func update() {
        modelData.updateSplatoon2Schedules()
    }
}

struct SchedulesView_Previews: PreviewProvider {
    static var previews: some View {
        SchedulesView(showModal: .constant(false))
            .environmentObject(ModelData())
    }
}
