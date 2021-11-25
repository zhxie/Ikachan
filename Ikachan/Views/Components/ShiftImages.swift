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
                    .resizable()
                    .accessibility(label: Text(title))
                    .aspectRatio(16 / 9, contentMode: .fit)
                    .cornerRadius(15.0)
                
                Text(title)
                    .font(.footnote)
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
                                                    .aspectRatio(1.0, contentMode: .fit)
                                            }
                                            .resizable()
                                            .accessibility(label: Text(subTitle1))
                                            .aspectRatio(1.0, contentMode: .fit)
                                    )
                                Rectangle()
                                    .fill(Color.clear)
                                    .aspectRatio(16 / 9, contentMode: .fit)
                                    .overlay(
                                        KFImage(URL(string: subImage2)!)
                                            .placeholder {
                                                Circle()
                                                    .foregroundColor(Color(UIColor.secondarySystemBackground))
                                                    .aspectRatio(1.0, contentMode: .fit)
                                            }
                                            .resizable()
                                            .accessibility(label: Text(subTitle2))
                                            .aspectRatio(1.0, contentMode: .fit)
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
                                                    .aspectRatio(1.0, contentMode: .fit)
                                            }
                                            .resizable()
                                            .accessibility(label: Text(subTitle3))
                                            .aspectRatio(1.0, contentMode: .fit)
                                )
                                Rectangle()
                                    .fill(Color.clear)
                                    .aspectRatio(16 / 9, contentMode: .fit)
                                    .overlay(
                                        KFImage(URL(string: subImage4)!)
                                            .placeholder {
                                                Circle()
                                                    .foregroundColor(Color(UIColor.secondarySystemBackground))
                                                    .aspectRatio(1.0, contentMode: .fit)
                                            }
                                            .resizable()
                                            .accessibility(label: Text(subTitle4))
                                            .aspectRatio(1.0, contentMode: .fit)
                                )
                            }
                        }
                    )

                Text("weapons")
                    .font(.footnote)
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
