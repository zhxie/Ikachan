//
//  SchedulesScrollView.swift
//  Ikachan
//
//  Created by Sketch on 2021/11/29.
//

import SwiftUI

struct SchedulesScrollView<Data: Hashable, Content: View>: View {
    var data: [Data]
    let title: String
    @ViewBuilder let content: (Data) -> Content
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(data, id: \.self) { datum in
                    VStack {
                        Divider()
                            .frame(height: 1)
                        
                        content(datum)
                        
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
