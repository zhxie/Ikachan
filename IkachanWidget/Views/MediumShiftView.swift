//
//  MediumShiftView.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/1/24.
//

import SwiftUI
import WidgetKit
import Kingfisher

struct MediumShiftView: View {
    var current: Date
    var shift: Shift?
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea(edges: .all)
            
            if let shift = shift {
                GeometryReader { g in
                    HStack {
                        VStack(spacing: 0) {
                            HStack {
                                LeadingLeftView(text: shiftTimePeriod(startTime: shift.startTime, endTime: shift.endTime))
                                    .layoutPriority(1)
                                
                                Spacer()
                                    .frame(minWidth: 0)
                            }
                            
                            Spacer()
                                .frame(height: 8)
                            
                            VStack {
                                StageView(image: shift.stage?.url ?? "", accessibility: shift.stage?.description ?? "")
                                
                                HStack {
                                    WeaponView(image: shift.weapons[0].url, accessibility: shift.weapons[0].description)
                                    WeaponView(image: shift.weapons[1].url, accessibility: shift.weapons[1].description)
                                    WeaponView(image: shift.weapons[2].url, accessibility: shift.weapons[2].description)
                                    WeaponView(image: shift.weapons[3].url, accessibility: shift.weapons[3].description)
                                }
                            }
                        }
                        .frame(width: g.size.width / 2 - 5)
                        
                        Spacer()
                            .frame(width: 15)
                        
                        SmallShiftView(current: current, shift: shift, subview: true)
                    }
                }
                .padding()
            } else {
                FailedToLoadView(accentColor: Shift.accentColor)
                    .padding()
            }
        }
    }
}

struct MediumShiftView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MediumShiftView(current: Date(), shift: ShiftPlaceholder)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
