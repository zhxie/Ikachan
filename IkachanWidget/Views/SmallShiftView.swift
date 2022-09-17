//
//  SmallShiftView.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/2/7.
//

import SwiftUI
import WidgetKit

struct SmallShiftView: View {
    let current: Date
    let shift: Shift?
    let mode: Mode
    var subview = false
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea(edges: .all)
            
            if let shift = shift {
                SmallBaseView(text: absoluteTimeSpan(current: current, startTime: shift.startTime, endTime: shift.endTime), indicatorText: shift.mode.name, color: shift.mode.accentColor) {
                    VStack(spacing: 0) {
                        HStack {
                            BottomView(text: shift.stage?.name ?? "")
                                .layoutPriority(1)
                            
                            Spacer()
                                .frame(minWidth: 0)
                        }
                        
                        if !subview {
                            Spacer()
                                .frame(height: 4)
                            
                            HStack {
                                WeaponView(weapon: shift.weapons[0])
                                WeaponView(weapon: shift.weapons[1])
                                WeaponView(weapon: shift.weapons[2])
                                WeaponView(weapon: shift.weapons[3])
                            }
                        }
                    }
                } leadingLeft: {
                    if subview {
                        TopLeadingView(text: LocalizedStringKey(timeSpanDescriptor(current: current, startTime: shift.startTime)))
                    } else {
                        TopLeadingView(text: shiftShortTimePeriod(startTime: shift.startTime, endTime: shift.endTime))
                    }
                } leadingRight: {
                    TopTrailingView(text: subview ? shift.mode.name : shift.mode.shortName, color: shift.mode.accentColor)
                }
                .padding(subview ? [] : [.all])
            } else {
                FailedToLoadView(accentColor: mode.accentColor)
                    .padding()
            }
        }
    }
}

struct SmallShiftView_Previews: PreviewProvider {
    static var previews: some View {
        SmallShiftView(current: Date(), shift: ShiftPlaceholder, mode: Splatoon2ShiftMode.salmonRun)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
