//
//  XCardView.swift
//  Ikas
//
//  Created by Sketch on 2021/1/14.
//

import SwiftUI
import Kingfisher

struct XCardView: View {
    @State private var imageHeight = CGFloat(100)
    @State private var textHeight = CGFloat(100)
    @State private var subimageHeight = CGFloat(100)
    @State private var subimagesHeight = CGFloat(100)
    
    var image: String
    var icon: String
    var headline: String
    var title: String
    var subimages: [String]
    
    var body: some View {
        VStack(spacing: 0) {
            KFImage(URL(string: image)!)
                .placeholder {
                    Rectangle()
                        .foregroundColor(Color(UIColor.systemGroupedBackground))
                        .aspectRatio(16 / 9, contentMode: .fit)
                        .frame(height: imageHeight)
                }
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(GeometryReader { g -> Color in
                    DispatchQueue.main.async {
                        imageHeight = g.size.height
                    }
                    return Color.clear
                })
            
            HStack {
                VStack {
                    Image(icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: textHeight, height: textHeight)
                    
                    Spacer()
                        .frame(height: subimagesHeight)
                }
                .layoutPriority(1)
                
                VStack(spacing: 0) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(headline)
                                .font(.headline)
                                .foregroundColor(.secondary)
                            Text(title)
                                .font(.title)
                                .fontWeight(.black)
                                .foregroundColor(.primary)
                                .lineLimit(1)
                        }
                        .layoutPriority(1)
                        
                        Spacer()
                    }
                    .background(GeometryReader { g -> Color in
                        DispatchQueue.main.async {
                            textHeight = g.size.height
                        }
                        return Color.clear
                    })
                    
                    VStack {
                        GeometryReader { g in
                            HStack {
                                HStack {
                                    ForEach(subimages, id: \.self) { subimage in
                                        KFImage(URL(string: subimage)!)
                                            .placeholder {
                                                Circle()
                                                    .foregroundColor(Color(UIColor.systemGroupedBackground))
                                                    .aspectRatio(1, contentMode: .fit)
                                                    .frame(height: subimageHeight)
                                            }
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .background(GeometryReader { g -> Color in
                                                DispatchQueue.main.async {
                                                    subimageHeight = g.size.height
                                                }
                                                return Color.clear
                                            })
                                    }
                                }
                                .frame(width: g.size.width, alignment: .leading)
                                .layoutPriority(1)
                                
                                Spacer()
                            }
                            .background(GeometryReader { gp -> Color in
                                DispatchQueue.main.async {
                                    subimagesHeight = gp.size.height
                                }
                                return Color.clear
                            })
                        }
                    }
                    .frame(height: subimagesHeight)
                }
                .layoutPriority(1)
                
                Spacer()
            }
            .padding()
        }
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
        .padding([.top, .horizontal])
        .clipped()
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

struct XCardView_Previews: PreviewProvider {
    static var previews: some View {
        XCardView(image: "https://app.splatoon2.nintendo.net/images/coop_stage/50064ec6e97aac91e70df5fc2cfecf61ad8615fd.png", icon: "salmon_run", headline: "Salmon Run", title: "Ruins of Ark Polaris", subimages: ["https://app.splatoon2.nintendo.net/images/weapon/91b6666bcbfccc204d86f21222a8db22a27d08d0.png", "https://app.splatoon2.nintendo.net/images/weapon/91b6666bcbfccc204d86f21222a8db22a27d08d0.png", "https://app.splatoon2.nintendo.net/images/weapon/91b6666bcbfccc204d86f21222a8db22a27d08d0.png", "https://app.splatoon2.nintendo.net/images/weapon/91b6666bcbfccc204d86f21222a8db22a27d08d0.png"])
    }
}
