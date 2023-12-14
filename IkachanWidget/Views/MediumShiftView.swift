//
//  MediumShiftView.swift
//  IkachanWidget
//
//  Created by Sketch on 2023/12/13.
//

import SwiftUI
import WidgetKit

struct MediumShiftView: View {
    var shift: Shift?
    var nextShift: Shift?

    var body: some View {
        if let shift = shift {
            VStack(spacing: 8) {
                HStack(alignment: .center) {
                    Image(shift.mode.image)
                        .resizedToFit()
                        .frame(width: 20, height: 20)
                        .layoutPriority(1)
                    Text(LocalizedStringKey(shift.mode.name))
                        .fontWeight(.bold)
                        .foregroundColor(shift.mode.accentColor)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Text(absoluteTimeSpan(start: shift.startTime, end: shift.endTime))
                        .monospacedDigit()
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                        .layoutPriority(1)
                }
                .layoutPriority(1)
                
                if let stage = shift.stage {
                    HStack(alignment: .center) {
                        StageView(stage: stage)
                        
                        HStack {
                            ForEach(shift.weapons!, id: \.name) { weapon in
                                WeaponView(weapon: weapon)
                            }
                        }
                    }
                } else {
                    Spacer()
                }
                
                if let shift = nextShift {
                    if let stage = shift.stage {
                        HStack(alignment: .center) {
                            Text(LocalizedStringKey("next"))
                                .font(.footnote)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemBackground))
                                .padding(4)
                                .background {
                                    Rectangle()
                                        .foregroundColor(shift.mode.accentColor)
                                        .cornerRadius(4)
                                }
                                .layoutPriority(1)
                            
                            Spacer()
                            
                            Text(stage.name)
                                .font(.footnote)
                            
                            ForEach(shift.weapons!, id: \.name) { weapon in
                                WeaponView(weapon: weapon)
                                    .frame(height: 20)
                            }
                            .layoutPriority(1)
                        }
                        .layoutPriority(1)
                    }
                }
            }
        } else {
            Text(LocalizedStringKey("no_shift"))
        }
    }
}

@available(iOSApplicationExtension 17.0, *)
struct MediumShiftView_Previews: PreviewProvider {
    static var previews: some View {
        MediumShiftView(shift: PreviewSplatoon2Shift, nextShift: PreviewSplatoon3Shift)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
