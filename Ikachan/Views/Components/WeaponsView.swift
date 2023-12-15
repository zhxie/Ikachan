import SwiftUI
import Kingfisher

struct WeaponsView: View {
    var weapons: [Weapon]
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(weapons, id: \.name) { weapon in
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

#Preview {
    WeaponsView(weapons: [PreviewWeapon, PreviewWeapon, PreviewWeapon, PreviewWeapon])
}
