//
//  ScheduleView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/17.
//

import SwiftUI

struct ScheduleView: View {
    @EnvironmentObject var modelData: ScheduleModelData
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                ForEach(0..<modelData.schedules.count) {i in
                    VStack(spacing: 5) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(timeDescription(startTime: modelData.schedules[i].startTime, endTime: modelData.schedules[i].endTime))
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                Text(status(i: i, startTime: modelData.schedules[i].startTime, endTime: modelData.schedules[i].endTime))
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
                            CardView(image: String(format: "%@%@", Splatnet2URL, modelData.schedules[i].stageA.image), icon: modelData.schedules[i].rule.rawValue, headline: modelData.schedules[i].rule.description, title: modelData.schedules[i].stageA.description)
                            CardView(image: String(format: "%@%@", Splatnet2URL, modelData.schedules[i].stageB.image), icon: modelData.schedules[i].rule.rawValue, headline: modelData.schedules[i].rule.description, title: modelData.schedules[i].stageB.description)
                        }
                    }
                }
            }
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
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        let modelData = ScheduleModelData(gameMode: Schedule.GameMode.gachi)
        
        let asset = NSDataAsset(name: "schedules", bundle: Bundle.main)!
        
        _ = modelData.load(data: asset.data)
        
        return ScheduleView()
            .environmentObject(modelData)
    }
}
