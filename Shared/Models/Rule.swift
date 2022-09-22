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
            return Unknown.assetImage
        }
    }
}

enum Splatoon3Rule: String, Rule, CaseIterable {
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
            return Unknown.assetImage
        }
    }
}
