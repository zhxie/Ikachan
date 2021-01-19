//
//  ScheduleView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/18.
//

import SwiftUI

struct ScheduleView: View {
    var schedule: Schedule
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(schedule.rule.description)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    Text(status(startTime: schedule.startTime, endTime: schedule.endTime))
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
                .layoutPriority(1)
                
                Spacer()
                
                Image(schedule.rule.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
            
            ScheduleImages(imageA: Splatnet2URL + schedule.stageA.image, titleA: schedule.stageA.description, imageB: Splatnet2URL + schedule.stageB.image, titleB: schedule.stageB.description)
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
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        let modelData = ModelData()
        
        let asset = NSDataAsset(name: "schedules", bundle: Bundle.main)!
        
        _ = modelData.loadSchedules(data: asset.data)
        
        return ScheduleView(schedule: modelData.schedules[0])
    }
}
