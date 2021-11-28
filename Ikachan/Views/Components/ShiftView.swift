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
                        .lineLimit(1)
                    Text(status(startTime: shift.startTime, endTime: shift.endTime))
                        .font(.callout)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                .layoutPriority(1)
                
                Spacer()
                
                Image("salmon_run")
                    .resizedToFit()
                    .frame(width: 50, height: 50)
            }
            
            if let stage = shift.stage {
                ShiftImages(image: stage.url, title: stage.description, subImage1: shift.weapons[0].url, subTitle1: shift.weapons[0].description, subImage2: shift.weapons[1].url, subTitle2: shift.weapons[1].description, subImage3: shift.weapons[2].url, subTitle3: shift.weapons[2].description, subImage4: shift.weapons[3].url, subTitle4: shift.weapons[3].description)
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
        ShiftView(shift: ShiftPlaceholder, title: "open")
    }
}
