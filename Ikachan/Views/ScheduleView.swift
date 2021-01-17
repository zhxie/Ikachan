//
//  ScheduleView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/17.
//

import SwiftUI

struct ScheduleView: View {
    @EnvironmentObject var modelData: ModelData
    
    var gameMode: Schedule.GameMode
    
    var body: some View {
        ScrollView {
            VStack(spacing: 60) {
                ForEach(schedules, id: \.self) { schedule in
                    VStack(spacing: 15) {
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(status(startTime: schedule.startTime, endTime: schedule.endTime))
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                                Text(schedule.rule.description)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                    .lineLimit(1)
                            }
                            .layoutPriority(1)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        VStack(spacing: 20) {
                            CardView(image: String(format: "%@%@", Splatnet2URL, schedule.stageA.image), title: schedule.stageA.description)
                            CardView(image: String(format: "%@%@", Splatnet2URL, schedule.stageB.image), title: schedule.stageB.description)
                        }
                    }
                }
            }
            .padding(.vertical)
        }
        .onAppear(perform: update)
    }
    
    var schedules: [Schedule] {
        modelData.schedules.filter { schedule in
            schedule.gameMode == gameMode
        }
    }

    func status(startTime: Date, endTime: Date) -> String {
        let current = Date()
        
        if startTime < current {
            return timeDescription(startTime: startTime, endTime: endTime)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            
            let startTime = dateFormatter.string(from: startTime)
            let endTime = dateFormatter.string(from: endTime)
            
            return String(format: "%@ - %@", startTime, endTime)
        }
    }

    func update() {
        modelData.updateSchedules()
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        let modelData = ModelData()
        
        let asset = NSDataAsset(name: "schedules", bundle: Bundle.main)!
        
        _ = modelData.loadSchedules(data: asset.data)
        
        return ScheduleView(gameMode: Schedule.GameMode.gachi)
            .environmentObject(modelData)
    }
}
