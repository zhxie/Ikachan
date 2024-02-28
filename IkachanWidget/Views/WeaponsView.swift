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
                            KFImage(weapon.thumbnail ?? weapon.image)
                                .resizedToFill()
                                .clipped()
                                .accessibilityLabel(weapon.name)
                                .colorInvert()
                        )
                        .cornerRadius(8)
                } else {
                    Color.clear
                        .aspectRatio(1, contentMode: .fit)
                        .overlay(
                            KFImage(weapon.thumbnail ?? weapon.image)
                                .resizedToFill()
                                .clipped()
                                .accessibilityLabel(weapon.name)
                        )
                        .cornerRadius(8)
                }
            }
        }
    }
    
    func shouldInvert(weapon: Weapon) -> Bool {
        colorScheme == .light && weapon.image.absoluteString.contains("a23d035e2f37c502e85b6065ba777d93f42d6ca7017ed029baac6db512e3e17f")
    }
}
