//
//  Weapon.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/16.
//

import Foundation

protocol Weapon: Codable {
    var name: String { get }
    var imageUrl: String { get }
    var thumbnailUrl: String { get }
}

enum Splatoon2Weapon: Int, Weapon, CaseIterable {
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
    case unknown = -9999
    
    private var image: String {
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
        case .unknown:
            return Unknown.iconImage2
        }
    }
    
    var name: String {
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
            return "mini_splatling"
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
        case .unknown:
            return Unknown.name
        }
    }
    var imageUrl: String {
        switch self {
        case .unknown:
            return Unknown.iconImage2Url
        default:
            return Splatnet2URL + image
        }
    }
    var thumbnailUrl: String {
        return imageUrl
    }
}

enum Splatoon3Weapon: Int, Weapon, CaseIterable {
    case splooshOMatic = 0
    case splattershotJr = 10
    case splashOMatic = 20
    case aerosprayMg = 30
    case splattershot = 40
    case _52Gal = 50
    case nZap85 = 60
    case splattershotPro = 70
    case _96Gal = 80
    case jetSquelcher = 90
    case splattershotNova = 100
    case lunaBlaster = 200
    case blaster = 210
    case rangeBlaster = 220
    case clashBlaster = 230
    case rapidBlaster = 240
    case rapidBlasterPro = 250
    case l3Nozzlenose = 300
    case h3Nozzlenose = 310
    case squeezer = 400
    case carbonRoller = 1000
    case splatRoller = 1010
    case dynamoRoller = 1020
    case flingzaRoller = 1030
    case bigSwigRoller = 1040
    case inkbrush = 1100
    case octobrush = 1110
    case classicSquiffer = 2000
    case splatCharger = 2010
    case splatterscope = 2020
    case eLiter4k = 2030
    case eLiter4kScope = 2040
    case bamboozler14MkI = 2050
    case gooTuber = 2060
    case snipewriter5h = 2070
    case slosher = 3000
    case triSlosher = 3010
    case sloshingMachine = 3020
    case bloblobber = 3030
    case explosher = 3040
    case miniSplatling = 4000
    case heavySplatling = 4010
    case hydraSplatling = 4020
    case ballpointSplatling = 4030
    case nautilus47 = 4040
    case dappleDualies = 5000
    case splatDualies = 5010
    case gloogaDualies = 5020
    case dualieSquelchers = 5030
    case darkTetraDualies = 5040
    case splatBrella = 6000
    case tentaBrella = 6010
    case undercoverBrella = 6020
    case triStringer = 7010
    case reefLux450 = 7020
    case splatanaStamper = 8000
    case splatanaWiper = 8010
    case random = -1
    case randomGold = -2
    case unknown = -9999
    
    var image: String {
        switch self {
        case .splooshOMatic:
            return "/weapon_illust/6e58a0747ab899badcb6f351512c6034e0a49bd6453281f32c7f550a2132fd65_0.png"
        case .splattershotJr:
            return "/weapon_illust/8e134a80cd54f4235329493afd43ff754b367a65e460facfcca862b174754b0e_0.png"
        case .splashOMatic:
            return "/weapon_illust/25e98eaba1e17308db191b740d9b89e6a977bfcd37c8dc1d65883731c0c72609_0.png"
        case .aerosprayMg:
            return "/weapon_illust/5ec00bcf96c7a3f731d7a2e67f60f802f33d22f07177b94d5905f471b08b629f_0.png"
        case .splattershot:
            return "/weapon_illust/e3874d7d504acf89488ad7f68d29a348caea1a41cd43bd9a272069b0c0466570_0.png"
        case ._52Gal:
            return "/weapon_illust/01e8399a3c56707b6e9f7500d3d583ba1d400eec06449d8fe047cda1956a4ccc_0.png"
        case .nZap85:
            return "/weapon_illust/e6dbf73aa6ff9d1feb61fcabadb2d31e08b228a9736b4f5d8a5baeab9b493255_0.png"
        case .splattershotPro:
            return "/weapon_illust/5607f7014bbc7339feeb67218c05ef19c7a466152b1bd056a899b955127ea433_0.png"
        case ._96Gal:
            return "/weapon_illust/fe2b351799aa48fcb48154299ff0ccf0b0413fc291ffc49456e93db29d2f1db5_0.png"
        case .jetSquelcher:
            return "/weapon_illust/035920eb9428955c25aecb8a56c2b1b58f3e322af3657d921db1778de4b80c59_0.png"
        case .splattershotNova:
            return "/weapon_illust/8034dd1acde77c1a2df32197c12faa5ba1d65b43d008edd1b40f16fa8d106944_0.png"
        case .lunaBlaster:
            return "/weapon_illust/10d4a1584d1428cb164ddfbc5febc9b1e77fd05e2e9ed9de851838a94d202c15_0.png"
        case .blaster:
            return "/weapon_illust/29ccca01285a04f42dc15911f3cd1ee940f9ca0e94c75ba07378828afb3165c0_0.png"
        case .rangeBlaster:
            return "/weapon_illust/0d2963b386b6da598b8da1087eab3f48b99256e2e6a20fc8bbe53b34579fb338_0.png"
        case .clashBlaster:
            return "/weapon_illust/be8ba95bd3017a83876e7f769ee37ee459ee4b2d6eca03fceeb058c510adbb61_0.png"
        case .rapidBlaster:
            return "/weapon_illust/0a929d514403d07e1543e638141ebace947ffd539f5f766b42f4d6577d40d7b8_0.png"
        case .rapidBlasterPro:
            return "/weapon_illust/954a5ea059f841fa5f1cd2596bb32f23b3d3b03fc3fa7972077bdbafe6051215_0.png"
        case .l3Nozzlenose:
            return "/weapon_illust/96833fc0f74242cd2bc73b241aab8a00d499ce9f6557722ef6503e12af8979f4_0.png"
        case .h3Nozzlenose:
            return "/weapon_illust/418d75d9ca0304922f06eff539c511238b143ef8331969e20d54a9560df57d5a_0.png"
        case .squeezer:
            return "/weapon_illust/db9f2ff8fab9f74c05c7589d43f132eacbff94154dcc20e09c864fced36d4d95_0.png"
        case .carbonRoller:
            return "/weapon_illust/29358fd25b6ad1ba9e99f5721f0248af8bde7f1f757d00cbbc7a8a6be02a880d_0.png"
        case .splatRoller:
            return "/weapon_illust/536b28d9dd9fc6633a4bea4a141d63942a0ba3470fc504e5b0d02ee408798a87_0.png"
        case .dynamoRoller:
            return "/weapon_illust/18fdddee9c918842f076c10f12e46d891aca302d2677bf968ee2fe4e65b831a8_0.png"
        case .flingzaRoller:
            return "/weapon_illust/8351e99589f03f49b5d681d36b083aaffd9c486a0558ab957ac44b0db0bb58bb_0.png"
        case .bigSwigRoller:
            return "/weapon_illust/137559b59547c853e04c6cc8239cff648d2f6b297edb15d45504fae91dfc9765_0.png"
        case .inkbrush:
            return "/weapon_illust/260428edbf919f5c9e8c8517516d6a7a8133cf7348d216768ab4fb9434053f08_0.png"
        case .octobrush:
            return "/weapon_illust/ce0bb38588e497586a60f16e0aca914f181f42be29953742fd4a55a97e2ebd22_0.png"
        case .classicSquiffer:
            return "/weapon_illust/0cdd6036a6677d68bf28e1014b09a6f5a043e969027e532cd008049baace6527_0.png"
        case .splatCharger:
            return "/weapon_illust/3f99800b569e286305669b7ab28dc3ff0f0b1b015600569d5ac30ab8a97047a0_0.png"
        case .splatterscope:
            return "/weapon_illust/f6354a66c47ec15517bb457e3c48c97c3ff62d34ff38879dbb3e1665dea1be5a_0.png"
        case .eLiter4k:
            return "/weapon_illust/ed294b2c7b3111988d577d7efddb9e5e475efc5e0932e5416efedc41fd98eb04_0.png"
        case .eLiter4kScope:
            return "/weapon_illust/ebc007b2f27b0813f0c9ce7371bdab78c62e6a05777c928bf34222a79d99de8f_0.png"
        case .bamboozler14MkI:
            return "/weapon_illust/9c71334ea792864a00531040e0d05a183512e11277fd1fa681170874ba039268_0.png"
        case .gooTuber:
            return "/weapon_illust/2b349390a464710982d7e1496130898e7b5a66c301aa44fc9e19332d42e360ad_0.png"
        case .snipewriter5h:
            return "/weapon_illust/082489b182fbbabddde40831dac5867d6acc4778b6a38d8f5c8d445455d638eb_0.png"
        case .slosher:
            return "/weapon_illust/4a8bf6b4ad3b2942728bbd270bf64d5848b64f3c843a3b12ef83c0ebb5de1b3d_0.png"
        case .triSlosher:
            return "/weapon_illust/f3dbd98d5b0e89f7be7eff25a5c63a06045fe64d8ffd5886e79c855e16791563_0.png"
        case .sloshingMachine:
            return "/weapon_illust/bd2eca9a7b4109c1d96e804c74aaf2ca525011e1348d0b312fe4f034e35e5d4c_0.png"
        case .bloblobber:
            return "/weapon_illust/0199e455872acba1ab8ef0040eca7f41afca48c1f9ad2c5d274323d6dbc49133_0.png"
        case .explosher:
            return "/weapon_illust/1e32f5e1e65793585f6423e4fcae1a146a79d2a09e6e15575015af8a2032a4fe_0.png"
        case .miniSplatling:
            return "/weapon_illust/32dbc48e000d5d2015468e1dafc05e7c24581a73e54e758af0c8b9e2db3db550_0.png"
        case .heavySplatling:
            return "/weapon_illust/fd06f01742a3b25ac57941150b3b81d56633831902f2da1f19a6244f2d8dd6fd_0.png"
        case .hydraSplatling:
            return "/weapon_illust/34fe0401b6f6a0b09839696fc820ece9570a9d56e3a746b65f0604dec91a9920_0.png"
        case .ballpointSplatling:
            return "/weapon_illust/206dbf3b5dfc9962b6a783acf68a856f0c8fbf0c56257c2ca5c25d63198dd6e1_0.png"
        case .nautilus47:
            return "/weapon_illust/be4316928f4b031b470ec2cc2c48fb922a303c882802e32d7fa802249edaa212_0.png"
        case .dappleDualies:
            return "/weapon_illust/f1c8fc32bd90fc9258dc17e9f9bcfd5e6498f6e283709bf1896b78193b8e39e9_0.png"
        case .splatDualies:
            return "/weapon_illust/b43978029ea582de3aca34549cafd810df20082b94104634093392e11e30d9bd_0.png"
        case .gloogaDualies:
            return "/weapon_illust/802d3d501738c620b4f709203ccad343490bd3340b2fda21eb38a362320dc6ed_0.png"
        case .dualieSquelchers:
            return "/weapon_illust/b8f50833f99b0db251dc1812e5d13df09b393635b9b6bd684525112cbb38e5e4_0.png"
        case .darkTetraDualies:
            return "/weapon_illust/e68609e51d30dfb13e1ea996e46995ed1f7cf561caef0fe96314966d0a039109_0.png"
        case .splatBrella:
            return "/weapon_illust/15d101d0d11acbb8159e2701282879f2617d90c8573fd2f2239807721ff54ca4_0.png"
        case .tentaBrella:
            return "/weapon_illust/a7b1903741696c0ebeda76c9e16fa0a81ae4e37f5331ad6282fc2be1ae1c1c59_0.png"
        case .undercoverBrella:
            return "/weapon_illust/7508ba286e5ac5befe63daea807ab54996c3f0ef3577be9ab5d2827c49dedd75_0.png"
        case .triStringer:
            return "/weapon_illust/676d9f49276f171a93ac06646c0fbdfbeb8c3d0284a057aee306404a6034ffef_0.png"
        case .reefLux450:
            return "/weapon_illust/9baac6cc774d0e6f2ac8f6e217d700e6f1f47320130598c5f1e922210ccdcc89_0.png"
        case .splatanaStamper:
            return "/weapon_illust/ddd2a4258a70cdaf8a1dbc0ded024db497445d71f950fe7645fa8c69a178a082_0.png"
        case .splatanaWiper:
            return "/weapon_illust/3aa72d418643038a9e3248af734b0d6a0bf3d3bf9793d75912b1b959f93c2258_0.png"
        case .random:
            return "/ui_img/473fffb2442075078d8bb7125744905abdeae651b6a5b7453ae295582e45f7d1_0.png"
        case .randomGold:
            return "/ui_img/9d7272733ae2f2282938da17d69f13419a935eef42239132a02fcf37d8678f10_0.png"
        case .unknown:
            return Unknown.iconImage3
        }
    }
    private var thumbnail: String {
        switch self {
        case .splooshOMatic:
            return "/weapon_illust/6e58a0747ab899badcb6f351512c6034e0a49bd6453281f32c7f550a2132fd65_1.png"
        case .splattershotJr:
            return "/weapon_illust/8e134a80cd54f4235329493afd43ff754b367a65e460facfcca862b174754b0e_1.png"
        case .splashOMatic:
            return "/weapon_illust/25e98eaba1e17308db191b740d9b89e6a977bfcd37c8dc1d65883731c0c72609_1.png"
        case .aerosprayMg:
            return "/weapon_illust/5ec00bcf96c7a3f731d7a2e67f60f802f33d22f07177b94d5905f471b08b629f_1.png"
        case .splattershot:
            return "/weapon_illust/e3874d7d504acf89488ad7f68d29a348caea1a41cd43bd9a272069b0c0466570_1.png"
        case ._52Gal:
            return "/weapon_illust/01e8399a3c56707b6e9f7500d3d583ba1d400eec06449d8fe047cda1956a4ccc_1.png"
        case .nZap85:
            return "/weapon_illust/e6dbf73aa6ff9d1feb61fcabadb2d31e08b228a9736b4f5d8a5baeab9b493255_1.png"
        case .splattershotPro:
            return "/weapon_illust/5607f7014bbc7339feeb67218c05ef19c7a466152b1bd056a899b955127ea433_1.png"
        case ._96Gal:
            return "/weapon_illust/fe2b351799aa48fcb48154299ff0ccf0b0413fc291ffc49456e93db29d2f1db5_1.png"
        case .jetSquelcher:
            return "/weapon_illust/035920eb9428955c25aecb8a56c2b1b58f3e322af3657d921db1778de4b80c59_1.png"
        case .splattershotNova:
            return "/weapon_illust/8034dd1acde77c1a2df32197c12faa5ba1d65b43d008edd1b40f16fa8d106944_1.png"
        case .lunaBlaster:
            return "/weapon_illust/10d4a1584d1428cb164ddfbc5febc9b1e77fd05e2e9ed9de851838a94d202c15_1.png"
        case .blaster:
            return "/weapon_illust/29ccca01285a04f42dc15911f3cd1ee940f9ca0e94c75ba07378828afb3165c0_1.png"
        case .rangeBlaster:
            return "/weapon_illust/0d2963b386b6da598b8da1087eab3f48b99256e2e6a20fc8bbe53b34579fb338_1.png"
        case .clashBlaster:
            return "/weapon_illust/be8ba95bd3017a83876e7f769ee37ee459ee4b2d6eca03fceeb058c510adbb61_1.png"
        case .rapidBlaster:
            return "/weapon_illust/0a929d514403d07e1543e638141ebace947ffd539f5f766b42f4d6577d40d7b8_1.png"
        case .rapidBlasterPro:
            return "/weapon_illust/954a5ea059f841fa5f1cd2596bb32f23b3d3b03fc3fa7972077bdbafe6051215_1.png"
        case .l3Nozzlenose:
            return "/weapon_illust/96833fc0f74242cd2bc73b241aab8a00d499ce9f6557722ef6503e12af8979f4_1.png"
        case .h3Nozzlenose:
            return "/weapon_illust/418d75d9ca0304922f06eff539c511238b143ef8331969e20d54a9560df57d5a_1.png"
        case .squeezer:
            return "/weapon_illust/db9f2ff8fab9f74c05c7589d43f132eacbff94154dcc20e09c864fced36d4d95_1.png"
        case .carbonRoller:
            return "/weapon_illust/29358fd25b6ad1ba9e99f5721f0248af8bde7f1f757d00cbbc7a8a6be02a880d_1.png"
        case .splatRoller:
            return "/weapon_illust/536b28d9dd9fc6633a4bea4a141d63942a0ba3470fc504e5b0d02ee408798a87_1.png"
        case .dynamoRoller:
            return "/weapon_illust/18fdddee9c918842f076c10f12e46d891aca302d2677bf968ee2fe4e65b831a8_1.png"
        case .flingzaRoller:
            return "/weapon_illust/8351e99589f03f49b5d681d36b083aaffd9c486a0558ab957ac44b0db0bb58bb_1.png"
        case .bigSwigRoller:
            return "/weapon_illust/137559b59547c853e04c6cc8239cff648d2f6b297edb15d45504fae91dfc9765_1.png"
        case .inkbrush:
            return "/weapon_illust/260428edbf919f5c9e8c8517516d6a7a8133cf7348d216768ab4fb9434053f08_1.png"
        case .octobrush:
            return "/weapon_illust/ce0bb38588e497586a60f16e0aca914f181f42be29953742fd4a55a97e2ebd22_1.png"
        case .classicSquiffer:
            return "/weapon_illust/0cdd6036a6677d68bf28e1014b09a6f5a043e969027e532cd008049baace6527_1.png"
        case .splatCharger:
            return "/weapon_illust/3f99800b569e286305669b7ab28dc3ff0f0b1b015600569d5ac30ab8a97047a0_1.png"
        case .splatterscope:
            return "/weapon_illust/f6354a66c47ec15517bb457e3c48c97c3ff62d34ff38879dbb3e1665dea1be5a_1.png"
        case .eLiter4k:
            return "/weapon_illust/ed294b2c7b3111988d577d7efddb9e5e475efc5e0932e5416efedc41fd98eb04_1.png"
        case .eLiter4kScope:
            return "/weapon_illust/ebc007b2f27b0813f0c9ce7371bdab78c62e6a05777c928bf34222a79d99de8f_1.png"
        case .bamboozler14MkI:
            return "/weapon_illust/9c71334ea792864a00531040e0d05a183512e11277fd1fa681170874ba039268_1.png"
        case .gooTuber:
            return "/weapon_illust/2b349390a464710982d7e1496130898e7b5a66c301aa44fc9e19332d42e360ad_1.png"
        case .snipewriter5h:
            return "/weapon_illust/082489b182fbbabddde40831dac5867d6acc4778b6a38d8f5c8d445455d638eb_1.png"
        case .slosher:
            return "/weapon_illust/4a8bf6b4ad3b2942728bbd270bf64d5848b64f3c843a3b12ef83c0ebb5de1b3d_1.png"
        case .triSlosher:
            return "/weapon_illust/f3dbd98d5b0e89f7be7eff25a5c63a06045fe64d8ffd5886e79c855e16791563_1.png"
        case .sloshingMachine:
            return "/weapon_illust/bd2eca9a7b4109c1d96e804c74aaf2ca525011e1348d0b312fe4f034e35e5d4c_1.png"
        case .bloblobber:
            return "/weapon_illust/0199e455872acba1ab8ef0040eca7f41afca48c1f9ad2c5d274323d6dbc49133_1.png"
        case .explosher:
            return "/weapon_illust/1e32f5e1e65793585f6423e4fcae1a146a79d2a09e6e15575015af8a2032a4fe_1.png"
        case .miniSplatling:
            return "/weapon_illust/32dbc48e000d5d2015468e1dafc05e7c24581a73e54e758af0c8b9e2db3db550_1.png"
        case .heavySplatling:
            return "/weapon_illust/fd06f01742a3b25ac57941150b3b81d56633831902f2da1f19a6244f2d8dd6fd_1.png"
        case .hydraSplatling:
            return "/weapon_illust/34fe0401b6f6a0b09839696fc820ece9570a9d56e3a746b65f0604dec91a9920_1.png"
        case .ballpointSplatling:
            return "/weapon_illust/206dbf3b5dfc9962b6a783acf68a856f0c8fbf0c56257c2ca5c25d63198dd6e1_1.png"
        case .nautilus47:
            return "/weapon_illust/be4316928f4b031b470ec2cc2c48fb922a303c882802e32d7fa802249edaa212_1.png"
        case .dappleDualies:
            return "/weapon_illust/f1c8fc32bd90fc9258dc17e9f9bcfd5e6498f6e283709bf1896b78193b8e39e9_1.png"
        case .splatDualies:
            return "/weapon_illust/b43978029ea582de3aca34549cafd810df20082b94104634093392e11e30d9bd_1.png"
        case .gloogaDualies:
            return "/weapon_illust/802d3d501738c620b4f709203ccad343490bd3340b2fda21eb38a362320dc6ed_1.png"
        case .dualieSquelchers:
            return "/weapon_illust/b8f50833f99b0db251dc1812e5d13df09b393635b9b6bd684525112cbb38e5e4_1.png"
        case .darkTetraDualies:
            return "/weapon_illust/e68609e51d30dfb13e1ea996e46995ed1f7cf561caef0fe96314966d0a039109_1.png"
        case .splatBrella:
            return "/weapon_illust/15d101d0d11acbb8159e2701282879f2617d90c8573fd2f2239807721ff54ca4_1.png"
        case .tentaBrella:
            return "/weapon_illust/a7b1903741696c0ebeda76c9e16fa0a81ae4e37f5331ad6282fc2be1ae1c1c59_1.png"
        case .undercoverBrella:
            return "/weapon_illust/7508ba286e5ac5befe63daea807ab54996c3f0ef3577be9ab5d2827c49dedd75_1.png"
        case .triStringer:
            return "/weapon_illust/676d9f49276f171a93ac06646c0fbdfbeb8c3d0284a057aee306404a6034ffef_1.png"
        case .reefLux450:
            return "/weapon_illust/9baac6cc774d0e6f2ac8f6e217d700e6f1f47320130598c5f1e922210ccdcc89_1.png"
        case .splatanaStamper:
            return "/weapon_illust/ddd2a4258a70cdaf8a1dbc0ded024db497445d71f950fe7645fa8c69a178a082_1.png"
        case .splatanaWiper:
            return "/weapon_illust/3aa72d418643038a9e3248af734b0d6a0bf3d3bf9793d75912b1b959f93c2258_1.png"
        case .random:
            return "/ui_img/473fffb2442075078d8bb7125744905abdeae651b6a5b7453ae295582e45f7d1_0.png"
        case .randomGold:
            return "/ui_img/9d7272733ae2f2282938da17d69f13419a935eef42239132a02fcf37d8678f10_0.png"
        case .unknown:
            return Unknown.iconImage3
        }
    }
    
    var name: String {
        switch self {
        case .splooshOMatic:
            return "sploosh_o_matic"
        case .splattershotJr:
            return "splattershot_jr"
        case .splashOMatic:
            return "splash_o_matic"
        case .aerosprayMg:
            return "aerospray_mg"
        case .splattershot:
            return "splattershot"
        case ._52Gal:
            return "_52_gal"
        case .nZap85:
            return "n_zap_85"
        case .splattershotPro:
            return "splattershot_pro"
        case ._96Gal:
            return "_96_gal"
        case .jetSquelcher:
            return "jet_squelcher"
        case .splattershotNova:
            return "splattershot_nova"
        case .lunaBlaster:
            return "luna_blaster"
        case .blaster:
            return "blaster"
        case .rangeBlaster:
            return "range_blaster"
        case .clashBlaster:
            return "clash_blaster"
        case .rapidBlaster:
            return "rapid_blaster"
        case .rapidBlasterPro:
            return "rapid_blaster_pro"
        case .l3Nozzlenose:
            return "l_3_nozzlenose"
        case .h3Nozzlenose:
            return "h_3_nozzlenose"
        case .squeezer:
            return "squeezer"
        case .carbonRoller:
            return "carbon_roller"
        case .splatRoller:
            return "splat_roller"
        case .dynamoRoller:
            return "dynamo_roller"
        case .flingzaRoller:
            return "flingza_roller"
        case .bigSwigRoller:
            return "big_swig_roller"
        case .inkbrush:
            return "inkbrush"
        case .octobrush:
            return "octobrush"
        case .classicSquiffer:
            return "classic_squiffer"
        case .splatCharger:
            return "splat_charger"
        case .splatterscope:
            return "splatterscope"
        case .eLiter4k:
            return "e_liter_4k"
        case .eLiter4kScope:
            return "e_liter_4k_scope"
        case .bamboozler14MkI:
            return "bamboozler_14_mk_i"
        case .gooTuber:
            return "goo_tuber"
        case .snipewriter5h:
            return "snipewriter_5h"
        case .slosher:
            return "slosher"
        case .triSlosher:
            return "tri_slosher"
        case .sloshingMachine:
            return "sloshing_machine"
        case .bloblobber:
            return "bloblobber"
        case .explosher:
            return "explosher"
        case .miniSplatling:
            return "mini_splatling"
        case .heavySplatling:
            return "heavy_splatling"
        case .hydraSplatling:
            return "hydra_splatling"
        case .ballpointSplatling:
            return "ballpoint_splatling"
        case .nautilus47:
            return "nautilus_47"
        case .dappleDualies:
            return "dapple_dualies"
        case .splatDualies:
            return "splat_dualies"
        case .gloogaDualies:
            return "glooga_dualies"
        case .dualieSquelchers:
            return "dualie_squelchers"
        case .darkTetraDualies:
            return "dark_tetra_dualies"
        case .splatBrella:
            return "splat_brella"
        case .tentaBrella:
            return "tenta_brella"
        case .undercoverBrella:
            return "undercover_brella"
        case .triStringer:
            return "tri_stringer"
        case .reefLux450:
            return "reef_lux_450"
        case .splatanaStamper:
            return "splatana_stamper"
        case .splatanaWiper:
            return "splatana_wiper"
        case .random:
            return "random"
        case .randomGold:
            return "random2"
        case .unknown:
            return Unknown.name
        }
    }
    var imageUrl: String {
        switch self {
        case .unknown:
            return Unknown.iconImage3Url
        default:
            return Splatoon3InkAssetsURL + image
        }
    }
    var thumbnailUrl: String {
        switch self {
        case .unknown:
            return Unknown.iconImage3Url
        default:
            return Splatoon3InkAssetsURL + thumbnail
        }
    }
}
