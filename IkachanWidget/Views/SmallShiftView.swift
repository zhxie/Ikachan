//
//  SmallShiftView.swift
//  IkachanWidgetExtension
//
//  Created by Sketch on 2021/2/7.
//

import SwiftUI
import WidgetKit
import Kingfisher

struct SmallShiftView: View {
    var current: Date
    var shift: Shift?
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea(edges: .all)
            
            if let shift = shift {
                GeometryReader { g in
                    VStack(spacing: 0) {
                        HStack {
                            Text(g.size.width >= CompactSmallWidgetSafeWidth ? shiftTimePeriod(startTime: shift.startTime, endTime: shift.endTime) : shiftTimePeriod2(startTime: shift.startTime, endTime: shift.endTime))
                                .accessibility(label: Text(shiftTimePeriod(startTime: shift.startTime, endTime: shift.endTime)))
                                .font(.caption2)
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                                .layoutPriority(1)
                            
                            Spacer()
                                .frame(minWidth: 0)
                        }
                        .layoutPriority(1)
                        
                        Spacer()
                            .frame(height: 4)
                            .layoutPriority(1)
                        
                        HStack {
                            Text(absoluteTimeSpan(current: current, startTime: shift.startTime, endTime: shift.endTime))
                                .fontWeight(.light)
                                .font(.largeTitle)
                                .lineLimit(1)
                                .layoutPriority(1)
                            
                            Spacer()
                            
                            Image(systemName: "circle.fill")
                                .accessibility(label: Text(Shift.description))
                                .font(.footnote)
                                .foregroundColor(Shift.accentColor)
                        }
                        .layoutPriority(1)
                        
                        Spacer()
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(shift.stage?.description ?? "")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                            }
                            
                            Spacer()
                                .frame(minWidth: 0)
                        }
                        
                        Spacer()
                            .frame(height: 4)
                        
                        HStack {
                            Rectangle()
                                .fill(Color.clear)
                                .aspectRatio(1, contentMode: .fit)
                                .overlay(
                                    KFImage(URL(string: shift.weapons[0].url)!)
                                        .placeholder {
                                            Circle()
                                                .foregroundColor(Color(UIColor.secondarySystemBackground))
                                        }
                                        .resizable()
                                        .accessibility(label: Text(shift.weapons[0].description))
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                )
                                .cornerRadius(7.5)
                            Rectangle()
                                .fill(Color.clear)
                                .aspectRatio(1, contentMode: .fit)
                                .overlay(
                                    KFImage(URL(string: shift.weapons[1].url)!)
                                        .placeholder {
                                            Circle()
                                                .foregroundColor(Color(UIColor.secondarySystemBackground))
                                        }
                                        .resizable()
                                        .accessibility(label: Text(shift.weapons[1].description))
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                )
                                .cornerRadius(7.5)
                            Rectangle()
                                .fill(Color.clear)
                                .aspectRatio(1, contentMode: .fit)
                                .overlay(
                                    KFImage(URL(string: shift.weapons[2].url)!)
                                        .placeholder {
                                            Circle()
                                                .foregroundColor(Color(UIColor.secondarySystemBackground))
                                        }
                                        .resizable()
                                        .accessibility(label: Text(shift.weapons[2].description))
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                )
                                .cornerRadius(7.5)
                            Rectangle()
                                .fill(Color.clear)
                                .aspectRatio(1, contentMode: .fit)
                                .overlay(
                                    KFImage(URL(string: shift.weapons[3].url)!)
                                        .placeholder {
                                            Circle()
                                                .foregroundColor(Color(UIColor.secondarySystemBackground))
                                        }
                                        .resizable()
                                        .accessibility(label: Text(shift.weapons[3].description))
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                )
                                .cornerRadius(7.5)
                        }
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

struct SmallShiftView_Previews: PreviewProvider {
    static var previews: some View {
        SmallShiftView(current: Date(), shift: ShiftPlaceholder)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
