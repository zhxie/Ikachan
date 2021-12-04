//
//  WeaponView.swift
//  Ikachan
//
//  Created by Sketch on 2021/11/29.
//

import SwiftUI
import Kingfisher

struct WeaponView: View {
    let image: String
    let title: String
    
    var body: some View {
        Rectangle()
            .fill(Color.clear)
            .aspectRatio(16 / 9, contentMode: .fit)
            .overlay(
                KFImage(URL(string: image)!)
                    .placeholder {
                        Circle()
                            .foregroundColor(Color(UIColor.secondarySystemBackground))
                            .aspectRatio(1, contentMode: .fit)
                    }
                    .resizedToFit(1)
                    .accessibilityLabel(LocalizedStringKey(title))
        )
    }
}

struct WeaponView_Previews: PreviewProvider {
    static var previews: some View {
        WeaponView(image: "http://www.apple.com", title: "")
    }
}
