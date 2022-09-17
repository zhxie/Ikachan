//
//  WeaponView.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/11/30.
//

import SwiftUI
import Kingfisher

struct WeaponView: View {
    let weapon: Weapon
    
    var body: some View {
        Rectangle()
            .fill(Color.clear)
            .aspectRatio(1, contentMode: .fit)
            .overlay(
                KFImage(URL(string: weapon.imageUrl)!)
                    .placeholder {
                        Circle()
                            .foregroundColor(Color(UIColor.secondarySystemBackground))
                    }
                    .resizedToFill()
                    .clipped()
                    .accessibilityLabel(LocalizedStringKey(weapon.name))
            )
            .cornerRadius(7.5)
    }
}

struct WeaponView_Previews: PreviewProvider {
    static var previews: some View {
        WeaponView(weapon: Splatoon2Weapon.random)
    }
}
