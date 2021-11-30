//
//  LeadingLeftView.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/11/30.
//

import SwiftUI

struct LeadingLeftView: View {
    let text: Text
    
    init(text: String) {
        self.text = Text(text)
    }
    
    init(text: LocalizedStringKey) {
        self.text = Text(text)
    }
    
    var body: some View {
        text
            .font(.caption2)
            .foregroundColor(.secondary)
            .lineLimit(1)
    }
}

struct LeadingLeftView_Previews: PreviewProvider {
    static var previews: some View {
        LeadingLeftView(text: "")
    }
}
