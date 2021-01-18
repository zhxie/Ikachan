//
//  SchedulesView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/18.
//

import SwiftUI

struct SchedulesView: View {
    @EnvironmentObject var modelData: ModelData
    
    var gameMode: Schedule.GameMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(schedules, id: \.self) { schedule in
                        Divider()
                            .padding(.horizontal)
                        
                        ScheduleView(schedule: schedule)
                        
                        Spacer()
                            .frame(height: 15)
                    }
                }
                .padding(.vertical)
                .navigationTitle(gameMode.longDescription)
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
        
        return SchedulesView(gameMode: Schedule.GameMode.gachi)
            .environmentObject(modelData)
    }
}
