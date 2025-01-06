import SwiftUI

struct ShiftsView: View {
    var mode: any ShiftMode
    var shifts: [Shift]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [mode.accentColor, .black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            List {
                ForEach(shifts.prefix(2), id: \.startTime) { shift in
                    HStack {
                        ShiftView(shift: shift)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
        }
    }
}

#Preview {
    ShiftsView(mode: Splatoon2ShiftMode.salmonRun, shifts: [PreviewSplatoon2Shift, PreviewSplatoon3Shift])
}
