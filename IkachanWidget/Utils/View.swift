//
//  View.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/2/2.
//

import SwiftUI

struct ColorBlended: ViewModifier {
    fileprivate var color: Color
  
    func body(content: Content) -> some View {
        VStack {
            ZStack {
                content
                color.blendMode(.sourceAtop)
            }
            .drawingGroup(opaque: false)
        }
    }
}

extension View {
    func blending(color: Color) -> some View {
        modifier(ColorBlended(color: color))
    }
}
