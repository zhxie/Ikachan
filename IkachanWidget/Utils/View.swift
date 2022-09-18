//
//  View.swift
//  IkachanWidget
//
//  Created by Sketch on 2021/2/2.
//

import SwiftUI

enum Orientation {
    case horizontal
    case vertical
}

struct ColorBlended: ViewModifier {
    fileprivate var color: Color
    fileprivate var orientation: Orientation = .vertical
  
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
    func blending(color: Color, orientation: Orientation = .vertical) -> some View {
        modifier(ColorBlended(color: color, orientation: orientation))
    }
}
