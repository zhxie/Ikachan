//
//  SchedulesView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/18.
//

import SwiftUI

struct SchedulesView: View {
    @EnvironmentObject var modelData: ModelData
    
    @State var gameMode = Schedule.GameMode.regular
    // HACK: Consider rule turfWar as no filtering
    @State var rule = Schedule.Rule.turfWar
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(schedules, id: \.self) { schedule in
                        Divider()
                        
                        ScheduleView(schedule: schedule)
                        
                        Spacer()
                            .frame(height: 15)
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
                    switch rule {
                    case Schedule.Rule.turfWar:
                        Menu(content: {
                            ForEach(Schedule.Rule.allCases.filter { r in
                                r != Schedule.Rule.turfWar
                            }, id: \.self) { r in
                                Button(action: {
                                    rule = r
                                }) {
                                    Text(r.description)
                                    Image(r.rawValue)
                                }
                            }
                        }, label: {
                            Image(systemName: "line.horizontal.3.decrease.circle")
                                .imageScale(.large)
                        })
                    default:
                        Button(action: {
                            rule = Schedule.Rule.turfWar
                        }) {
                            Image(systemName: "line.horizontal.3.decrease.circle.fill")
                        }
                    }
                }
            }
        }
        .onAppear(perform: update)
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
