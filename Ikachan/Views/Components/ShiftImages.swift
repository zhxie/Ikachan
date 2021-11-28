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
                    }
                    .resizedToFit(16 / 9)
                    .cornerRadius(15)
                    .accessibility(label: Text(title))
                
                Text(title)
                    .font(.footnote)
                    .lineLimit(1)
            }
            
            VStack {
                Rectangle()
                    .fill(Color.clear)
                    .aspectRatio(16 / 9, contentMode: .fit)
                    .overlay(
                        VStack {
                            HStack {
                                Rectangle()
                                    .fill(Color.clear)
                                    .aspectRatio(16 / 9, contentMode: .fit)
                                    .overlay(
                                        KFImage(URL(string: subImage1)!)
                                            .placeholder {
                                                Circle()
                                                    .foregroundColor(Color(UIColor.secondarySystemBackground))
                                                    .aspectRatio(1, contentMode: .fit)
                                            }
                                            .resizedToFit(1)
                                            .accessibility(label: Text(subTitle1))
                                    )
                                Rectangle()
                                    .fill(Color.clear)
                                    .aspectRatio(16 / 9, contentMode: .fit)
                                    .overlay(
                                        KFImage(URL(string: subImage2)!)
                                            .placeholder {
                                                Circle()
                                                    .foregroundColor(Color(UIColor.secondarySystemBackground))
                                                    .aspectRatio(1, contentMode: .fit)
                                            }
                                            .resizedToFit(1)
                                            .accessibility(label: Text(subTitle2))
                                )
                            }
                            HStack {
                                Rectangle()
                                    .fill(Color.clear)
                                    .aspectRatio(16 / 9, contentMode: .fit)
                                    .overlay(
                                        KFImage(URL(string: subImage3)!)
                                            .placeholder {
                                                Circle()
                                                    .foregroundColor(Color(UIColor.secondarySystemBackground))
                                                    .aspectRatio(1, contentMode: .fit)
                                            }
                                            .resizedToFit(1)
                                            .accessibility(label: Text(subTitle3))
                                )
                                Rectangle()
                                    .fill(Color.clear)
                                    .aspectRatio(16 / 9, contentMode: .fit)
                                    .overlay(
                                        KFImage(URL(string: subImage4)!)
                                            .placeholder {
                                                Circle()
                                                    .foregroundColor(Color(UIColor.secondarySystemBackground))
                                                    .aspectRatio(1, contentMode: .fit)
                                            }
                                            .resizedToFit(1)
                                            .accessibility(label: Text(subTitle4))
                                )
                            }
                        }
                    )

                Text("weapons")
                    .font(.footnote)
                    .lineLimit(1)
                    .foregroundColor(.clear)
                    .accessibility(hidden: true)
            }
        }
    }
}

struct ShiftImages_Previews: PreviewProvider {
    static var previews: some View {
        ShiftImages(image: "http://www.apple.com", title: "spawning_grounds", subImage1: "http://www.apple.com", subTitle1: "random", subImage2: "http://www.apple.com", subTitle2: "random", subImage3: "http://www.apple.com", subTitle3: "random", subImage4: "http://www.apple.com", subTitle4: "random")
    }
}
