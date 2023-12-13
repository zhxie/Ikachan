//
//  ShiftsView.swift
//  Ikachan
//
//  Created by Sketch on 2023/12/12.
//

import SwiftUI

struct ShiftsView: View {
    var mode: any ShiftMode
    var shifts: [Shift]
    
    var body: some View {
        List {
            ForEach(shifts, id: \.startTime) { shift in
                ShiftView(shift: shift, backgroundColor: Color(.secondarySystemGroupedBackground))
            }
        }
        .navigationTitle(LocalizedStringKey(mode.name))
    }
}

#Preview {
    ShiftsView(mode: Splatoon2ShiftMode.salmonRun, shifts: [PreviewSplatoon2Shift, PreviewSplatoon3Shift])
}
