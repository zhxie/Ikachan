//
//  TopLeadingView.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/11/30.
//

import SwiftUI

struct TopLeadingView: View {
    let text: Text
    let color: Color?
    
    init(text: String, color: Color? = .secondary) {
        self.text = Text(text)
        self.color = color
    }
    
    init(text: LocalizedStringKey, color: Color? = .secondary) {
        self.text = Text(text)
        self.color = color
    }
    
    var body: some View {
        text
            .font(.caption2)
            .foregroundColor(color)
            .lineLimit(1)
    }
}

struct TopLeadingView_Previews: PreviewProvider {
    static var previews: some View {
        TopLeadingView(text: "")
    }
}
