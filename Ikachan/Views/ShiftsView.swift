import SwiftUI

struct ShiftsView: View {
    @Environment(\.dismiss) private var dismiss
    
    var mode: any ShiftMode
    var shifts: [Shift]
    
    var body: some View {
        List {
            ForEach(shifts, id: \.startTime) { shift in
                ShiftView(shift: shift, shrinkToFit: true)
            }
        }
        .navigationTitle(LocalizedStringKey(mode.name))
        .toolbar {
            ToolbarItem {
                Button {
                    dismiss()
                } label: {
                    if #available(iOS 26.0, *) {
                        Image(systemName: "xmark")
                    } else {
                        Text(LocalizedStringKey("close"))
                    }
                }
            }
        }
    }
}

#Preview {
    ShiftsView(mode: Splatoon2ShiftMode.salmonRun, shifts: [PreviewSplatoon2Shift, PreviewSplatoon3Shift])
}
