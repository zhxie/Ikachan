//
//  TrailingView.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/11/30.
//

import SwiftUI

struct TrailingView: View {
    let text: String
    var color: Color? = .secondary
    
    var body: some View {
        Text(LocalizedStringKey(text))
            .font(.caption)
            .foregroundColor(color)
            .lineLimit(1)
    }
}

struct TrailingView_Previews: PreviewProvider {
    static var previews: some View {
        TrailingView(text: "")
    }
}