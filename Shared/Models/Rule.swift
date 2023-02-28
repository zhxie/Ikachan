//
//  Rule.swift
//  Ikachan
//
//  Created by Skecth on 2022/9/14.
//

import SwiftUI

protocol Rule: Codable {
    var name: String { get }
    var shortName: String { get }
    var shorterName: String { get }
    var image: String { get }
}

protocol ShiftRule: Rule {
    var accentColor: Color { get }
}

enum Splatoon2ScheduleRule: String, Rule, CaseIterable {
    case turfWar = "turf_war"
    case splatZones = "splat_zones"
    case towerControl = "tower_control"
    case rainmaker = "rainmaker"
    case clamBlitz = "clam_blitz"
    case unknown = "unknown"
    
    var name: String {
        return rawValue
    }
    var shortName: String {
        switch self {
        case .turfWar:
            return "turf"
        case .splatZones:
            return "zones"
        case .towerControl:
            return "tower"
        case .rainmaker:
            return "rainmaker_s"
        case .clamBlitz:
            return "clam"
        case .unknown:
            return Unknown.name
        }
    }
    var shorterName: String {
        switch self {
        case .turfWar:
            return "turf_ss"
        case .splatZones:
            return "zones_ss"
        case .towerControl:
            return "tower_ss"
        case .rainmaker:
            return "rainmaker_ss"
        case .clamBlitz:
            return "clam_ss"
        case .unknown:
            return Unknown.name
        }
    }
    var image: String {
        switch self {
        case .turfWar, .splatZones, .towerControl, .rainmaker, .clamBlitz:
            return rawValue + "_2"
        case .unknown:
            return Unknown.assetImage2
        }
    }
}

enum Splatoon2ShiftRule: String, ShiftRule, CaseIterable {
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
    var image: String {
        return rawValue + "_2"
    }
    var accentColor: Color {
        return Color(red: 252 / 255, green: 86 / 255, blue: 32 / 255)
    }
}

enum Splatoon3ScheduleRule: String, Rule, CaseIterable {
    case turfWar = "turf_war"
    case splatZones = "area"
    case towerControl = "loft"
    case rainmaker = "goal"
    case clamBlitz = "clam"
    case unknown = "unknown"

    var name: String {
        switch self {
        case .turfWar:
            return "turf_war"
        case .splatZones:
            return "splat_zones"
        case .towerControl:
            return "tower_control"
        case .rainmaker:
            return "rainmaker"
        case .clamBlitz:
            return "clam_blitz"
        case .unknown:
            return Unknown.name
        }
    }
    var shortName: String {
        switch self {
        case .turfWar:
            return "turf"
        case .splatZones:
            return "zones"
        case .towerControl:
            return "tower"
        case .rainmaker:
            return "rainmaker_s"
        case .clamBlitz:
            return "clam"
        case .unknown:
            return Unknown.name
        }
    }
    var shorterName: String {
        switch self {
        case .turfWar:
            return "turf_ss"
        case .splatZones:
            return "zones_ss"
        case .towerControl:
            return "tower_ss"
        case .rainmaker:
            return "rainmaker_ss"
        case .clamBlitz:
            return "clam_ss"
        case .unknown:
            return Unknown.name
        }
    }
    var image: String {
        switch self {
        case .turfWar, .splatZones, .towerControl, .rainmaker, .clamBlitz:
            // TODO: Splatoon 3 SVG rule icons render incorrectly.
            return name + "_2"
        case .unknown:
            return Unknown.assetImage3
        }
    }
}

enum Splatoon3ShiftRule: String, ShiftRule, CaseIterable {
    case regularJob = "regular_job"
    case bigRun = "big_run"

    var name: String {
        return rawValue
    }
    var shortName: String {
        switch self {
        case .regularJob:
            return "regular_j"
        case .bigRun:
            return "big_run"
        }
    }
    var shorterName: String {
        switch self {
        case .regularJob:
            return "regular_j"
        case .bigRun:
            return "big_run"
        }
    }
    var image: String {
        switch self {
        case .regularJob:
            return "salmon_run_2"
        case .bigRun:
            return rawValue + "_3"
        }
    }
    var accentColor: Color {
        switch self {
        case .regularJob:
            return Color(red: 252 / 255, green: 86 / 255, blue: 32 / 255)
        case .bigRun:
            return Color(red: 164 / 255, green: 49 / 255, blue: 246 / 255)
        }
    }
}
