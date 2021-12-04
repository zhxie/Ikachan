//
//  IconView.swift
//  Ikachan
//
//  Created by Sketch on 2021/11/30.
//

import SwiftUI

struct IconView: View {
    let name: String
    let iconName: String?
    let text: String
    
    var body: some View {
        HStack {
            Image(name)
                .resizedToFit()
                .frame(width: 60)
                .cornerRadius(13.2)
                .overlay(
                    RoundedRectangle(cornerRadius: 13.2)
                        .stroke(Color(UIColor.secondarySystemBackground), lineWidth: 2)
                )
                .accessibilityLabel(name)
            Button(LocalizedStringKey(text)) {
                UIApplication.shared.setAlternateIconName(iconName)
            }
        }
    }
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView(name: "", iconName: nil, text: "")
    }
}
