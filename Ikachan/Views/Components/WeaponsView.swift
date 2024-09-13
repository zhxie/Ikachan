import SwiftUI
import Kingfisher

enum WeaponsViewStyle {
    case App
    case Widget
}

struct WeaponView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var weapon: Weapon
    var style: WeaponsViewStyle = .App
    
    var body: some View {
        if colorScheme == .light && weapon.image.absoluteString.contains("a23d035e2f37c502e85b6065ba777d93f42d6ca7017ed029baac6db512e3e17f") {
            switch style {
            case .App:
                KFImage(weapon.image)
                    .fade(duration: 0.5)
                    .resizedToFit(1)
                    .accessibilityLabel(weapon.name)
                    .colorInvert()
            case .Widget:
                KFImage(weapon.thumbnail ?? weapon.image)
                    .resizedToFill()
                    .clipped()
                    .accessibilityLabel(weapon.name)
                    .colorInvert()
            }
        } else {
            switch style {
            case .App:
                KFImage(weapon.image)
                    .fade(duration: 0.5)
                    .resizedToFit(1)
                    .accessibilityLabel(weapon.name)
            case .Widget:
                KFImage(weapon.thumbnail ?? weapon.image)
                    .resizedToFill()
                    .clipped()
                    .accessibilityLabel(weapon.name)
            }
        }
    }
}

struct WeaponsView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var weapons: [Weapon]
    var style: WeaponsViewStyle = .App
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(weapons, id: \.name) { weapon in
                Color.clear
                    .aspectRatio(1, contentMode: .fit)
                    .overlay(
                        WeaponView(weapon: weapon, style: style)
                    )
                    .cornerRadius(style == .Widget ? 8 : 0)
            }
        }
    }
}

#Preview {
    WeaponsView(weapons: [PreviewWeapon, PreviewWeapon, PreviewWeapon, PreviewWeapon])
}
