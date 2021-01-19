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
    var subImage2: String
    var subImage3: String
    var subImage4: String
    
    var body: some View {
        HStack {
            VStack {
                KFImage(URL(string: image)!)
                    .placeholder {
                        Rectangle()
                            .foregroundColor(Color(UIColor.systemGroupedBackground))
                            .aspectRatio(16 / 9, contentMode: .fit)
                            .frame(height: 1080)
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(15.0)
                
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
                                            .foregroundColor(Color(UIColor.systemGroupedBackground))
                                            .aspectRatio(1.0, contentMode: .fit)
                                            .frame(height: 1080)
                                    }
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            )
                        Rectangle()
                            .fill(Color(UIColor.systemBackground))
                            .aspectRatio(16 / 9, contentMode: .fit)
                            .overlay(
                                KFImage(URL(string: subImage2)!)
                                    .placeholder {
                                        Circle()
                                            .foregroundColor(Color(UIColor.systemGroupedBackground))
                                            .aspectRatio(1.0, contentMode: .fit)
                                            .frame(height: 1080)
                                    }
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
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
                                            .foregroundColor(Color(UIColor.systemGroupedBackground))
                                            .aspectRatio(1.0, contentMode: .fit)
                                            .frame(height: 1080)
                                    }
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            )
                        Rectangle()
                            .fill(Color(UIColor.systemBackground))
                            .aspectRatio(16 / 9, contentMode: .fit)
                            .overlay(
                                KFImage(URL(string: subImage4)!)
                                    .placeholder {
                                        Circle()
                                            .foregroundColor(Color(UIColor.systemGroupedBackground))
                                            .aspectRatio(1.0, contentMode: .fit)
                                            .frame(height: 1080)
                                    }
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
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
        ShiftImages(image: "https://app.splatoon2.nintendo.net/images/coop_stage/50064ec6e97aac91e70df5fc2cfecf61ad8615fd.png", title: "Ruins of Ark Polaris", subImage1: "https://app.splatoon2.nintendo.net/images/weapon/91b6666bcbfccc204d86f21222a8db22a27d08d0.png", subImage2: "https://app.splatoon2.nintendo.net/images/weapon/91b6666bcbfccc204d86f21222a8db22a27d08d0.png", subImage3: "https://app.splatoon2.nintendo.net/images/weapon/91b6666bcbfccc204d86f21222a8db22a27d08d0.png", subImage4: "https://app.splatoon2.nintendo.net/images/weapon/91b6666bcbfccc204d86f21222a8db22a27d08d0.png")
    }
}
