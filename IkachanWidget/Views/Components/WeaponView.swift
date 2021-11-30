//
//  WeaponView.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/11/30.
//

import SwiftUI
import Kingfisher

struct WeaponView: View {
    let image: String
    let title: String
    
    var body: some View {
        Rectangle()
            .fill(Color.clear)
            .aspectRatio(1, contentMode: .fit)
            .overlay(
                KFImage(URL(string: image)!)
                    .placeholder {
                        Circle()
                            .foregroundColor(Color(UIColor.secondarySystemBackground))
                    }
                    .resizedToFill()
                    .clipped()
                    .accessibility(label: Text(LocalizedStringKey(title)))
            )
            .cornerRadius(7.5)
    }
}

struct WeaponView_Previews: PreviewProvider {
    static var previews: some View {
        WeaponView(image: "http://www.apple.com", title: "")
    }
}
