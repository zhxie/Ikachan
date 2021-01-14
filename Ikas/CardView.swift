//
//  CardView.swift
//  Ikas
//
//  Created by Sketch on 2021/1/14.
//

import SwiftUI

struct CardView: View {
    var image: String
    var headline: String
    var title: String
    
    var body: some View {
        VStack(spacing: 0) {
            Image(image)
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
                .layoutPriority(100)
                
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
            CardView(image: "moray_towers", headline: "Rainmaker", title: "Moray Towers")
        }
    }
}
