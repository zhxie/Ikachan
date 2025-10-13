import SwiftUI

struct ShiftsNavigationLink: View {
    var shifts: [Shift]
    
    @State var showSheet = false
    
    var body: some View {
        Button {
            showSheet = true
        } label: {
            CardView(image: shifts.first!.mode.image, accentColor: shifts.first!.mode.accentColor, name: shifts.first!.mode.name) {
                ShiftView(shift: shifts.first!, nextShift: shifts.at(index: 1))
            }
        }
        .buttonStyle(CardButtonStyle())
        .sheet(isPresented: $showSheet) {
            NavigationView {
                ShiftsView(mode: shifts.first!.mode, shifts: shifts)
            }
        }
    }
}

#Preview {
    ShiftsNavigationLink(shifts: [PreviewSplatoon2Shift, PreviewSplatoon3Shift])
}
