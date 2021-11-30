//
//  LeadingRightView.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/11/30.
//

import SwiftUI

struct LeadingRightView: View {
    let text: String
    let color: Color?
    
    var body: some View {
        Text(LocalizedStringKey(text))
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
