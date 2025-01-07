import SwiftUI

struct Separator: View {
    var body: some View {
        HStack {
            Rectangle()
                .fill(.secondary.opacity(0.5))
                .frame(height: 1)
                .ignoresSafeArea()
            
            Text(LocalizedStringKey("next"))
                .font(.footnote)
                .foregroundColor(.secondary.opacity(0.5))
            
            Rectangle()
                .fill(.secondary.opacity(0.5))
                .frame(height: 1)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    Separator()
}
