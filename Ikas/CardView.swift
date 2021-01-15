//
//  CardView.swift
//  Ikas
//
//  Created by Sketch on 2021/1/14.
//

import SwiftUI
import Kingfisher

struct CardView: View {
    @State private var imageHeight = CGFloat(100)
    @State private var textHeight = CGFloat(100)
    
    var image: String
    var icon: String
    var headline: String
    var title: String
    
    var body: some View {
        VStack(spacing: 0) {
            KFImage(URL(string: image)!)
                .placeholder {
                    Rectangle()
                        .foregroundColor(Color(UIColor.systemGroupedBackground))
                        .aspectRatio(16 / 9, contentMode: .fit)
                        .frame(width: imageHeight, height: imageHeight)
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
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: textHeight)
                    .layoutPriority(1)
                
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
                .background(GeometryReader { g -> Color in
                    DispatchQueue.main.async {
                        textHeight = g.size.height
                    }
                    return Color.clear
                })
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

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(image: "https://app.splatoon2.nintendo.net/images/stage/96fd8c0492331a30e60a217c94fd1d4c73a966cc.png", icon: "turf_war", headline: "Turf War", title: "Moray Towers")
        }
    }
}
