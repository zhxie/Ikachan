//
//  ShiftView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/18.
//

import SwiftUI

struct ShiftView: View {
    var shift: Shift
    var title: LocalizedStringKey
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    Text(status(startTime: shift.startTime, endTime: shift.endTime))
                        .font(.callout)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                .layoutPriority(1)
                
                Spacer()
                
                Image("salmon_run")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
            
            if let stage = shift.stage {
                ShiftImages(image: Splatnet2URL + stage.image.rawValue, title: stage.description, subImage1: Splatnet2URL + shift.weapons[0].image, subTitle1: shift.weapons[0].description, subImage2: Splatnet2URL + shift.weapons[1].image, subTitle2: shift.weapons[1].description, subImage3: Splatnet2URL + shift.weapons[2].image, subTitle3: shift.weapons[2].description, subImage4: Splatnet2URL + shift.weapons[3].image, subTitle4: shift.weapons[3].description)
            }
        }
    }
    
    func status(startTime: Date, endTime: Date) -> String {
        let current = Date()
        
        if startTime < current {
            return naturalTimeSpan(startTime: startTime, endTime: endTime)
        } else {
            return shiftTimePeriod(startTime: startTime, endTime: endTime)
        }
    }
}

struct ShiftView_Previews: PreviewProvider {
    static var previews: some View {
        let modelData = ModelData()
        
        let asset = NSDataAsset(name: "shifts", bundle: Bundle.main)!
        
        _ = modelData.loadSchedules(data: asset.data)
        
        return ShiftView(shift: modelData.shifts[0], title: "open")
    }
}
