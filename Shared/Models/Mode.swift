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

protocol ScheduleMode: Mode {
    var intent: INMode { get }
}

enum Splatoon2ScheduleMode: String, ScheduleMode, CaseIterable {
    case regular = "regular"
    case gachi = "gachi"
    case league = "league"
    
    init?(intent: INMode) {
        switch intent {
        case .regular, .unknown:
            self = .regular
        case .gachi:
            self = .gachi
        case .league:
            self = .league
        case .bankaraChallenge, .bankaraOpen, .x:
            return nil
        }
    }
    
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
    var intent: INMode {
        switch self {
        case .regular:
            return .regular
        case .gachi:
            return .gachi
        case .league:
            return .league
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

enum Splatoon3ScheduleMode: String, ScheduleMode, CaseIterable {
    case regular = "regular"
    case bankaraChallenge = "challenge"
    case bankaraOpen = "open"
    case x = "x"
    
    init?(intent: INMode) {
        switch intent {
        case .regular, .unknown:
            self = .regular
        case .bankaraChallenge:
            self = .bankaraChallenge
        case .bankaraOpen:
            self = .bankaraOpen
        case .x:
            self = .x
        case .gachi, .league:
            return nil
        }
    }
    
    var name: String {
        switch self {
        case .regular:
            return "regular_battle"
        case .bankaraChallenge:
            return "anarchy_battle_series"
        case .bankaraOpen:
            return "anarchy_battle_open"
        case .x:
            return "x_battle"
        }
    }
    var shortName: String {
        switch self {
        case .regular:
            return "regular"
        case .bankaraChallenge:
            return "series"
        case .bankaraOpen:
            return "open"
        case .x:
            return "x"
        }
    }
    var shorterName: String {
        switch self {
        case .regular:
            return "regular_ss"
        case .bankaraChallenge:
            return "series_ss"
        case .bankaraOpen:
            return "open_ss"
        case .x:
            return "x_ss"
        }
    }
    var accentColor: Color {
        switch self {
        case .regular:
            return Color(red: 25 / 255, green: 215 / 255, blue: 25 / 255)
        case .bankaraChallenge, .bankaraOpen:
            return Color(red: 245 / 255, green: 73 / 255, blue: 16 / 255)
        case .x:
            return Color(red: 101 / 255, green: 216 / 255, blue: 160 / 255)
        }
    }
    var intent: INMode {
        switch self {
        case .regular:
            return .regular
        case .bankaraChallenge:
            return .bankaraChallenge
        case .bankaraOpen:
            return .bankaraOpen
        case .x:
            return .x
        }
    }
}

enum Splatoon3ShiftMode: String, Mode, CaseIterable {
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
