//
//  ShiftView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/18.
//

import SwiftUI

struct ShiftView: View {
    let shift: Shift
    let sequence: Int
    
    var body: some View {
        ScheduleBaseView(title: title, subtitle: status(startTime: shift.startTime, endTime: shift.endTime), image: shift.mode.image) {
            if let stage = shift.stage {
                HStack {
                    StageView(stage: stage)
                    
                    VStack {
                        Rectangle()
                            .fill(Color.clear)
                            .aspectRatio(16 / 9, contentMode: .fit)
                            .overlay(
                                VStack {
                                    HStack {
                                        WeaponView(weapon: shift.weapons[0])
                                        WeaponView(weapon: shift.weapons[1])
                                    }
                                    HStack {
                                        WeaponView(weapon: shift.weapons[2])
                                        WeaponView(weapon: shift.weapons[3])
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
    
    var title: String {
        switch sequence {
        case 0:
            if shift.startTime < Date() {
                return "job_open"
            } else {
                return "job_soon"
            }
        case 1:
            return "job_next"
        default:
            return "job_future"
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
        ShiftView(shift: ShiftPlaceholder, sequence: 0)
    }
}
