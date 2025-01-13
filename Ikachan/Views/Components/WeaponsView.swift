import SwiftUI
import Kingfisher

struct WeaponView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var weapon: Weapon
    
    var body: some View {
        if colorScheme == .light && weapon.image.absoluteString.contains("a23d035e2f37c502e85b6065ba777d93f42d6ca7017ed029baac6db512e3e17f") {
            KFImage(weapon.image)
                .fade(duration: 0.5)
                .resizedToFit(1)
                .colorInvert()
                .accessibilityLabel(weapon.name)
        } else {
            KFImage(weapon.image)
                .fade(duration: 0.5)
                .resizedToFit(1)
                .accessibilityLabel(weapon.name)
        }
    }
}

struct WeaponsView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var weapons: [Weapon]
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(weapons, id: \.name) { weapon in
                Color.clear
                    .aspectRatio(1, contentMode: .fit)
                    .overlay(
                        WeaponView(weapon: weapon)
                    )
            }
        }
    }
}

#Preview {
    WeaponsView(weapons: [PreviewWeapon, PreviewWeapon, PreviewWeapon, PreviewWeapon])
}
