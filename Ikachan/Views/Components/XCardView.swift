//
//  XCardView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/14.
//

import SwiftUI
import Kingfisher

struct XCardView: View {
    var image: String
    var title: LocalizedStringKey
    var subimages: [String]
    
    var body: some View {
        VStack(spacing: 0) {
            KFImage(URL(string: image)!)
                .placeholder {
                    Rectangle()
                        .foregroundColor(Color(UIColor.systemGroupedBackground))
                        .aspectRatio(16 / 9, contentMode: .fit)
                        .frame(height: 1080)
                }
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            VStack(spacing: 5) {
                HStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(title)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .lineLimit(1)
                        }
                        .layoutPriority(1)
                        
                        Spacer()
                    }
                    .layoutPriority(1)
                    
                    Spacer()
                }
                
                HStack {
                    HStack {
                        ForEach(subimages, id: \.self) { subimage in
                            KFImage(URL(string: subimage)!)
                                .placeholder {
                                    Circle()
                                        .foregroundColor(Color(UIColor.systemGroupedBackground))
                                        .aspectRatio(1, contentMode: .fit)
                                        .frame(height: 1080)
                                }
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 56)
                        }
                    }
                    .layoutPriority(1)
                    
                    Spacer()
                }
            }
            .padding()
        }
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
        .padding(.horizontal)
        .clipped()
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.2), radius: 20, y: 20.0)
    }
}

struct XCardView_Previews: PreviewProvider {
    static var previews: some View {
        XCardView(image: "https://app.splatoon2.nintendo.net/images/coop_stage/50064ec6e97aac91e70df5fc2cfecf61ad8615fd.png", title: "Ruins of Ark Polaris", subimages: ["https://app.splatoon2.nintendo.net/images/weapon/91b6666bcbfccc204d86f21222a8db22a27d08d0.png", "https://app.splatoon2.nintendo.net/images/weapon/91b6666bcbfccc204d86f21222a8db22a27d08d0.png", "https://app.splatoon2.nintendo.net/images/weapon/91b6666bcbfccc204d86f21222a8db22a27d08d0.png", "https://app.splatoon2.nintendo.net/images/weapon/91b6666bcbfccc204d86f21222a8db22a27d08d0.png"])
    }
}
