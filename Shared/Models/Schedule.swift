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
                return "regular_battle"
            case .gachi:
                return "ranked_battle"
            case .league:
                return "league_battle"
            }
        }
        
        var shortDescription: LocalizedStringKey {
            switch self {
            case .regular:
                return "regular"
            case .gachi:
                return "ranked"
            case .league:
                return "league"
            }
        }
        
        var shorterDescription: LocalizedStringKey {
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
            return LocalizedStringKey(stringLiteral: rawValue)
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
    
    var shortDescription: String {
        switch gameMode {
        case .regular:
            return rule.shortDescription.rawValue.localizedString
        case .gachi, .league:
            return String(format: "%@_%@".localizedString, gameMode.shorterDescription.rawValue.localizedString, rule.shorterDescription.rawValue.localizedString)
        }
    }

    var stageA: Stage
    var stageB: Stage
    struct Stage: Hashable, Codable, Identifiable {
        var id: Id
        enum Id: Int, CaseIterable, Codable {
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
            
            var description: LocalizedStringKey {
                switch self {
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
            
            var defaultURL: String {
                switch self {
                case .theReef:
                    return "/images/stage/98baf21c0366ce6e03299e2326fe6d27a7582dce.png"
                case .musselforgeFitness:
                    return "/images/stage/83acec875a5bb19418d7b87d5df4ba1e38ceac66.png"
                case .starfishMainstage:
                    return "/images/stage/187987856bf575c4155d021cb511034931d06d24.png"
                case .sturgeonShipyard:
                    return "/images/stage/bc794e337900afd763f8a88359f83df5679ddf12.png"
                case .inkblotArtAcademy:
                    return "/images/stage/5c030a505ee57c889d3e5268a4b10c1f1f37880a.png"
                case .humpbackPumpTrack:
                    return "/images/stage/fc23fedca2dfbbd8707a14606d719a4004403d13.png"
                case .mantaMaria:
                    return "/images/stage/070d7ee287fdf3c5df02411950c2a1ce5b238746.png"
                case .portMackerel:
                    return "/images/stage/0907fc7dc325836a94d385919fe01dc13848612a.png"
                case .morayTowers:
                    return "/images/stage/96fd8c0492331a30e60a217c94fd1d4c73a966cc.png"
                case .snapperCanal:
                    return "/images/stage/8c95053b3043e163cbfaaf1ec1e5f3eb770e5e07.png"
                case .kelpDome:
                    return "/images/stage/a12e4bf9f871677a5f3735d421317fbbf09e1a78.png"
                case .blackbellySkatepark:
                    return "/images/stage/758338859615898a59e93b84f7e1ca670f75e865.png"
                case .shellendorfInstitute:
                    return "/images/stage/23259c80272f45cea2d5c9e60bc0cedb6ce29e46.png"
                case .makoMart:
                    return "/images/stage/d9f0f6c330aaa3b975e572637b00c4c0b6b89f7d.png"
                case .walleyeWarehouse:
                    return "/images/stage/65c99da154295109d6fe067005f194f681762f8c.png"
                case .arowanaMall:
                    return "/images/stage/dcf332bdcc80f566f3ae59c1c3a29bc6312d0ba8.png"
                case .campTriggerfish:
                    return "/images/stage/e4c4800be9fff23112334b193abb0fdf36e05933.png"
                case .piranhaPit:
                    return "/images/stage/828e49a8414a4bbc0a5da3e61454ab148a9f4063.png"
                case .gobyArena:
                    return "/images/stage/8cab733d543efc9dd561bfcc9edac52594e62522.png"
                case .newAlbacoreHotel:
                    return "/images/stage/98a7d7a4009fae9fb7479554535425a5a604e88e.png"
                case .wahooWorld:
                    return "/images/stage/555c356487ac3edb0088c416e8045576c6b37fcc.png"
                case .anchoVGames:
                    return "/images/stage/1430e5ac7ae9396a126078eeab824a186b490b5a.png"
                case .skipperPavilion:
                    return "/images/stage/132327c819abf2bd44d0adc0f4a21aad9cc84bb2.png"
                }
            }
        }
        
        var description: LocalizedStringKey {
            id.description
        }
        
        var image: String
        
        var url: String {
            if image.isEmpty {
                return Splatnet2URL + id.defaultURL
            } else {
                return Splatnet2URL + image
            }
        }
    }
}
