//
//  Impact.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/20.
//

import Foundation
import SwiftUI

func Impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
    let impact = UIImpactFeedbackGenerator(style: style)
    impact.impactOccurred()
}
