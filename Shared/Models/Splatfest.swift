//
//  Splatfest.swift
//  Ikachan
//
//  Created by Sketch on 2022/9/24.
//

import Foundation

protocol Splatfest: Codable {
    var startTime: Date { get set }
    var endTime: Date { get set }
}

struct Splatoon3Splatfest: Splatfest {
    init(startTime: Date, midtermTime: Date, endTime: Date) {
        self.startTime = startTime
        self.midtermTime = midtermTime
        self.endTime = endTime
    }
    
    var startTime: Date
    var midtermTime: Date
    var endTime: Date
}
