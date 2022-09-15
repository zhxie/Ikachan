//
//  Mode.swift
//  Ikachan
//
//  Created by Sketch on 2022/9/14.
//

import SwiftUI

protocol Mode: Codable {
    var name: String { get }
    var shortName: String { get }
    var shorterName: String { get }
    var accentColor: Color { get }
}

enum Splatoon2ScheduleMode: String, Mode, CaseIterable {
    case regular = "regular"
    case gachi = "gachi"
    case league = "league"
    
    var name: String {
        switch self {
        case .regular:
            return "regular_battle"
        case .gachi:
            return "ranked_battle"
        case .league:
            return "league_battle"
        }
    }
    var shortName: String {
        switch self {
        case .regular:
            return "regular"
        case .gachi:
            return "ranked"
        case .league:
            return "league"
        }
    }
    var shorterName: String {
        switch self {
        case .regular:
            return "regular_ss"
        case .gachi:
            return "ranked_ss"
        case .league:
            return "league_ss"
        }
    }
    var accentColor: Color {
        switch self {
        case .regular:
            return Color(red: 70 / 255, green: 170 / 255, blue: 85 / 255)
        case .gachi:
            return Color(red: 252 / 255, green: 114 / 255, blue: 56 / 255)
        case .league:
            return Color(red: 232 / 255, green: 61 / 255, blue: 136 / 255)
        }
    }
}

enum Splatoon2ShiftMode: String, Mode, CaseIterable {
    case salmonRun = "salmon_run"
    
    var name: String {
        return rawValue
    }
    var shortName: String {
        return "job"
    }
    var shorterName: String {
        return "job"
    }
    var accentColor: Color {
        return Color(red: 252 / 255, green: 86 / 255, blue: 32 / 255)
    }
}
