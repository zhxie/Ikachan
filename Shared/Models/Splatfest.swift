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
    enum State: String, CaseIterable, Codable {
        case scheduled = "scheduled"
        case firstHalf = "first_half"
        case secondHalf = "second_half"
    }
    
    init(startTime: Date, midtermTime: Date, endTime: Date, state: State, stage: Splatoon3ScheduleStage) {
        self.startTime = startTime
        self.midtermTime = midtermTime
        self.endTime = endTime
        self.state = state
        self.stage = stage
    }
    
    var startTime: Date
    var midtermTime: Date
    var endTime: Date
    var state: State
    var stage: Splatoon3ScheduleStage
}
