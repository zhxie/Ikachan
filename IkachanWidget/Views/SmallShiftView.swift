//
//  SmallShiftView.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/2/7.
//

import SwiftUI
import WidgetKit

struct SmallShiftView: View {
    var current: Date
    var shift: Shift?
    var subview: Bool = false
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea(edges: .all)
            
            if let shift = shift {
                SmallBaseView(text: absoluteTimeSpan(current: current, startTime: shift.startTime, endTime: shift.endTime), indicatorText: Shift.description, color: Shift.accentColor) {
                    VStack(spacing: 0) {
                        HStack {
                            TrailingView(text: shift.stage?.description ?? "")
                                .layoutPriority(1)
                            
                            Spacer()
                                .frame(minWidth: 0)
                        }
                        
                        if !subview {
                            Spacer()
                                .frame(height: 4)
                            
                            HStack {
                                WeaponView(image: shift.weapons[0].url, title: shift.weapons[0].description)
                                WeaponView(image: shift.weapons[1].url, title: shift.weapons[1].description)
                                WeaponView(image: shift.weapons[2].url, title: shift.weapons[2].description)
                                WeaponView(image: shift.weapons[3].url, title: shift.weapons[3].description)
                            }
                        }
                    }
                } leadingLeft: {
                    if subview {
                        LeadingLeftView(text: LocalizedStringKey(timeSpanDescriptor(current: current, startTime: shift.startTime)))
                    } else {
                        LeadingLeftView(text: shiftTimePeriod2(startTime: shift.startTime, endTime: shift.endTime))
                    }
                } leadingRight: {
                    LeadingRightView(text: subview ? Shift.description : Shift.shortDescription, color: Shift.accentColor)
                }
                .padding(subview ? [] : [.all])
            } else {
                FailedToLoadView(accentColor: Shift.accentColor)
                    .padding()
            }
        }
    }
}

struct SmallShiftView_Previews: PreviewProvider {
    static var previews: some View {
        SmallShiftView(current: Date(), shift: ShiftPlaceholder)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
