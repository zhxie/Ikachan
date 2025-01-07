import SwiftUI

struct ShiftsView: View {
    var mode: any ShiftMode
    var shifts: [Shift]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [mode.accentColor, mode.accentColor.opacity(0)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            ScrollView {
                ShiftView(shift: shifts.first!)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                if shifts.count > 1 {
                    Separator()
                    
                    ShiftView(shift: shifts.at(index: 1)!)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
    }
}

#Preview {
    ShiftsView(mode: Splatoon2ShiftMode.salmonRun, shifts: [PreviewSplatoon2Shift, PreviewSplatoon3Shift])
}
