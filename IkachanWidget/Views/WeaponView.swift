//
//  WeaponView.swift
//  IkachanWidget
//
//  Created by Sketch on 2023/12/13.
//

import SwiftUI
import Kingfisher

struct WeaponView: View {
    var weapon: Weapon
    
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .aspectRatio(1, contentMode: .fit)
            .overlay(
                KFImage(weapon.thumbnail ?? weapon.image)
                    .placeholder {
                        Rectangle()
                            .foregroundColor(Color(.secondarySystemGroupedBackground))
                            .cornerRadius(8)
                    }
                    .resizedToFill()
                    .clipped()
                    .accessibilityLabel(weapon.name)
            )
            .cornerRadius(8)
    }
}
