//
//  StageView.swift
//  IkachanWidgetExtension
//
//  Created by Sketch on 2021/11/30.
//

import SwiftUI
import Kingfisher

struct StageView: View {
    let image: String
    let accessibility: LocalizedStringKey
    
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
                    .accessibility(label: Text(accessibility))
            )
            .cornerRadius(7.5)
    }
}

struct StageView_Previews: PreviewProvider {
    static var previews: some View {
        StageView(image: "http://www.apple.com", accessibility: "")
    }
}
