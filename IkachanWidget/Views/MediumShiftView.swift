//
//  MediumShiftView.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/1/24.
//

import SwiftUI
import WidgetKit

struct MediumShiftView: View {
    let current: Date
    let shift: Shift?
    let mode: Mode
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea(edges: .all)
            
            if let shift = shift {
                GeometryReader { g in
                    HStack {
                        VStack(spacing: 0) {
                            HStack {
                                TopLeadingView(text: shiftTimePeriod(startTime: shift.startTime, endTime: shift.endTime))
                                    .layoutPriority(1)
                                
                                Spacer()
                                    .frame(minWidth: 0)
                            }
                            
                            Spacer()
                                .frame(height: 8)
                            
                            VStack {
                                StageView(stage: shift.stage!)
                                
                                HStack {
                                    WeaponView(weapon: shift.weapons[0])
                                    WeaponView(weapon: shift.weapons[1])
                                    WeaponView(weapon: shift.weapons[2])
                                    WeaponView(weapon: shift.weapons[3])
                                }
                            }
                        }
                        .frame(width: g.size.width / 2 - 5)
                        
                        Spacer()
                            .frame(width: 15)
                        
                        SmallShiftView(current: current, shift: shift, mode: mode, subview: true)
                    }
                }
                .padding()
            } else {
                FailedToLoadView(accentColor: mode.accentColor, error: .noShift)
                    .padding()
            }
        }
    }
}

struct MediumShiftView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MediumShiftView(current: Date(), shift: ShiftPlaceholder, mode: Splatoon2ShiftMode.salmonRun)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
