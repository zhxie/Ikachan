import SwiftUI

struct ShiftsView: View {
    var mode: any ShiftMode
    var shifts: [Shift]
    
    var body: some View {
        List {
            ForEach(shifts, id: \.startTime) { shift in
                ShiftView(shift: shift, shrinkToFit: true)
            }
        }
        .navigationTitle(LocalizedStringKey(mode.name))
    }
}

#Preview {
    ShiftsView(mode: Splatoon2ShiftMode.salmonRun, shifts: [PreviewSplatoon2Shift, PreviewSplatoon3Shift])
}
