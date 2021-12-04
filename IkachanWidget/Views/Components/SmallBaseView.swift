//
//  SmallBaseView.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/11/30.
//

import SwiftUI

struct SmallBaseView<C1: View, C2: View, C3: View>: View {
    let text: String
    let indicatorText: String
    let color: Color?
    @ViewBuilder let trailing: () -> C1
    @ViewBuilder let leadingLeft: () -> C2
    @ViewBuilder let leadingRight: () -> C3
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                leadingLeft()
                    .layoutPriority(1)
            
                Spacer()
            
                leadingRight()
                    .layoutPriority(2)
            }
            .layoutPriority(1)
            
            Spacer()
                .frame(height: 4)
            
            HStack {
                Text(text)
                    .font(.largeTitle)
                    .fontWeight(.light)
                    .lineLimit(1)
                    .layoutPriority(1)
                
                Spacer()
                
                Image(systemName: "circle.fill")
                    .font(.footnote)
                    .foregroundColor(color)
                    .accessibilityLabel(LocalizedStringKey(indicatorText))
            }
            .layoutPriority(1)
            
            Spacer()
            
            trailing()
        }
    }
}

