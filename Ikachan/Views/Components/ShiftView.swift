//
//  ShiftView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/18.
//

import SwiftUI

struct ShiftView: View {
    let shift: Shift
    let title: String
    
    var body: some View {
        ScheduleBaseView(title: title, subtitle: status(startTime: shift.startTime, endTime: shift.endTime), image: "salmon_run") {
            if let stage = shift.stage {
                HStack {
                    StageView(image: stage.url, title: stage.description)
                    
                    VStack {
                        Rectangle()
                            .fill(Color.clear)
                            .aspectRatio(16 / 9, contentMode: .fit)
                            .overlay(
                                VStack {
                                    HStack {
                                        WeaponView(image: shift.weapons[0].url, title: shift.weapons[0].description)
                                        WeaponView(image: shift.weapons[1].url, title: shift.weapons[1].description)
                                    }
                                    HStack {
                                        WeaponView(image: shift.weapons[2].url, title: shift.weapons[2].description)
                                        WeaponView(image: shift.weapons[3].url, title: shift.weapons[3].description)
                                    }
                                }
                            )
                        
                        Text("weapons")
                            .font(.footnote)
                            .lineLimit(1)
                            .foregroundColor(.clear)
                            .accessibilityHidden(true)
                    }
                }
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
