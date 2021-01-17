//
//  SCardView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/18.
//

import SwiftUI

struct SCardView: View {
    var title: String
    
    var body: some View {
        VStack {
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

struct SCardView_Previews: PreviewProvider {
    static var previews: some View {
        SCardView(title: "1/1 10:00 - 1/2 8:00")
    }
}
