//
//  StageView.swift
//  Ikachan
//
//  Created by Sketch on 2021/11/29.
//

import SwiftUI
import Kingfisher

struct StageView: View {
    let image: String
    let title: String
    
    var body: some View {
        VStack {
            KFImage(URL(string: image)!)
                .placeholder {
                    Rectangle()
                        .foregroundColor(Color(UIColor.secondarySystemBackground))
                        .aspectRatio(16 / 9, contentMode: .fit)
                }
                .resizedToFit(16 / 9)
                .cornerRadius(15)
                .accessibilityLabel(LocalizedStringKey(title))
            
            Text(LocalizedStringKey(title))
                .font(.footnote)
                .lineLimit(1)
        }
    }
}

struct StageView_Previews: PreviewProvider {
    static var previews: some View {
        StageView(image: "http://www.apple.com", title: "")
    }
}
