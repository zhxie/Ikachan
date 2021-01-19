//
//  ScheduleImages.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/18.
//

import SwiftUI
import Kingfisher

struct ScheduleImages: View {
    var imageA: String
    var titleA: String
    var imageB: String
    var titleB: String
    
    var body: some View {
        HStack {
            VStack {
                KFImage(URL(string: imageA)!)
                    .placeholder {
                        Rectangle()
                            .foregroundColor(Color(UIColor.systemGroupedBackground))
                            .aspectRatio(16 / 9, contentMode: .fit)
                            .frame(height: 1080)
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(15.0)
                
                Text(titleA)
                    .font(.footnote)
                    .foregroundColor(.primary)
            }
            
            VStack {
                KFImage(URL(string: imageB)!)
                    .placeholder {
                        Rectangle()
                            .foregroundColor(Color(UIColor.systemGroupedBackground))
                            .aspectRatio(16 / 9, contentMode: .fit)
                            .frame(height: 1080)
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(15.0)
                
                Text(titleB)
                    .font(.footnote)
                    .foregroundColor(.primary)
            }
        }
    }
}

struct ScheduleImages_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleImages(imageA: "https://app.splatoon2.nintendo.net/images/stage/96fd8c0492331a30e60a217c94fd1d4c73a966cc.png", titleA: "Moray Towers", imageB: "https://app.splatoon2.nintendo.net/images/stage/96fd8c0492331a30e60a217c94fd1d4c73a966cc.png", titleB: "Moray Towers")
    }
}
