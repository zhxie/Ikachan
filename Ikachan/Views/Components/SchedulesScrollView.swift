//
//  SchedulesScrollView.swift
//  Ikachan
//
//  Created by Sketch on 2021/11/29.
//

import SwiftUI

struct SchedulesScrollView<Datum, Content: View>: View {
    var data: [Datum]
    let title: String
    @ViewBuilder let content: (Datum) -> Content
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<data.count, id: \.self) { i in
                    VStack {
                        Divider()
                            .frame(height: 1)
                        
                        content(data[i])
                        
                        Spacer()
                            .frame(height: 15)
                    }
                    .transition(.opacity)
                    .animation(.default)
                }
            }
            .padding([.horizontal, .bottom])
        }
        .navigationTitle(LocalizedStringKey(title))
    }
}
