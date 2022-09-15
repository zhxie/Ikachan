//
//  Stage.swift
//  Ikachan
//
//  Created by Sketch on 2022/9/14.
//

import Foundation

protocol Stage: Codable {
    var name: String { get }
    var imageUrl: String { get }
}

enum Splatoon2ScheduleStage: Int, Stage, CaseIterable {
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
    
    private var image: String {
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
    
    var name: String {
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
    var imageUrl: String {
        return Splatnet2URL + image
    }
}

enum Splatoon2ShiftStage: Int, Stage, CaseIterable {
    case spawningGrounds = 5000
    case maroonersBay = 5001
    case lostOutpost = 5002
    case salmonidSmokeyard = 5003
    case ruinsOfArkPolaris = 5004
    
    var image: String {
        switch self {
        case .spawningGrounds:
            return "/images/coop_stage/65c68c6f0641cc5654434b78a6f10b0ad32ccdee.png"
        case .maroonersBay:
            return "/images/coop_stage/e07d73b7d9f0c64e552b34a2e6c29b8564c63388.png"
        case .lostOutpost:
            return "/images/coop_stage/6d68f5baa75f3a94e5e9bfb89b82e7377e3ecd2c.png"
        case .salmonidSmokeyard:
            return "/images/coop_stage/e9f7c7b35e6d46778cd3cbc0d89bd7e1bc3be493.png"
        case .ruinsOfArkPolaris:
            return "/images/coop_stage/50064ec6e97aac91e70df5fc2cfecf61ad8615fd.png"
        }
    }
    
    var name: String {
        switch self {
        case .spawningGrounds:
            return "spawning_grounds"
        case .maroonersBay:
            return "marooners_bay"
        case .lostOutpost:
            return "lost_outpost"
        case .salmonidSmokeyard:
            return "salmonid_smokeyard"
        case .ruinsOfArkPolaris:
            return "ruins_of_ark_polaris"
        }
    }
    var imageUrl: String {
        return Splatnet2URL + image
    }
}
