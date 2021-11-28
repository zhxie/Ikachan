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
    var titleA: LocalizedStringKey
    var imageB: String
    var titleB: LocalizedStringKey
    
    var body: some View {
        HStack {
            VStack {
                KFImage(URL(string: imageA)!)
                    .placeholder {
                        Rectangle()
                            .foregroundColor(Color(UIColor.secondarySystemBackground))
                            .aspectRatio(16 / 9, contentMode: .fit)
                    }
                    .resizedToFit(16 / 9)
                    .cornerRadius(15)
                    .accessibility(label: Text(titleA))
                
                Text(titleA)
                    .font(.footnote)
                    .lineLimit(1)
            }
            
            VStack {
                KFImage(URL(string: imageB)!)
                    .placeholder {
                        Rectangle()
                            .foregroundColor(Color(UIColor.secondarySystemBackground))
                            .aspectRatio(16 / 9, contentMode: .fit)
                    }
                    .resizedToFit(16 / 9)
                    .cornerRadius(15)
                    .accessibility(label: Text(titleB))
                
                Text(titleB)
                    .font(.footnote)
                    .lineLimit(1)
            }
        }
    }
}

struct ScheduleImages_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleImages(imageA: "http://www.apple.com", titleA: "the_reef", imageB: "http://www.apple.com", titleB: "mussel_forge_fitness")
    }
}
