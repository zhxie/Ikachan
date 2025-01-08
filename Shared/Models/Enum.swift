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
    var shortName: String { get }
    var accentColor: Color { get }
    var image: String { get }
}
protocol ScheduleMode: Mode {}
protocol ShiftMode: Mode {}

enum Splatoon2ScheduleMode: String, ScheduleMode {
    case regularBattle = "regular_battle"
    case rankedBattle = "ranked_battle"
    case leagueBattle = "league_battle"
    
    init(from mode: INSplatoon2ScheduleMode) {
        switch mode {
        case .unknown, .regularBattle:
            self = .regularBattle
        case .rankedBattle:
            self = .rankedBattle
        case .leagueBattle:
            self = .leagueBattle
        }
    }

    var name: String {
        return rawValue
    }
    var shortName: String {
        return name
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
        switch self {
        case .regularBattle:
            return "turfwar.2"
        case .rankedBattle:
            return "battle.ranked"
        case .leagueBattle:
            return "battle.league"
        }
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
    var shortName: String {
        return name
    }
    var accentColor: Color {
        switch self {
        case .salmonRun:
            return Color(red: 252 / 255, green: 86 / 255, blue: 32 / 255)
        }
    }
    var image: String {
        switch self {
        case .salmonRun:
            return "salmonrun.2"
        }
    }
}
enum Splatoon3ScheduleMode: String, ScheduleMode {
    case splatfestBattleOpen = "splatfest_battle_open"
    case splatfestBattlePro = "splatfest_battle_pro"
    case tricolorBattle = "tricolor_battle"
    case regularBattle = "regular_battle"
    case anarchyBattleSeries = "anarchy_battle_series"
    case anarchyBattleOpen = "anarchy_battle_open"
    case xBattle = "x_battle"
    case challenges = "challenges"
    
    init(from mode: INSplatoon3ScheduleMode) {
        switch mode {
        case .unknown, .regularBattle:
            self = .regularBattle
        case .anarchyBattleSeries:
            self = .anarchyBattleSeries
        case .anarchyBattleOpen:
            self = .anarchyBattleOpen
        case .xBattle:
            self = .xBattle
        case .challenges:
            self = .challenges
        case .splatfestBattleOpen:
            self = .splatfestBattleOpen
        case .splatfestBattlePro:
            self = .splatfestBattlePro
        case .tricolorBattle:
            self = .tricolorBattle
        }
    }

    var name: String {
        return rawValue
    }
    var shortName: String {
        switch self {
        case .regularBattle, .xBattle, .challenges, .tricolorBattle:
            return name
        case .anarchyBattleSeries:
            return "anarchy_series"
        case .anarchyBattleOpen:
            return "anarchy_open"
        case .splatfestBattleOpen:
            return "splatfest_open"
        case .splatfestBattlePro:
            return "splatfest_pro"
        }
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
        case .splatfestBattleOpen, .splatfestBattlePro, .tricolorBattle:
            return Color(red: 165 / 255, green: 28 / 255, blue: 222 / 255)
        }
    }
    var image: String {
        switch self {
        case .regularBattle:
            return "turfwar.3"
        case .anarchyBattleSeries:
            return "battle.ranked"
        case .anarchyBattleOpen:
            return "battle.anarchy.open"
        case .xBattle:
            return "battle.x"
        case .challenges:
            return "battle.challenges"
        case .splatfestBattleOpen, .splatfestBattlePro, .tricolorBattle:
            return "battle.splatfest"
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
    
    init(from mode: INSplatoon3ShiftMode) {
        switch mode {
        case .unknown, .salmonRunAndBigRun:
            self = .salmonRun
        case .eggstraWork:
            self = .eggstraWork
        }
    }
    
    var name: String {
        return rawValue
    }
    var shortName: String {
        return name
    }
    var accentColor: Color {
        switch self {
        case .salmonRun:
            return Color(red: 255 / 255, green: 80 / 255, blue: 51 / 255)
        case .bigRun:
            return Color(red: 179 / 255, green: 34 / 255, blue: 255 / 255)
        case .eggstraWork:
            return Color(red: 253 / 255, green: 212 / 255, blue: 0 / 255)
        }
    }
    var image: String {
        switch self {
        case .salmonRun:
            return "salmonrun.3"
        case .bigRun:
            return "salmonrun.bigrun"
        case .eggstraWork:
            return "salmonrun.eggstrawork"
        }
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
        switch self {
        case .turfWar:
            return "turfwar.2"
        case .splatZones:
            return "splatzones"
        case .towerControl:
            return "towercontrol"
        case .rainmaker:
            return "rainmaker"
        case .clamBlitz:
            return "clamblitz"
        }
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
        switch self {
        case .turfWar:
            return "turfwar.3"
        case .splatZones:
            return "splatzones"
        case .towerControl:
            return "towercontrol"
        case .rainmaker:
            return "rainmaker"
        case .clamBlitz:
            return "clamblitz"
        case .tricolorTurfWar:
            return "turfwar.tricolor"
        }
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
