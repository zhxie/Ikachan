//
//  ShiftsNavigationLink.swift
//  Ikachan
//
//  Created by Sketch on 2023/12/12.
//

import SwiftUI

struct ShiftsNavigationLink: View {
    var shifts: [Shift]
    
    var body: some View {
        NavigationLink {
            ShiftsView(mode: shifts.first!.mode, shifts: shifts)
        } label: {
            CardView(image: shifts.first!.mode.image, name: shifts.first!.mode.name) {
                ShiftView(shift: shifts.first!, nextShift: shifts.at(index: 1))
            }
        }
        .buttonStyle(CardButtonStyle())
    }
}

#Preview {
    ShiftsNavigationLink(shifts: [PreviewSplatoon2Shift, PreviewSplatoon3Shift])
}
