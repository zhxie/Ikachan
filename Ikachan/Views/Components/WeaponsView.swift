import SwiftUI
import Kingfisher

struct WeaponsView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var weapons: [Weapon]
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(weapons, id: \.name) { weapon in
                if shouldInvert(weapon: weapon) {
                    Color.clear
                        .aspectRatio(1, contentMode: .fit)
                        .overlay(
                            KFImage(weapon.image)
                                .fade(duration: 0.5)
                                .resizedToFit(1)
                                .accessibilityLabel(weapon.name)
                                .colorInvert()
                        )
                } else {
                    Color.clear
                        .aspectRatio(1, contentMode: .fit)
                        .overlay(
                            KFImage(weapon.image)
                                .fade(duration: 0.5)
                                .resizedToFit(1)
                                .accessibilityLabel(weapon.name)
                        )
                }
            }
        }
    }
    
    func shouldInvert(weapon: Weapon) -> Bool {
        colorScheme == .light && weapon.image.absoluteString.contains("a23d035e2f37c502e85b6065ba777d93f42d6ca7017ed029baac6db512e3e17f")
    }
}

#Preview {
    WeaponsView(weapons: [PreviewWeapon, PreviewWeapon, PreviewWeapon, PreviewWeapon])
}
