//
//  ShiftImages.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/18.
//

import SwiftUI
import Kingfisher

struct ShiftImages: View {
    var image: String
    var title: LocalizedStringKey
    var subImage1: String
    var subTitle1: LocalizedStringKey
    var subImage2: String
    var subTitle2: LocalizedStringKey
    var subImage3: String
    var subTitle3: LocalizedStringKey
    var subImage4: String
    var subTitle4: LocalizedStringKey
    
    var body: some View {
        HStack {
            VStack {
                KFImage(URL(string: image)!)
                    .placeholder {
                        Rectangle()
                            .foregroundColor(Color(UIColor.secondarySystemBackground))
                            .aspectRatio(16 / 9, contentMode: .fit)
                            .frame(height: 1080)
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(15.0)
                    .accessibility(label: Text(title))
                
                Text(title)
                    .font(.footnote)
                    .foregroundColor(.primary)
            }
            
            VStack {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(Color(UIColor.systemBackground))
                            .aspectRatio(16 / 9, contentMode: .fit)
                            .overlay(
                                KFImage(URL(string: subImage1)!)
                                    .placeholder {
                                        Circle()
                                            .foregroundColor(Color(UIColor.secondarySystemBackground))
                                            .aspectRatio(1.0, contentMode: .fit)
                                            .frame(height: 1080)
                                    }
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .accessibility(label: Text(subTitle1))
                            )
                        Rectangle()
                            .fill(Color(UIColor.systemBackground))
                            .aspectRatio(16 / 9, contentMode: .fit)
                            .overlay(
                                KFImage(URL(string: subImage2)!)
                                    .placeholder {
                                        Circle()
                                            .foregroundColor(Color(UIColor.secondarySystemBackground))
                                            .aspectRatio(1.0, contentMode: .fit)
                                            .frame(height: 1080)
                                    }
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .accessibility(label: Text(subTitle2))
                            )
                    }
                    
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(Color(UIColor.systemBackground))
                            .aspectRatio(16 / 9, contentMode: .fit)
                            .overlay(
                                KFImage(URL(string: subImage3)!)
                                    .placeholder {
                                        Circle()
                                            .foregroundColor(Color(UIColor.secondarySystemBackground))
                                            .aspectRatio(1.0, contentMode: .fit)
                                            .frame(height: 1080)
                                    }
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .accessibility(label: Text(subTitle3))
                            )
                        Rectangle()
                            .fill(Color(UIColor.systemBackground))
                            .aspectRatio(16 / 9, contentMode: .fit)
                            .overlay(
                                KFImage(URL(string: subImage4)!)
                                    .placeholder {
                                        Circle()
                                            .foregroundColor(Color(UIColor.secondarySystemBackground))
                                            .aspectRatio(1.0, contentMode: .fit)
                                            .frame(height: 1080)
                                    }
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .accessibility(label: Text(subTitle4))
                            )
                    }
                }
            
                Text("weapons")
                    .font(.footnote)
                    .foregroundColor(.clear)
            }
        }
    }
}

struct ShiftImages_Previews: PreviewProvider {
    static var previews: some View {
        ShiftImages(image: "", title: "spawning_grounds", subImage1: "", subTitle1: "random", subImage2: "", subTitle2: "random", subImage3: "", subTitle3: "random", subImage4: "", subTitle4: "random")
    }
}
