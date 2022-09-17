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
    
    @State var mode = "regular_battle"
    @State var rule = ""
    
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
            ToolbarItem(placement: .navigationBarLeading) {
                if showModal != nil {
                    Button(action: {
                        showModal!.toggle()
                    }) {
                        Image(systemName: "info.circle")
                    }
                }
            }
            ToolbarItem(placement: .principal) {
                VStack {
                    // HACK: Offset for iOS 16.
                    if #available(iOS 16.0, *) {
                        Spacer()
                            .frame(height: 6)
                    }
                    
                    Picker(selection: $mode, label: Text("")) {
                        ForEach(0..<modelData.game.modes.count, id: \.self) { i in
                            Text(LocalizedStringKey(modelData.game.modes[i].shortName))
                                .tag(modelData.game.modes[i].name)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                if rule == "" {
                    Menu(content: {
                        ForEach(0..<modelData.game.rules.count, id: \.self) { i in
                            Button(action: {
                                Impact(style: .light)
                                self.rule = modelData.game.rules[i].name
                            }) {
                                Text(LocalizedStringKey(modelData.game.rules[i].name))
                                Image(modelData.game.rules[i].image)
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
                        rule = ""
                    }) {
                        Image(systemName: "line.horizontal.3.decrease.circle.fill")
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
            schedule.mode.name == mode && (rule == "" || schedule.rule.name == rule)
        }
    }
    
    func update() {
        modelData.updateSchedules()
    }
}

struct SchedulesView_Previews: PreviewProvider {
    static var previews: some View {
        SchedulesView(showModal: .constant(false))
            .environmentObject(ModelData())
    }
}
