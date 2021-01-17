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
            VStack(spacing: 40) {
                ForEach(0..<schedules.count) {i in
                    VStack(spacing: 5) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(timeDescription(startTime: schedules[i].startTime, endTime: schedules[i].endTime))
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                Text(status(i: i, startTime: schedules[i].startTime, endTime: schedules[i].endTime))
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
                            CardView(image: String(format: "%@%@", Splatnet2URL, schedules[i].stageA.image), icon: schedules[i].rule.rawValue, headline: schedules[i].rule.description, title: schedules[i].stageA.description)
                            CardView(image: String(format: "%@%@", Splatnet2URL, schedules[i].stageB.image), icon: schedules[i].rule.rawValue, headline: schedules[i].rule.description, title: schedules[i].stageB.description)
                        }
                    }
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

    func status(i: Int, startTime: Date, endTime: Date) -> String {
        switch i {
        case 0:
            return "now"
        case 1:
            return "next"
        default:
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
