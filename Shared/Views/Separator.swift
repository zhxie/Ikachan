import SwiftUI

struct Separator: View {
    var accentColor: Color
    
    var body: some View {
        HStack {
            Rectangle()
                .fill(accentColor)
                .frame(height: 1)
            
            Text(LocalizedStringKey("next"))
                .foregroundColor(accentColor)
            
            Rectangle()
                .fill(accentColor)
                .frame(height: 1)
        }
    }
}

#Preview {
    Separator(accentColor: .primary)
}
