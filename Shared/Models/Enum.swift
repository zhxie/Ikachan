import Foundation
import SwiftUI

enum Game: String, CaseIterable, Codable {
    case splatoon2 = "splatoon_2"
    case splatoon3 = "splatoon_3"
    
    var name: String {
        switch self {
        case .splatoon2:
            return "splatoon_2"
        case .splatoon3:
            return "splatoon_3"
        }
    }
}

protocol Mode: CaseIterable, Codable {
    var name: String { get }
    var accentColor: Color { get }
    var image: String { get }
}
protocol ScheduleMode: Mode {}
protocol ShiftMode: Mode {}

enum Splatoon2ScheduleMode: String, ScheduleMode {
    case regularBattle = "regular_battle"
    case rankedBattle = "ranked_battle"
    case leagueBattle = "league_battle"

    var name: String {
        return rawValue
    }
    var accentColor: Color {
        switch self {
        case .regularBattle:
            return Color(red: 70 / 255, green: 170 / 255, blue: 85 / 255)
        case .rankedBattle:
            return Color(red: 252 / 255, green: 114 / 255, blue: 56 / 255)
        case .leagueBattle:
            return Color(red: 232 / 255, green: 61 / 255, blue: 136 / 255)
        }
    }
    var image: String {
        return rawValue + "_2"
    }
    
    var key: String {
        switch self {
        case .regularBattle:
            return "regular"
        case .rankedBattle:
            return "gachi"
        case .leagueBattle:
            return "league"
        }
    }
}
enum Splatoon2ShiftMode: String, ShiftMode {
    case salmonRun = "salmon_run"
    
    var name: String {
        return rawValue
    }
    var accentColor: Color {
        switch self {
        case .salmonRun:
            return Color(red: 252 / 255, green: 86 / 255, blue: 32 / 255)
        }
    }
    var image: String {
        return rawValue + "_2"
    }
}
enum Splatoon3ScheduleMode: String, ScheduleMode {
    case regularBattle = "regular_battle"
    case anarchyBattleSeries = "anarchy_battle_series"
    case anarchyBattleOpen = "anarchy_battle_open"
    case xBattle = "x_battle"
    case challenges = "challenges"
    case splatfestBattleOpen = "splatfest_battle_open"
    case splatfestBattlePro = "splatfest_battle_pro"
    case tricolorBattle = "tricolor_battle"

    var name: String {
        return rawValue
    }
    var accentColor: Color {
        switch self {
        case .regularBattle:
            return Color(red: 25 / 255, green: 215 / 255, blue: 25 / 255)
        case .anarchyBattleSeries, .anarchyBattleOpen:
            return Color(red: 245 / 255, green: 73 / 255, blue: 16 / 255)
        case .xBattle:
            return Color(red: 101 / 255, green: 216 / 255, blue: 160 / 255)
        case .challenges:
            return Color(red: 240 / 255, green: 45 / 255, blue: 125 / 255)
        case .splatfestBattlePro, .splatfestBattleOpen, .tricolorBattle:
            return Color(red: 165 / 255, green: 28 / 255, blue: 222 / 255)
        }
    }
    var image: String {
        switch self {
        case .regularBattle, .xBattle, .challenges:
            return rawValue + "_3"
        case .anarchyBattleSeries, .anarchyBattleOpen:
            return "anarchy_battle_3"
        case .splatfestBattleOpen, .splatfestBattlePro, .tricolorBattle:
            return "splatfest_battle_3"
        }
    }
    
    var anarchyKey: String {
        switch self {
        case .regularBattle, .xBattle, .challenges, .splatfestBattleOpen, .splatfestBattlePro, .tricolorBattle:
            // HACK: Not used.
            return ""
        case .anarchyBattleSeries:
            return "challenge"
        case .anarchyBattleOpen:
            return "open"
        }
    }
    var splatfestKey: String {
        switch self {
        case .regularBattle, .anarchyBattleSeries, .anarchyBattleOpen, .xBattle, .challenges, .tricolorBattle:
            // HACK: Not used.
            return ""
        case .splatfestBattleOpen:
            return "regular"
        case .splatfestBattlePro:
            return "challenge"
        }
    }
}
enum Splatoon3ShiftMode: String, ShiftMode {
    case salmonRun = "salmon_run"
    case bigRun = "big_run"
    case eggstraWork = "eggstra_work"
    
    var name: String {
        return rawValue
    }
    var accentColor: Color {
        switch self {
        case .salmonRun:
            return Color(red: 252 / 255, green: 86 / 255, blue: 32 / 255)
        case .bigRun:
            return Color(red: 164 / 255, green: 49 / 255, blue: 246 / 255)
        case .eggstraWork:
            return Color(red: 190 / 255, green: 136 / 255, blue: 0 / 255)
        }
    }
    var image: String {
        return rawValue + "_3"
    }
}

protocol Rule: CaseIterable, Codable {
    var name: String { get }
    var image: String { get }
}

enum Splatoon2Rule: String, Rule {
    case turfWar = "turf_war"
    case splatZones = "splat_zones"
    case towerControl = "tower_control"
    case rainmaker = "rainmaker"
    case clamBlitz = "clam_blitz"
    
    var name: String {
        return rawValue
    }
    var image: String {
        return rawValue + "_2"
    }
}
enum Splatoon3Rule: String, Rule {
    case turfWar = "turf_war"
    case splatZones = "splat_zones"
    case towerControl = "tower_control"
    case rainmaker = "rainmaker"
    case clamBlitz = "clam_blitz"
    case tricolorTurfWar = "tricolor_turf_war"

    var name: String {
        return rawValue
    }
    var image: String {
        return rawValue + "_3"
    }
    
    var key: String {
        switch self {
        case .turfWar:
            return "turf_war"
        case .splatZones:
            return "area"
        case .towerControl:
            return "loft"
        case .rainmaker:
            return "goal"
        case .clamBlitz:
            return "clam"
        case .tricolorTurfWar:
            // HACK: Not used.
            return ""
        }
    }
}
