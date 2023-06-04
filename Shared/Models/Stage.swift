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
    var thumbnailUrl: String { get }
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
    case unknown = -9999
    
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
        case .unknown:
            return Unknown.stageImage2
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
        case .unknown:
            return Unknown.name
        }
    }
    var imageUrl: String {
        switch self {
        case .unknown:
            return Unknown.stageImage2Url
        default:
            return Splatnet2URL + image
        }
    }
    var thumbnailUrl: String {
        return imageUrl
    }
}

enum Splatoon2ShiftStage: Int, Stage, CaseIterable {
    case spawningGrounds = 5000
    case maroonersBay = 5001
    case lostOutpost = 5002
    case salmonidSmokeyard = 5003
    case ruinsOfArkPolaris = 5004
    case unknown = -9999
    
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
        case .unknown:
            return Unknown.stageImage2
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
        case .unknown:
            return Unknown.name
        }
    }
    var imageUrl: String {
        switch self {
        case .unknown:
            return Unknown.stageImage2Url
        default:
            return Splatnet2URL + image
        }
    }
    var thumbnailUrl: String {
        return imageUrl
    }
}

enum Splatoon3ScheduleStage: Int, Stage, CaseIterable {
    case scorchGorge = 1
    case eeltailAlley = 2
    case hagglefishMarket = 3
    case undertowSpillway = 4
    case umAmiRuins = 5
    case mincemeatMetalworks = 6
    case brinewaterSprings = 7
    case barnacleDime = 8
    case flounderHeights = 9
    case hammerheadBridge = 10
    case museumDAlfonsino = 11
    case mahiMahiResort = 12
    case inkblotArtAcademy = 13
    case sturgeonShipyard = 14
    case makoMart = 15
    case wahooWorld = 16
    case humpbackPumpTrack = 17
    case mantaMaria = 18
    case empty = -999
    case unknown = -9999
    
    var image: String {
        switch self {
        case .scorchGorge:
            return "/stage_img/icon/high_resolution/35f9ca08ccc2bf759774ab2cb886567c117b9287875ca92fb590c1294ddcdc1e_0.png"
        case .eeltailAlley:
            return "/stage_img/icon/high_resolution/898e1ae6c737a9d44552c7c81f9b710676492681525c514eadc68a6780aa52af_0.png"
        case .hagglefishMarket:
            return "/stage_img/icon/high_resolution/8dc2f16d39c630bab40cead5b2485ca3559e829d0d3de0c2232c7a62fefb5fa9_0.png"
        case .undertowSpillway:
            return "/stage_img/icon/high_resolution/9b1c17b2075479d0397d2fb96efbc6fa3a28900712920e5fe1e9dfc59c6abc5c_0.png"
        case .umAmiRuins:
            return "/stage_img/icon/high_resolution/f14c2a64e49d243679fc0884af91e1a07dc65600f9b90aefe92d7790dcffb191_0.png"
        case .mincemeatMetalworks:
            return "/stage_img/icon/high_resolution/de1f212e9ff0648f36cd3b8e0917ef36b3bd51445159297dcb948f34a09f2f05_0.png"
        case .brinewaterSprings:
            return "/stage_img/icon/high_resolution/cd84d711b47a424334569ac20f33f8e0ab6a652dc07854dcd36508a0081e9034_0.png"
        case .barnacleDime:
            return "/stage_img/icon/high_resolution/f70e9f5af477a39ccfab631bfb81c9e2cedb4cd0947fe260847c214a6d23695f_0.png"
        case .flounderHeights:
            return "/stage_img/icon/high_resolution/488017f3ce712fca9fb37d61fe306343054449bb2d2bb1751d95f54a98564cae_0.png"
        case .hammerheadBridge:
            return "/stage_img/icon/high_resolution/1db8ab338b64b464df50e7f9e270e59423ff8caac6f09679a24f1b7acf3a82f3_0.png"
        case .museumDAlfonsino:
            return "/stage_img/icon/high_resolution/b9d8cfa186d197a27e075600a107c99d9e21646d116730f0843e0fff0aaba7dd_0.png"
        case .mahiMahiResort:
            return "/stage_img/icon/high_resolution/8273118c1ffe1bf6fe031c7d8c9795dab52632c9b76e8e9f01f644ac5ae0ccc0_0.png"
        case .inkblotArtAcademy:
            return "/stage_img/icon/high_resolution/40aba8b36a9439e2d670fde5b3478819ea8a94f9e503b9d783248a5716786f35_0.png"
        case .sturgeonShipyard:
            return "/stage_img/icon/high_resolution/48684c69d5c5a4ffaf16b712a4895545a8d01196115d514fc878ce99863bb3e9_0.png"
        case .makoMart:
            return "/stage_img/icon/high_resolution/a8ba96c3dbd015b7bc6ea4fa067245c4e9aee62b6696cb41e02d35139dd21fe7_0.png"
        case .wahooWorld:
            return "/stage_img/icon/high_resolution/61ea801fa4ed32360dcaf83986222ded46a72dbf56194acc6d0cf4659a92ba85_0.png"
        case .humpbackPumpTrack:
            return "/stage_img/icon/high_resolution/7b3cf118bd9f45d141cd6db0ee75b06e697fa83945c7fe1e6f8483de6a591f5f_0.png"
        case .mantaMaria:
            return "/stage_img/icon/high_resolution/0b7fd997781e03eb9d5bf1875ed070f698afc654f4fe929452c65aa26c0a35fd_0.png"
        case .empty:
            return "/stage_img/icon/high_resolution/59a42245071d692c58b9825886f89f95e092ae0aa83a46617fdb4cbcb2f5f2b8_0.png"
        case .unknown:
            return Unknown.stageImage3
        }
    }
    private var thumbnail: String {
        switch self {
        case .scorchGorge:
            return "/stage_img/icon/low_resolution/35f9ca08ccc2bf759774ab2cb886567c117b9287875ca92fb590c1294ddcdc1e_1.png"
        case .eeltailAlley:
            return "/stage_img/icon/low_resolution/898e1ae6c737a9d44552c7c81f9b710676492681525c514eadc68a6780aa52af_1.png"
        case .hagglefishMarket:
            return "/stage_img/icon/low_resolution/8dc2f16d39c630bab40cead5b2485ca3559e829d0d3de0c2232c7a62fefb5fa9_1.png"
        case .undertowSpillway:
            return "/stage_img/icon/low_resolution/9b1c17b2075479d0397d2fb96efbc6fa3a28900712920e5fe1e9dfc59c6abc5c_1.png"
        case .umAmiRuins:
            return "/stage_img/icon/low_resolution/f14c2a64e49d243679fc0884af91e1a07dc65600f9b90aefe92d7790dcffb191_1.png"
        case .mincemeatMetalworks:
            return "/stage_img/icon/low_resolution/de1f212e9ff0648f36cd3b8e0917ef36b3bd51445159297dcb948f34a09f2f05_1.png"
        case .brinewaterSprings:
            return "/stage_img/icon/low_resolution/cd84d711b47a424334569ac20f33f8e0ab6a652dc07854dcd36508a0081e9034_1.png"
        case .barnacleDime:
            return "/stage_img/icon/low_resolution/f70e9f5af477a39ccfab631bfb81c9e2cedb4cd0947fe260847c214a6d23695f_1.png"
        case .flounderHeights:
            return "/stage_img/icon/low_resolution/488017f3ce712fca9fb37d61fe306343054449bb2d2bb1751d95f54a98564cae_1.png"
        case .hammerheadBridge:
            return "/stage_img/icon/low_resolution/1db8ab338b64b464df50e7f9e270e59423ff8caac6f09679a24f1b7acf3a82f3_1.png"
        case .museumDAlfonsino:
            return "/stage_img/icon/low_resolution/b9d8cfa186d197a27e075600a107c99d9e21646d116730f0843e0fff0aaba7dd_1.png"
        case .mahiMahiResort:
            return "/stage_img/icon/low_resolution/8273118c1ffe1bf6fe031c7d8c9795dab52632c9b76e8e9f01f644ac5ae0ccc0_1.png"
        case .inkblotArtAcademy:
            return "/stage_img/icon/low_resolution/40aba8b36a9439e2d670fde5b3478819ea8a94f9e503b9d783248a5716786f35_1.png"
        case .sturgeonShipyard:
            return "/stage_img/icon/low_resolution/48684c69d5c5a4ffaf16b712a4895545a8d01196115d514fc878ce99863bb3e9_1.png"
        case .makoMart:
            return "/stage_img/icon/low_resolution/a8ba96c3dbd015b7bc6ea4fa067245c4e9aee62b6696cb41e02d35139dd21fe7_1.png"
        case .wahooWorld:
            return "/stage_img/icon/low_resolution/61ea801fa4ed32360dcaf83986222ded46a72dbf56194acc6d0cf4659a92ba85_1.png"
        case .humpbackPumpTrack:
            return "/stage_img/icon/low_resolution/7b3cf118bd9f45d141cd6db0ee75b06e697fa83945c7fe1e6f8483de6a591f5f_1.png"
        case .mantaMaria:
            return "/stage_img/icon/low_resolution/0b7fd997781e03eb9d5bf1875ed070f698afc654f4fe929452c65aa26c0a35fd_1.png"
        case .empty:
            return "/stage_img/icon/low_resolution/59a42245071d692c58b9825886f89f95e092ae0aa83a46617fdb4cbcb2f5f2b8_1.png"
        case .unknown:
            return Unknown.stageThumbnail3
        }
    }
    
    var name: String {
        switch self {
        case .scorchGorge:
            return "scorch_gorge"
        case .eeltailAlley:
            return "eeltail_alley"
        case .hagglefishMarket:
            return "hagglefish_market"
        case .undertowSpillway:
            return "undertow_spillway"
        case .umAmiRuins:
            return "um_ami_ruins"
        case .mincemeatMetalworks:
            return "mincemeat_metalworks"
        case .brinewaterSprings:
            return "brinewater_springs"
        case .barnacleDime:
            return "barnacle_dime"
        case .flounderHeights:
            return "flounder_heights"
        case .hammerheadBridge:
            return "hammerhead_bridge"
        case .museumDAlfonsino:
            return "museum_d_alfonsino"
        case .mahiMahiResort:
            return "mahi_mahi_resort"
        case .inkblotArtAcademy:
            return "inkblot_art_academy"
        case .sturgeonShipyard:
            return "sturgeon_shipyard"
        case .makoMart:
            return "mako_mart"
        case .wahooWorld:
            return "wahoo_world"
        case .humpbackPumpTrack:
            return "humpback_pump_track"
        case .mantaMaria:
            return "manta_maria"
        case .empty:
            return ""
        case .unknown:
            return Unknown.name
        }
    }
    var imageUrl: String {
        switch self {
        case .unknown:
            return Unknown.stageImage3Url
        default:
            return Splatoon3InkAssetsURL + image
        }
    }
    var thumbnailUrl: String {
        switch self {
        case .unknown:
            return Unknown.stageThumbnail3Url
        default:
            return Splatoon3InkAssetsURL + thumbnail
        }
    }
}

enum Splatoon3ShiftStage: Int, Stage, CaseIterable {
    case spawningGrounds = 1
    case sockeyeStation = 2
    case maroonersBay = 6
    case goneFissionHydroplant = 7
    case jamminSalmonJunction = 8
    case wahooWorld = 100
    case inkblotArtAcademy = 102
    case undertowSpillway = 103
    case empty = -999
    case unknown = -9999
    
    var image: String {
        switch self {
        case .spawningGrounds:
            return "/stage_img/icon/high_resolution/be584c7c7f547b8cbac318617f646680541f88071bc71db73cd461eb3ea6326e_0.png"
        case .sockeyeStation:
            return "/stage_img/icon/high_resolution/3418d2d89ef84288c78915b9acb63b4ad48df7bfcb48c27d6597920787e147ec_0.png"
        case .maroonersBay:
            return "/stage_img/icon/high_resolution/1a29476c1ab5fdbc813e2df99cd290ce56dfe29755b97f671a7250e5f77f4961_0.png"
        case .goneFissionHydroplant:
            return "/stage_img/icon/high_resolution/f1e4df4cff1dc5e0acc66a9654fecf949224f7e4f6bd36305d4600ac3fa3db7b_0.png"
        case .jamminSalmonJunction:
            return "/stage_img/icon/high_resolution/0e05d4caa34089a447535708370286f4ee6068661359b4d7cf6c319863424f84_0.png"
        case .wahooWorld:
            return "/stage_img/icon/high_resolution/2276a46e42a11637776ebc15cf2d46a589f1dba34a76d5c940c418ed7371d071_0.png"
        case .inkblotArtAcademy:
            return "/stage_img/icon/high_resolution/3598b7f54248b84c47cde6b99aa45ff296a41d3d5f38eaccfe2327b2874fff0b_0.png"
        case .undertowSpillway:
            return "/stage_img/icon/high_resolution/71c7076fc2d23f1833c923747e8582e29eb275bed96d8360aa5d0ed6ae069230_0.png"
        case .empty:
            return "/stage_img/icon/high_resolution/59a42245071d692c58b9825886f89f95e092ae0aa83a46617fdb4cbcb2f5f2b8_0.png"
        case .unknown:
            return Unknown.stageImage3
        }
    }
    private var thumbnail: String {
        switch self {
        case .spawningGrounds:
            return "/stage_img/icon/low_resolution/be584c7c7f547b8cbac318617f646680541f88071bc71db73cd461eb3ea6326e_1.png"
        case .sockeyeStation:
            return "/stage_img/icon/low_resolution/3418d2d89ef84288c78915b9acb63b4ad48df7bfcb48c27d6597920787e147ec_1.png"
        case .maroonersBay:
            return "/stage_img/icon/low_resolution/1a29476c1ab5fdbc813e2df99cd290ce56dfe29755b97f671a7250e5f77f4961_1.png"
        case .goneFissionHydroplant:
            return "/stage_img/icon/low_resolution/f1e4df4cff1dc5e0acc66a9654fecf949224f7e4f6bd36305d4600ac3fa3db7b_1.png"
        case .jamminSalmonJunction:
            return "/stage_img/icon/low_resolution/0e05d4caa34089a447535708370286f4ee6068661359b4d7cf6c319863424f84_1.png"
        case .wahooWorld:
            return "/stage_img/icon/low_resolution/2276a46e42a11637776ebc15cf2d46a589f1dba34a76d5c940c418ed7371d071_1.png"
        case .inkblotArtAcademy:
            return "/stage_img/icon/low_resolution/3598b7f54248b84c47cde6b99aa45ff296a41d3d5f38eaccfe2327b2874fff0b_1.png"
        case .undertowSpillway:
            return "/stage_img/icon/low_resolution/71c7076fc2d23f1833c923747e8582e29eb275bed96d8360aa5d0ed6ae069230_1.png"
        case .empty:
            return "/stage_img/icon/low_resolution/59a42245071d692c58b9825886f89f95e092ae0aa83a46617fdb4cbcb2f5f2b8_1.png"
        case .unknown:
            return Unknown.stageThumbnail3
        }
    }
    
    var name: String {
        switch self {
        case .spawningGrounds:
            return "spawning_grounds"
        case .sockeyeStation:
            return "sockeye_station"
        case .maroonersBay:
            return "marooners_bay"
        case .goneFissionHydroplant:
            return "gone_fission_hydroplant"
        case .jamminSalmonJunction:
            return "jammin_salmon_junction"
        case .wahooWorld:
            return "wahoo_world"
        case .inkblotArtAcademy:
            return "inkblot_art_academy"
        case .undertowSpillway:
            return "undertow_spillway"
        case .empty:
            return ""
        case .unknown:
            return Unknown.name
        }
    }
    var imageUrl: String {
        switch self {
        case .unknown:
            return Unknown.stageImage3Url
        default:
            return Splatoon3InkAssetsURL + image
        }
    }
    var thumbnailUrl: String {
        switch self {
        case .unknown:
            return Unknown.stageThumbnail3Url
        default:
            return Splatoon3InkAssetsURL + thumbnail
        }
    }
}
