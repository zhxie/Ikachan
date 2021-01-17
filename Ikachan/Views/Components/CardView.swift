//
//  CardView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/14.
//

import SwiftUI
import Kingfisher

struct CardView: View {
    var image: String
    var title: String
    
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

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(image: "https://app.splatoon2.nintendo.net/images/stage/96fd8c0492331a30e60a217c94fd1d4c73a966cc.png", title: "Moray Towers")
        }
    }
}
