//
//  Schedule.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/15.
//

import Foundation
import SwiftUI

struct Schedule: Hashable, Codable {
    var startTime: Date
    var endTime: Date
    
    var gameMode: GameMode
    enum GameMode: String, CaseIterable, Codable {
        case regular = "regular"
        case gachi = "gachi"
        case league = "league"
        
        var description: LocalizedStringKey {
            switch self {
            case .regular:
                return "regular"
            case .gachi:
                return "ranked"
            case .league:
                return "league"
            }
        }
        
        var longDescription: LocalizedStringKey {
            switch self {
            case .regular:
                return "regular_battle"
            case .gachi:
                return "ranked_battle"
            case .league:
                return "league_battle"
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
        
        var url: String {
            return IkachanScheme + "://" + rawValue
        }
    }
    
    var rule: Rule
    enum Rule: String, CaseIterable, Codable {
        case turfWar = "turf_war"
        case splatZones = "splat_zones"
        case towerControl = "tower_control"
        case rainmaker = "rainmaker"
        case clamBlitz = "clam_blitz"
        
        var description: LocalizedStringKey {
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
        
        var shortDescription: LocalizedStringKey {
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
        
        var shorterDescription: LocalizedStringKey {
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

    var stageA: Stage
    var stageB: Stage
    struct Stage: Hashable, Codable, Identifiable {
        var id: StageId
        var image: String
        
        var description: LocalizedStringKey {
            switch self.id {
            case .theReef:
                return "the_reef"
            case .musselforgeFitness:
                return "mussel_forge_fitness"
            case .starfishMainstage:
                return "starfish_mainstage"
            case .sturgeonShipyard:
                return "sturgeon_shipyard"
            case .inkblotArtAcademy:
                return "inkblot_art_academy"
            case .humpbackPumpTrack:
                return "humpback_pump_track"
            case .mantaMaria:
                return "manta_maria"
            case .portMackerel:
                return "port_mackerel"
            case .morayTowers:
                return "moray_towers"
            case .snapperCanal:
                return "snapper_canal"
            case .kelpDome:
                return "kelp_dome"
            case .blackbellySkatepark:
                return "blackbelly_skatepark"
            case .shellendorfInstitute:
                return "sehllendorf_institute"
            case .makoMart:
                return "mako_mart"
            case .walleyeWarehouse:
                return "walleye_warehouse"
            case .arowanaMall:
                return "arowana_mall"
            case .campTriggerfish:
                return "camp_triggerfish"
            case .piranhaPit:
                return "piranha_pit"
            case .gobyArena:
                return "goby_arena"
            case .newAlbacoreHotel:
                return "new_albacore_hotel"
            case .wahooWorld:
                return "wahoo_world"
            case .anchoVGames:
                return "ancho_v_games"
            case .skipperPavilion:
                return "skipper_pavilion"
            }
        }
    }

    enum StageId: Int, CaseIterable, Codable {
        case theReef = 0
        case musselforgeFitness = 1
        case starfishMainstage = 2
        case sturgeonShipyard = 3
        case inkblotArtAcademy = 4
        case humpbackPumpTrack = 5
        case mantaMaria = 6
        case portMackerel = 7
        case morayTowers = 8
        case snapperCanal = 9
        case kelpDome = 10
        case blackbellySkatepark = 11
        case shellendorfInstitute = 12
        case makoMart = 13
        case walleyeWarehouse = 14
        case arowanaMall = 15
        case campTriggerfish = 16
        case piranhaPit = 17
        case gobyArena = 18
        case newAlbacoreHotel = 19
        case wahooWorld = 20
        case anchoVGames = 21
        case skipperPavilion = 22
    }
}
