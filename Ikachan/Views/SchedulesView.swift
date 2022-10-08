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
    
    var body: some View {
        SchedulesScrollView(data: schedules, title: modelData.mode) { schedule in
            ScheduleView(schedule: schedule)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    Impact(style: .light)
                    modelData.changeGame()
                    update()
                } label: {
                    Image(systemName: modelData.game.image)
                }
            }
            ToolbarItem(placement: .principal) {
                VStack {
                    // HACK: Offset for iOS 16.
                    if #available(iOS 16.0, *) {
                        Spacer()
                            .frame(height: 6)
                    }
                    
                    Picker(selection: $modelData.mode, label: Text("")) {
                        ForEach(0..<modelData.game.modes.count, id: \.self) { i in
                            Text(LocalizedStringKey(modelData.game.modes[i].shortName))
                                .tag(modelData.game.modes[i].name)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                if modelData.rule == "" {
                    Menu(content: {
                        ForEach(0..<modelData.game.rules.count, id: \.self) { i in
                            Button(action: {
                                Impact(style: .light)
                                modelData.rule = modelData.game.rules[i].name
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
                        modelData.rule = ""
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
            schedule.mode.name == modelData.mode && (modelData.rule == "" || schedule.rule.name == modelData.rule)
        }
    }
    
    func update() {
        modelData.updateSchedules()
    }
}

struct SchedulesView_Previews: PreviewProvider {
    static var previews: some View {
        SchedulesView()
            .environmentObject(ModelData())
    }
}
