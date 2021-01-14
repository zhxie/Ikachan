//
//  LoadingView.swift
//  Ikas
//
//  Created by Sketch on 2021/1/14.
//

import SwiftUI

struct LoadingView: View {
    @State var isAnimating = false
    var forever: Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        Image(systemName: "arrow.2.circlepath")
            .font(.largeTitle)
            .rotationEffect(Angle(degrees: isAnimating ? 360.0 : 0.0))
            .animation(isAnimating ? forever : .default)
            .onAppear {
                isAnimating = true
            }
            .onDisappear {
                isAnimating = false
            }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
