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
                            .frame(height: 1080)
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(15.0)
                    .accessibility(label: Text(titleA))
                
                Text(titleA)
                    .font(.footnote)
                    .foregroundColor(.primary)
                    .lineLimit(1)
            }
            
            VStack {
                KFImage(URL(string: imageB)!)
                    .placeholder {
                        Rectangle()
                            .foregroundColor(Color(UIColor.secondarySystemBackground))
                            .aspectRatio(16 / 9, contentMode: .fit)
                            .frame(height: 1080)
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(15.0)
                    .accessibility(label: Text(titleB))
                
                Text(titleB)
                    .font(.footnote)
                    .foregroundColor(.primary)
                    .lineLimit(1)
            }
        }
    }
}

struct ScheduleImages_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleImages(imageA: "", titleA: "the_reef", imageB: "", titleB: "mussel_forge_fitness")
    }
}
