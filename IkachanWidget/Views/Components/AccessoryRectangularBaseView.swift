//
//  AccessoryRectangularBaseView.swift
//  IkachanWidget
//
//  Created by Sketch on 2022/9/18.
//

import SwiftUI

struct AccessoryRectangularBaseView: View {
    var image: String
    var title: String
    var text: String
    var text2: String
    
    var body: some View {
        if #available(iOSApplicationExtension 16.0, *) {
            HStack (alignment: .top) {
                VStack (alignment: .leading, spacing: 0) {
                    HStack (spacing: 4) {
                        // TODO: Image should be replaced to SVG text.
                        Image(image)
                            .resizedToFit()
                            .frame(width: 16, height: 16)
                        
                        Text(LocalizedStringKey(title))
                            .font(.headline)
                            .widgetAccentable()
                    }
                    
                    Text(LocalizedStringKey(text))
                    Text(LocalizedStringKey(text2))
                }
                
                Spacer()
            }
        } else {
            EmptyView()
        }
    }
}

struct AccessoryRectangularBaseView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryRectangularBaseView(image: "", title: "", text: "", text2: "")
    }
}
