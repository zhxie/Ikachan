//
//  MediumShiftView.swift
//  Ikachan
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
                                Text(g.size.width >= CompactMediumWidgetSafeWidth ? shiftTimePeriod(startTime: shift.startTime, endTime: shift.endTime) : shiftTimePeriod2(startTime: shift.startTime, endTime: shift.endTime))
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                                    .accessibility(label: Text(shiftTimePeriod(startTime: shift.startTime, endTime: shift.endTime)))
                                    .layoutPriority(1)
                                
                                Spacer()
                                    .frame(minWidth: 0)
                            }
                            
                            Spacer()
                                .frame(height: 8)
                            
                            VStack {
                                Rectangle()
                                    .fill(Color(UIColor.secondarySystemBackground))
                                    .overlay (
                                        KFImage(URL(string: shift.stage?.url ?? "")!)
                                            .placeholder {
                                                Rectangle()
                                                    .foregroundColor(Color(UIColor.secondarySystemBackground))
                                            }
                                            .resizedToFill()
                                            .clipped()
                                            .accessibility(label: Text(shift.stage?.description ?? ""))
                                    )
                                    .cornerRadius(7.5)
                                
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
                                                .resizedToFill()
                                                .clipped()
                                                .accessibility(label: Text(shift.weapons[0].description))
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
                                                .resizedToFill()
                                                .clipped()
                                                .accessibility(label: Text(shift.weapons[1].description))
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
                                                .resizedToFill()
                                                .clipped()
                                                .accessibility(label: Text(shift.weapons[2].description))
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
                                                .resizedToFill()
                                                .clipped()
                                                .accessibility(label: Text(shift.weapons[3].description))
                                        )
                                        .cornerRadius(7.5)
                                }
                            }
                        }
                        .frame(width: g.size.width / 2 - 5)
                        
                        Spacer()
                            .frame(width: 15)
                        
                        VStack(spacing: 0) {
                            HStack {
                                Text(timeSpanDescriptor(current: current, startTime: shift.startTime))
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                                    .layoutPriority(1)
                                
                                Spacer()
                                
                                Text(Shift.description)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(Shift.accentColor)
                                    .lineLimit(1)
                                    .layoutPriority(2)
                            }
                            .layoutPriority(1)
                            
                            Spacer()
                                .frame(height: 4)
                            
                            HStack {
                                Text(absoluteTimeSpan(current: current, startTime: shift.startTime, endTime: shift.endTime))
                                    .fontWeight(.light)
                                    .font(.largeTitle)
                                    .lineLimit(1)
                                    .layoutPriority(1)
                                
                                Spacer()
                                
                                Image(systemName: "circle.fill")
                                    .font(.footnote)
                                    .foregroundColor(Shift.accentColor)
                                    .accessibility(label: Text(Shift.description))
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
                                .layoutPriority(1)
                                
                                Spacer()
                                    .frame(minWidth: 0)
                            }
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

struct MediumShiftView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MediumShiftView(current: Date(), shift: ShiftPlaceholder)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
