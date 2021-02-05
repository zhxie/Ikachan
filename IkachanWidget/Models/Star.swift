//
//  Star.swift
//  Ikachan
//
//  Created by Sketch on 2021/2/2.
//

import Foundation
import SwiftUI

struct Star: Hashable {
    var baseWidth: Double
    var baseHeight: Double
    var deltaWidth: Double = 0
    var deltaHeight: Double = 0
    var width: Double {
        ((baseWidth - deltaWidth).truncatingRemainder(dividingBy: 1) + 1).truncatingRemainder(dividingBy: 1)
    }
    var height: Double {
        ((baseHeight - deltaHeight).truncatingRemainder(dividingBy: 1) + 1).truncatingRemainder(dividingBy: 1)
    }
    
    var size: Double = 1
    var glow: Double = 0
}

func GenerateStars(current: Date, largeCount: Int, smallCount: Int) -> [Star] {
    var stars: [Star] = []

    // Base
    let year = Calendar.current.component(.year, from: current)
    let month = Calendar.current.component(.month, from: current)
    let day = Calendar.current.component(.day, from: current)
    srand48(year * 10000 + month * 100 + day)
    
    // Delta
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/M/d HH:mm"
    let refDate = formatter.date(from: String(format: "%d/%d/%d 18:00", year, month, day))!
    let delta = (current - refDate).truncatingRemainder(dividingBy: 43200)
    
    for _ in 0..<largeCount {
        stars.append(Star(baseWidth: drand48(), baseHeight: drand48(), deltaWidth: drand48() * delta / 43200, deltaHeight: drand48() * delta / 43200, size: 2, glow: Double(arc4random()) / Double(UINT32_MAX)))
    }
    for _ in 0..<smallCount {
        stars.append(Star(baseWidth: drand48(), baseHeight: drand48(), deltaWidth: drand48() * delta / 43200, deltaHeight: drand48() * delta / 43200, size: 1, glow: Double(arc4random()) / Double(UINT32_MAX)))
    }
    
    return stars
}
