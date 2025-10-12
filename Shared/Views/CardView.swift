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
    var accentColor: Color
    var name: String
    var content: () -> Content
    
    init(image: String, accentColor: Color, name: String, @ViewBuilder content: @escaping () -> Content) {
        self.image = image
        self.accentColor = accentColor
        self.name = name
        self.content = content
    }
    
    var body: some View {
        if #available(iOS 26.0, *) {
            GlassEffectContainer {
                VStack(spacing: 8) {
                    HStack {
                        Image(image)
                            .symbolRenderingMode(.multicolor)
                            .font(.title2)
                            .foregroundColor(accentColor)
                        Text(LocalizedStringKey(name))
                            .font(.title3)
                            .fontWeight(.bold)
                            .lineLimit(1)
                        Image(systemName: "chevron.forward")
                            .font(.subheadline)
                            .foregroundColor(Color(.secondaryLabel))
                    }
                    content()
                }
                .padding()
                .glassEffect(in: .rect(cornerRadius: 16.0))
            }
        } else {
            VStack(spacing: 8) {
                HStack {
                    Image(image)
                        .symbolRenderingMode(.multicolor)
                        .font(.title2)
                        .foregroundColor(accentColor)
                    Text(LocalizedStringKey(name))
                        .font(.title3)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Image(systemName: "chevron.forward")
                        .font(.subheadline)
                        .foregroundColor(Color(.secondaryLabel))
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
}

#Preview {
    CardView(image: PreviewSplatoon2Schedule.mode.image, accentColor: PreviewSplatoon2Schedule.mode.accentColor, name: PreviewSplatoon2Schedule.mode.name) {
        ScheduleView(schedule: PreviewSplatoon2Schedule)
    }
}
