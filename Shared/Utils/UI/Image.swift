//
//  Image.swift
//  Ikachan
//
//  Created by Sketch on 2021/11/28.
//

import SwiftUI

extension Image {
    func resizedToFit(_ aspectRatio: CGFloat? = nil) -> some View {
        return self
            .resizable()
            .aspectRatio(aspectRatio, contentMode: .fit)
    }
    
    func resizedToFill(_ aspectRatio: CGFloat? = nil) -> some View {
        return self
            .resizable()
            .aspectRatio(aspectRatio, contentMode: .fill)
    }
}
