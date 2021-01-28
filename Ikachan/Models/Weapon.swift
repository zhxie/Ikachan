//
//  Weapon.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/16.
//

import Foundation
import SwiftUI

struct Weapon: Hashable, Codable {
    var id: WeaponId
    enum WeaponId: Int, CaseIterable, Codable {
        case bold = 0
        case wakaba = 10
        case sharp = 20
        case promodelerMg = 30
        case sshooter = 40
        case _52Gal = 50
        case nzap85 = 60
        case prime = 70
        case _96Gal = 80
        case jetsweeper = 90
        case nova = 200
        case hotblaster = 210
        case longblaster = 220
        case clashblaster = 230
        case rapid = 240
        case rapidElite = 250
        case l3Reelgun = 300
        case h3Reelgun = 310
        case bottlegeyser = 400
        case carbon = 1000
        case splatroller = 1010
        case dynamo = 1020
        case variableroller = 1030
        case pablo = 1100
        case hokusai = 1110
        case squicleanA = 2000
        case splatcharger = 2010
        case splatscope = 2020
        case liter4K = 2030
        case liter4KScoper = 2040
        case bamboo14Mk1 = 2050
        case soytuber = 2060
        case bucketslosher = 3000
        case hissen = 3010
        case screwslosher = 3020
        case furo = 3030
        case explosher = 3040
        case splatspinner = 4000
        case barrelspinner = 4010
        case hydra = 4020
        case kugelschreiber = 4030
        case nautilus47 = 4040
        case sputtery = 5000
        case maneuver = 5010
        case kelvin525 = 5020
        case dualsweeper = 5030
        case quadhopperBlack = 5040
        case parashelter = 6000
        case campingshelter = 6010
        case spygadget = 6020
        case random = -1
        case randomGold = -2
        
        var description: LocalizedStringKey {
            switch self {
            case .bold:
                return "sploosh_o_matic"
            case .wakaba:
                return "splattershot_jr"
            case .sharp:
                return "splash_o_matic"
            case .promodelerMg:
                return "aerospray_mg"
            case .sshooter:
                return "splattershot"
            case ._52Gal:
                return "_52_gal"
            case .nzap85:
                return "n_zap_85"
            case .prime:
                return "splattershot_pro"
            case ._96Gal:
                return "_96_gal"
            case .jetsweeper:
                return "jet_squelcher"
            case .nova:
                return "luna_blaster"
            case .hotblaster:
                return "blaster"
            case .longblaster:
                return "range_blaster"
            case .clashblaster:
                return "clash_blaster"
            case .rapid:
                return "rapid_blaster"
            case .rapidElite:
                return "rapid_blaster_pro"
            case .l3Reelgun:
                return "l_3_nozzlenose"
            case .h3Reelgun:
                return "h_3_nozzlenose"
            case .bottlegeyser:
                return "squeezer"
            case .carbon:
                return "carbon_roller"
            case .splatroller:
                return "splat_roller"
            case .dynamo:
                return "dynamo_roller"
            case .variableroller:
                return "flingza_roller"
            case .pablo:
                return "inkbrush"
            case .hokusai:
                return "octobrush"
            case .squicleanA:
                return "classic_squiffer"
            case .splatcharger:
                return "splat_charger"
            case .splatscope:
                return "splatterscope"
            case .liter4K:
                return "e_liter_4k"
            case .liter4KScoper:
                return "e_liter_4k_scope"
            case .bamboo14Mk1:
                return "bamboozler_14_mk_i"
            case .soytuber:
                return "goo_tuber"
            case .bucketslosher:
                return "slosher"
            case .hissen:
                return "tri_slosher"
            case .screwslosher:
                return "sloshing_machine"
            case .furo:
                return "bloblobber"
            case .explosher:
                return "explosher"
            case .splatspinner:
                return "splatling"
            case .barrelspinner:
                return "heavy_splatling"
            case .hydra:
                return "hydra_splatling"
            case .kugelschreiber:
                return "ballpoint_splatling"
            case .nautilus47:
                return "nautilus_47"
            case .sputtery:
                return "dapple_dualies"
            case .maneuver:
                return "splat_dualies"
            case .kelvin525:
                return "glooga_dualies"
            case .dualsweeper:
                return "dualie_squelchers"
            case .quadhopperBlack:
                return "dark_tetra_dualies"
            case .parashelter:
                return "splat_brella"
            case .campingshelter:
                return "tenta_brella"
            case .spygadget:
                return "undercover_brella"
            case .random:
                return "random"
            case .randomGold:
                return "random"
            }
        }
    }
    
    var description: LocalizedStringKey {
        self.id.description
    }
    
    var image: String
    
    var url: String {
        Splatnet2URL + image
    }
}
