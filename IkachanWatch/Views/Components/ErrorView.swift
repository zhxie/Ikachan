import SwiftUI

struct ErrorView: View {
    var error: APIError
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: "xmark.circle")
                .font(.largeTitle)
                .foregroundColor(.secondary)
            Text(LocalizedStringKey(error.name))
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    ErrorView(error: .NoError)
}
