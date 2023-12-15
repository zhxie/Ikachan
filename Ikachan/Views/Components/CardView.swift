import SwiftUI

struct CardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.smooth(duration: 0.2), value: configuration.isPressed)
    }
}

struct CardView<Content: View>: View {
    var image: String
    var name: String
    var content: () -> Content
    
    init(image: String, name: String, @ViewBuilder content: @escaping () -> Content) {
        self.image = image
        self.name = name
        self.content = content
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(image)
                    .resizedToFit()
                    .frame(width: 24, height: 24)
                Text(LocalizedStringKey(name))
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(1)
            }
            content()
        }
        .padding()
        .background {
            Color(.secondarySystemBackground)
                .cornerRadius(16)
        }
    }
}

#Preview {
    CardView(image: PreviewSplatoon2Schedule.mode.image, name: PreviewSplatoon2Schedule.mode.name) {
        ScheduleView(schedule: PreviewSplatoon2Schedule)
    }
}
