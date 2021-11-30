//
//  Weapon.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/16.
//

import Foundation

struct Weapon: Hashable, Codable {
    var id: Id
    enum Id: Int, CaseIterable, Codable {
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
        case grizzcoBlaster = 20000
        case grizzcoBrella = 20010
        case grizzcoCharger = 20020
        case grizzcoSlosher = 20030
        case random = -1
        case randomGold = -2
        
        var description: String {
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
            case .grizzcoBlaster:
                return "kuma_blaster"
            case .grizzcoBrella:
                return "kuma_brella"
            case .grizzcoCharger:
                return "kuma_charger"
            case .grizzcoSlosher:
                return "kuma_slosher"
            case .random:
                return "random"
            case .randomGold:
                return "random2"
            }
        }
        
        var defaultURL: String {
            switch self {
            case .bold:
                return "/images/weapon/32d41a5d14de756c3e5a1ee97a9bd8fcb9e69bf5.png"
            case .wakaba:
                return "/images/weapon/91b6666bcbfccc204d86f21222a8db22a27d08d0.png"
            case .sharp:
                return "/images/weapon/e5a97d52f12a83a037526588363021f2c1f718b0.png"
            case .promodelerMg:
                return "/images/weapon/c6ab7ebff7af7f7604eb53a12851da880b1ec2c7.png"
            case .sshooter:
                return "/images/weapon/e1d09fc9502a81c82137c8dcd5a872eb872af697.png"
            case ._52Gal:
                return "/images/weapon/df04ddaf086cea94491df553a6d2550230a4da3c.png"
            case .nzap85:
                return "/images/weapon/1f2b1db5917ef7a4e62f0e15b8805275e33f2179.png"
            case .prime:
                return "/images/weapon/2e2b59379b8f14cfed0600f84590be0ecad707b6.png"
            case ._96Gal:
                return "/images/weapon/df90f6065594378690647c23d42440e2de89c99d.png"
            case .jetsweeper:
                return "/images/weapon/007fb7ed50e76dde495ffb0747421b50dfce8aa3.png"
            case .nova:
                return "/images/weapon/3f840ce3cc5ac0b8cbf7451079b57e807d8b95f1.png"
            case .hotblaster:
                return "/images/weapon/cfafc8bc42bcd89058fdb22b7b943fb9f893adb8.png"
            case .longblaster:
                return "/images/weapon/109b2b851481510eaacb50afc8ce9fb79b7f20ad.png"
            case .clashblaster:
                return "/images/weapon/2b684d81508ca5286060767e29dd81ca38303f43.png"
            case .rapid:
                return "/images/weapon/72bdcf5f6077bd7149832153034b3f43d16ac461.png"
            case .rapidElite:
                return "/images/weapon/8f64580bb033ba86fa0179179cfeb56b5544fda6.png"
            case .l3Reelgun:
                return "/images/weapon/202724be5bb5e59457227d087d7c48a32c01db24.png"
            case .h3Reelgun:
                return "/images/weapon/45e8847cbaf09bdc86c6e6627236286781b09f0f.png"
            case .bottlegeyser:
                return "/images/weapon/b9901d49ef3229d3e62d58fc3e1edc8c48da6873.png"
            case .carbon:
                return "/images/weapon/123db7c37066e10e2c437656db2a26f18898e6b6.png"
            case .splatroller:
                return "/images/weapon/1041dbdd11b3036671148d47c2e0798cecf3dba2.png"
            case .dynamo:
                return "/images/weapon/3d274190988ad20dd1b02825448edbb6e12c720c.png"
            case .variableroller:
                return "/images/weapon/e32ed68bb18628c5ede5816a2fbc2b8fcdd04124.png"
            case .pablo:
                return "/images/weapon/1f94c29067c918ac9143b756dc607ff0f8cf4e63.png"
            case .hokusai:
                return "/images/weapon/f1d5740dfb7d87f7e43974bbe5585445368741b8.png"
            case .squicleanA:
                return "/images/weapon/5a0a20324f1374a363363d721a605849e36ffff2.png"
            case .splatcharger:
                return "/images/weapon/1ed94885bef2b0e498ed4dd76bea9064c85cfc94.png"
            case .splatscope:
                return "/images/weapon/0ec07bb00918f071975b35191e0860152bdcb321.png"
            case .liter4K:
                return "/images/weapon/a6279990ad871fccdd9f2a64a2951f8726f45c48.png"
            case .liter4KScoper:
                return "/images/weapon/fd4b89e84b375f01290185f2236dbee935dd1682.png"
            case .bamboo14Mk1:
                return "/images/weapon/6ecbbb897d6c59a5c03097216ef4f803366ea6fa.png"
            case .soytuber:
                return "/images/weapon/26d523e6eee3d57dc6c5f531dfc1747ffd46b8b8.png"
            case .bucketslosher:
                return "/images/weapon/3963a3fb1ff8038a42072e913587fc6f9aa00d71.png"
            case .hissen:
                return "/images/weapon/ad921a57ab1b7721c50873c082bb34591b61021c.png"
            case .screwslosher:
                return "/images/weapon/27a026e7dec5a068777bb7883f50451aec799d71.png"
            case .furo:
                return "/images/weapon/2835f6d61a4296b4ac3876337884a0c453a4fa4f.png"
            case .explosher:
                return "/images/weapon/6f1c2a339db6ec0dccb65704adee2db93c768245.png"
            case .splatspinner:
                return "/images/weapon/2a1c5ca0e68919b4d655bd860cac3b2942b95498.png"
            case .barrelspinner:
                return "/images/weapon/6f42c9f8fde07510a01072a669125545f6effb99.png"
            case .hydra:
                return "/images/weapon/e34bbd580e49695b97d5fc4464cc901d4fe08ce5.png"
            case .kugelschreiber:
                return "/images/weapon/f208b6222acb5014ab96285e9b9a3e98039c884b.png"
            case .nautilus47:
                return "/images/weapon/d79b99092aa03dc249b1f767197c1ecbda9d3cd7.png"
            case .sputtery:
                return "/images/weapon/cc4bc30ff53bf2b45bd5e3dadceb39d52b95761f.png"
            case .maneuver:
                return "/images/weapon/bb5caf24e43f8c7ceb126670bf24fd3aa9a3c3fc.png"
            case .kelvin525:
                return "/images/weapon/7d6032f0ceee14c4607385b848c6e486b84a2865.png"
            case .dualsweeper:
                return "/images/weapon/aaead5ff0b63cdcb989b211d649b2552bb3e3a1b.png"
            case .quadhopperBlack:
                return "/images/weapon/ba750d284eb067abdc995435c3358eed4e6f90fa.png"
            case .parashelter:
                return "/images/weapon/f1fa6db2e21f32cd1c2cd093ec24f1a450d4650c.png"
            case .campingshelter:
                return "/images/weapon/cdb032aa993f4836580ce4edac06de0138833299.png"
            case .spygadget:
                return "/images/weapon/15fe3fe6bbec24ddb5fdc3ffd06585bc82440531.png"
            case .grizzcoBlaster:
                return "/images/weapon/db39203d81d60a7370d3ae966bc02ed14398366f.png"
            case .grizzcoBrella:
                return "/images/weapon/7d5ff3a57c3c3aaf28217bc3a79e02d665f13ba7.png"
            case .grizzcoCharger:
                return "/images/weapon/95077fe72924bcd64f37cd43aa49a12cd6329a7e.png"
            case .grizzcoSlosher:
                return "/images/weapon/c2c0653d3246ea6df2b595c68e907f68eda49b08.png"
            case .random:
                return "/images/coop_weapons/746f7e90bc151334f0bf0d2a1f0987e311b03736.png"
            case .randomGold:
                return "/images/coop_weapons/7076c8181ab5c49d2ac91e43a2d945a46a99c17d.png"
            }
        }
    }
    
    var description: String {
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
