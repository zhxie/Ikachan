//
//  LeadingRightView.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/11/30.
//

import SwiftUI

struct LeadingRightView: View {
    let text: Text
    let color: Color?
    
    init(text: String, color: Color?) {
        self.text = Text(text)
        self.color = color
    }
    
    init(text: LocalizedStringKey, color: Color?) {
        self.text = Text(text)
        self.color = color
    }
    
    var body: some View {
        text
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(color)
            .lineLimit(1)
    }
}

struct LeadingRightView_Previews: PreviewProvider {
    static var previews: some View {
        LeadingRightView(text: "", color: nil)
    }
}
