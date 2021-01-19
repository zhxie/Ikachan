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
                            Text(gameMode.rawValue)
                                .tag(gameMode)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
        }
        .onAppear(perform: update)
    }
    
    var schedules: [Schedule] {
        modelData.schedules.filter { schedule in
            schedule.gameMode == gameMode
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
