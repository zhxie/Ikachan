//
//  ShiftView.swift
//  Ikachan
//
//  Created by Sketch on 2023/12/11.
//

import SwiftUI

struct ShiftView: View {
    var shift: Shift
    var backgroundColor = Color(.secondarySystemBackground)
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image(shift.mode.image)
                    .resizedToFit()
                    .frame(width: 16, height: 16)
                    .layoutPriority(1)
                Text(LocalizedStringKey(shift.mode.name))
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                Spacer()
                
                Text(timeSpan(start: shift.startTime, end: shift.endTime))
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .layoutPriority(1)
            }
            if shift.stage != nil {
                HStack {
                    StageView(stage: shift.stage!, backgroundColor: backgroundColor)
                    VStack {
                        if let kingSalmonid = shift.kingSalmonid {
                            HStack {
                                if let image = kingSalmonid.image {
                                    Image(image)
                                        .resizedToFit()
                                        .frame(width: 20, height: 20)
                                }
                                Text(kingSalmonid.name)
                                    .lineLimit(1)
                            }
                        }
                        
                        WeaponsView(weapons: shift.weapons!, backgroundColor: backgroundColor)
                    }
                }
            }
        }
    }
}

#Preview {
    ShiftView(shift: PreviewSplatoon3Shift)
}
