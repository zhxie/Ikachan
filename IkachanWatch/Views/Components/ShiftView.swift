import SwiftUI

struct ShiftView: View {
    var shift: Shift
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .center) {
                Image(shift.mode.image)
                    .resizedToFit()
                    .frame(width: 24, height: 24)
                    .layoutPriority(1)
                Text(LocalizedStringKey(shift.mode.name))
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(1)
            }
            
            Text(timeSpan(start: shift.startTime, end: shift.endTime))
                .monospacedDigit()
                .foregroundColor(.secondary)
                .lineLimit(1)
                .layoutPriority(1)
            
            if let stage = shift.stage {
                Text(stage.name)
                    .lineLimit(1)
                
                WeaponsView(weapons: shift.weapons!)
                    .frame(height: 20)
                    .layoutPriority(1)
            }
        }
    }
}

#Preview {
    ShiftView(shift: PreviewSplatoon2Shift)
}
