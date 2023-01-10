//
//  Game.swift
//  Ikachan
//
//  Created by Sketch on 2022/9/17.
//

import Foundation

enum Game: Int, CaseIterable, Codable {
    case splatoon2 = 2
    case splatoon3 = 3
    
    init(intent: INGame) {
        switch intent {
        case .splatoon2:
            self = .splatoon2
        case .splatoon3, .unknown:
            self = .splatoon3
        }
    }
    
    var name: String {
        switch self {
        case .splatoon2:
            return "splatoon2"
        case .splatoon3:
            return "splatoon3"
        }
    }
    var modes: [Mode] {
        switch self {
        case .splatoon2:
            return Splatoon2ScheduleMode.allCases
        case .splatoon3:
            return Splatoon3ScheduleMode.allCases
        }
    }
    var rules: [Rule] {
        switch self {
        case .splatoon2:
            return Splatoon2ScheduleRule.allCases.filter { rule in
                rule != .unknown
            }
        case .splatoon3:
            return Splatoon3ScheduleRule.allCases.filter { rule in
                rule != .unknown
            }
        }
    }
    var intent: INGame {
        switch self {
        case .splatoon2:
            return .splatoon2
        case .splatoon3:
            return .splatoon3
        }
    }
    var image: String {
        switch self {
        case .splatoon2:
            return "2.circle"
        case .splatoon3:
            return "3.circle"
        }
    }
}
