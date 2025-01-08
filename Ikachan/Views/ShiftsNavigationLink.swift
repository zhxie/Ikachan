import SwiftUI

struct ShiftsNavigationLink: View {
    var shifts: [Shift]
    
    var body: some View {
        NavigationLink {
            ShiftsView(mode: shifts.first!.mode, shifts: shifts)
        } label: {
            CardView(image: shifts.first!.mode.image, accentColor: shifts.first!.mode.accentColor, name: shifts.first!.mode.name) {
                ShiftView(shift: shifts.first!, nextShift: shifts.at(index: 1))
            }
        }
        .buttonStyle(CardButtonStyle())
    }
}

#Preview {
    ShiftsNavigationLink(shifts: [PreviewSplatoon2Shift, PreviewSplatoon3Shift])
}
