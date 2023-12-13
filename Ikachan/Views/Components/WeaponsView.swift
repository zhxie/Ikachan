//
//  WeaponView.swift
//  Ikachan
//
//  Created by Sketch on 2021/11/29.
//

import SwiftUI
import Kingfisher

struct WeaponsView: View {
    var weapons: [Weapon]
    var backgroundColor = Color(.secondarySystemBackground)
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(weapons, id: \.name) { weapon in
                Rectangle()
                    .fill(Color.clear)
                    .aspectRatio(1, contentMode: .fit)
                    .overlay(
                        KFImage(weapon.image)
                            .placeholder {
                                Circle()
                                    .fill(Color.clear)
                                    .aspectRatio(1, contentMode: .fit)
                            }
                            .fade(duration: 0.5)
                            .resizedToFit(1)
                            .accessibilityLabel(weapon.name)
                    )
            }
        }
        .padding(8)
        .background {
            Capsule()
                .foregroundColor(backgroundColor)
        }
    }
}

#Preview {
    WeaponsView(weapons: [PreviewWeapon, PreviewWeapon, PreviewWeapon, PreviewWeapon])
}
