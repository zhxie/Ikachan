//
//  StageView.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/11/30.
//

import SwiftUI
import Kingfisher

struct StageView: View {
    let image: String
    let title: String
    
    var body: some View {
        Rectangle()
            .fill(Color(UIColor.secondarySystemBackground))
            .overlay (
                KFImage(URL(string: image)!)
                    .placeholder {
                        Rectangle()
                            .foregroundColor(Color(UIColor.secondarySystemBackground))
                    }
                    .resizedToFill()
                    .clipped()
                    .accessibility(label: Text(LocalizedStringKey(title)))
            )
            .cornerRadius(7.5)
    }
}

struct StageView_Previews: PreviewProvider {
    static var previews: some View {
        StageView(image: "http://www.apple.com", title: "")
    }
}
