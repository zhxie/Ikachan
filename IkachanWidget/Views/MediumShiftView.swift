//
//  MediumShiftView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/24.
//

import SwiftUI
import Kingfisher

struct MediumShiftView: View {
    var current: Date
    var shift: Shift?
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea(edges: .all)
            
            if shift != nil {
                GeometryReader { g in
                    HStack {
                        VStack(spacing: 0) {
                            HStack {
                                Text(g.size.width >= CompactMediumWidgetSafeWidth ? shiftTimePeriod(startTime: shift?.startTime ?? Date(timeIntervalSince1970: 0), endTime: shift?.endTime ?? Date(timeIntervalSince1970: 0)) : shiftTimePeriod2(startTime: shift?.startTime ?? Date(timeIntervalSince1970: 0), endTime: shift?.endTime ?? Date(timeIntervalSince1970: 0)))
                                    .accessibility(label: Text(shiftTimePeriod(startTime: shift?.startTime ?? Date(timeIntervalSince1970: 0), endTime: shift?.endTime ?? Date(timeIntervalSince1970: 0))))
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
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
                                        KFImage(URL(string: shift?.stage?.url ?? "")!)
                                            .placeholder {
                                                Rectangle()
                                                    .foregroundColor(Color(UIColor.secondarySystemBackground))
                                            }
                                            .resizable()
                                            .accessibility(label: Text(shift?.stage?.description ?? ""))
                                            .aspectRatio(contentMode: .fill)
                                            .clipped()
                                    )
                                    .cornerRadius(7.5)
                                
                                HStack {
                                    Rectangle()
                                        .fill(Color.clear)
                                        .aspectRatio(1, contentMode: .fit)
                                        .overlay(
                                            KFImage(URL(string: shift?.weapons[0].url ?? "")!)
                                                .placeholder {
                                                    Circle()
                                                        .foregroundColor(Color(UIColor.secondarySystemBackground))
                                                }
                                                .resizable()
                                                .accessibility(label: Text(shift?.weapons[0].description ?? ""))
                                                .aspectRatio(contentMode: .fill)
                                                .clipped()
                                        )
                                        .cornerRadius(7.5)
                                    Rectangle()
                                        .fill(Color.clear)
                                        .aspectRatio(1, contentMode: .fit)
                                        .overlay(
                                            KFImage(URL(string: shift?.weapons[1].url ?? "")!)
                                                .placeholder {
                                                    Circle()
                                                        .foregroundColor(Color(UIColor.secondarySystemBackground))
                                                }
                                                .resizable()
                                                .accessibility(label: Text(shift?.weapons[1].description ?? ""))
                                                .aspectRatio(contentMode: .fill)
                                                .clipped()
                                        )
                                        .cornerRadius(7.5)
                                    Rectangle()
                                        .fill(Color.clear)
                                        .aspectRatio(1, contentMode: .fit)
                                        .overlay(
                                            KFImage(URL(string: shift?.weapons[2].url ?? "")!)
                                                .placeholder {
                                                    Circle()
                                                        .foregroundColor(Color(UIColor.secondarySystemBackground))
                                                }
                                                .resizable()
                                                .accessibility(label: Text(shift?.weapons[2].description ?? ""))
                                                .aspectRatio(contentMode: .fill)
                                                .clipped()
                                        )
                                        .cornerRadius(7.5)
                                    Rectangle()
                                        .fill(Color.clear)
                                        .aspectRatio(1, contentMode: .fit)
                                        .overlay(
                                            KFImage(URL(string: shift?.weapons[3].url ?? "")!)
                                                .placeholder {
                                                    Circle()
                                                        .foregroundColor(Color(UIColor.secondarySystemBackground))
                                                }
                                                .resizable()
                                                .accessibility(label: Text(shift?.weapons[3].description ?? ""))
                                                .aspectRatio(contentMode: .fill)
                                                .clipped()
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
                                Text(timeSpanDescriptor(current: current, startTime: shift?.startTime ?? current))
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
                                Text(absoluteTimeSpan(current: current, startTime: shift?.startTime ?? current, endTime: shift?.endTime ?? current))
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
                                    Text(shift?.stage?.description ?? "")
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                        .lineLimit(1)
                                }
                                .layoutPriority(1)
                                
                                Spacer()
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
                .previewLayout(.fixed(width: 360, height: 169))
            MediumShiftView(current: Date(), shift: ShiftPlaceholder)
                .previewLayout(.fixed(width: 291, height: 141))
        }
    }
}
