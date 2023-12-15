import SwiftUI
import Kingfisher

struct WeaponsView: View {
    var weapons: [Weapon]
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(weapons, id: \.name) { weapon in
                Rectangle()
                    .foregroundColor(.clear)
                    .aspectRatio(1, contentMode: .fit)
                    .overlay(
                        KFImage(weapon.thumbnail ?? weapon.image)
                            .placeholder {
                                Rectangle()
                                    .cornerRadius(8)
                            }
                            .resizedToFill()
                            .clipped()
                            .accessibilityLabel(weapon.name)
                    )
                    .cornerRadius(8)
            }
        }
    }
}
