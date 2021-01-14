//
//  XCardView.swift
//  Ikas
//
//  Created by Sketch on 2021/1/14.
//

import SwiftUI

struct XCardView: View {
    @State private var totalHeight = CGFloat(100)
    
    var image: String
    var subimages: [String]
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
                
                Spacer()
            }
            .padding([.top, .horizontal])
            
            VStack {
                GeometryReader { g in
                    HStack() {
                        HStack {
                            ForEach(subimages, id: \.self) { subimage in
                                Image(subimage)
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
        XCardView(image: "ruins_of_ark_polaris", subimages: ["splattershot_jr", "splattershot_jr", "splattershot_jr", "splattershot_jr"], headline: "Salmon Run", title: "Ruins of Ark Polaris")
    }
}
