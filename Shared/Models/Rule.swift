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
}

enum Splatoon2Rule: String, Rule, Codable {
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
}
