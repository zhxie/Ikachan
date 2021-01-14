//
//  XCardView.swift
//  Ikas
//
//  Created by Sketch on 2021/1/14.
//

import SwiftUI
import Kingfisher

struct XCardView: View {
    @State private var totalHeight = CGFloat(100)
    
    var image: String
    var subimages: [String]
    var headline: String
    var title: String
    
    var body: some View {
        VStack(spacing: 0) {
            KFImage(URL(string: image)!)
                .placeholder {
                    LoadingView()
                        .frame(width: 1920, height: 1080, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                .resizable()
                .aspectRatio(contentMode: .fit)

            HStack {
                VStack(alignment: .leading) {
                    Text(headline)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(title)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                }
                
                Spacer()
            }
            .padding([.top, .horizontal])
            
            VStack {
                GeometryReader { g in
                    HStack() {
                        HStack {
                            ForEach(subimages, id: \.self) { subimage in
                                KFImage(URL(string: subimage)!)
                                    .placeholder {
                                        LoadingView()
                                            .frame(width: 256, height: 256, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    }
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                        .frame(width: g.size.width * 0.67, alignment: .leading)
                        
                        Spacer()
                    }
                    .background(GeometryReader { gp -> Color in
                        DispatchQueue.main.async {
                            self.totalHeight = gp.size.height
                        }
                        return Color.clear
                    })
                }
            }
            .frame(height: totalHeight)
            .padding([.bottom, .horizontal])
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
        XCardView(image: "https://app.splatoon2.nintendo.net/images/coop_stage/e07d73b7d9f0c64e552b34a2e6c29b8564c63388.png", subimages: ["https://app.splatoon2.nintendo.net/images/coop_stage/91b6666bcbfccc204d86f21222a8db22a27d08d0.png", "https://app.splatoon2.nintendo.net/images/coop_stage/91b6666bcbfccc204d86f21222a8db22a27d08d0.png", "https://app.splatoon2.nintendo.net/images/coop_stage/91b6666bcbfccc204d86f21222a8db22a27d08d0.png", "https://app.splatoon2.nintendo.net/images/coop_stage/91b6666bcbfccc204d86f21222a8db22a27d08d0.png"], headline: "Salmon Run", title: "Ruins of Ark Polaris")
    }
}
