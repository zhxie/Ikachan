//
//  Rule.swift
//  Ikachan
//
//  Created by Skecth on 2022/9/14.
//

import Foundation

protocol Rule: Codable {
    var name: String { get }
    var shortName: String { get }
    var shorterName: String { get }
    var image: String { get }
}

enum Splatoon2Rule: String, Rule, CaseIterable {
    case turfWar = "turf_war"
    case splatZones = "splat_zones"
    case towerControl = "tower_control"
    case rainmaker = "rainmaker"
    case clamBlitz = "clam_blitz"
    
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
        }
    }
    var image: String {
        return rawValue + "_2"
    }
}

enum Splatoon3Rule: String, Rule, CaseIterable {
    case turfWar = "turf_war"
    case splatZones = "area"
    case towerControl = "loft"
    case rainmaker = "goal"
    case clamBlitz = "clam"

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
        }
    }
    var image: String {
        return name + "_3"
    }
}
