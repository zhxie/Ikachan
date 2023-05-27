//
//  Constant.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/17.
//

import SwiftUI

let Splatnet2URL = "https://app.splatoon2.nintendo.net"
let Splatoon2InkURL = "https://splatoon2.ink"
let Splatoon2InkScheduleURL = Splatoon2InkURL + "/data/schedules.json"
let Splatoon2InkShiftURL = Splatoon2InkURL + "/data/coop-schedules.json"
let Splatoon3InkURL = "https://splatoon3.ink"
let Splatoon3InkAssetsURL = Splatoon3InkURL + "/assets/splatnet/v1"
let Splatoon3InkScheduleURL = Splatoon3InkURL + "/data/schedules.json"

struct Unknown {
    static let name = "unknown"
    static let assetImage2 = "unknown_2"
    static let assetImage3 = "unknown_3"
    static let iconImage2 = "/images/coop_weapons/746f7e90bc151334f0bf0d2a1f0987e311b03736.png"
    static let iconImage2Url = Splatnet2URL + iconImage2
    static let stageImage2 = "/images/bundled/c25db34e168b45e36bbdbf156d421763.png"
    static let stageImage2Url = Splatnet2URL + stageImage2
    static let iconImage3 = "/ui_img/473fffb2442075078d8bb7125744905abdeae651b6a5b7453ae295582e45f7d1_0.png"
    static let iconImage3Url = Splatoon3InkAssetsURL + iconImage3
    static let stageImage3 = "/stage_img/icon/high_resolution/59a42245071d692c58b9825886f89f95e092ae0aa83a46617fdb4cbcb2f5f2b8_0.png"
    static let stageImage3Url = Splatoon3InkAssetsURL + stageImage3
    static let stageThumbnail3 = "/stage_img/icon/low_resolution/59a42245071d692c58b9825886f89f95e092ae0aa83a46617fdb4cbcb2f5f2b8_1.png"
    static let stageThumbnail3Url = Splatoon3InkAssetsURL + stageThumbnail3
    static let weaponImage3 = "/ui_img/a23d035e2f37c502e85b6065ba777d93f42d6ca7017ed029baac6db512e3e17f_0.png"
    static let weaponImage3Url = Splatoon3InkAssetsURL + weaponImage3
}

let Timeout: Double = 60

let SchedulePlaceholder = Splatoon2Schedule(startTime: Date(timeIntervalSince1970: 0), endTime: Date(timeIntervalSince1970: 7200), mode: .regular, rule: .turfWar, stages: [.theReef, .musselforgeFitness])
let ShiftPlaceholder = Splatoon2Shift(startTime: Date(timeIntervalSince1970: 30672000), endTime: Date(timeIntervalSince1970: 30736800), stage: .spawningGrounds, weapons: [.random, .random, .random, .random])

let IkachanScheme = "ikachan"
let IkachanScheduleScheme = IkachanScheme + "://schedule/%@/%@"
let IkachanShiftScheme = IkachanScheme + "://shift/%@"
let IkachanActivity = "name.sketch.Ikachan"
let IkachanScheduleActivity = IkachanActivity + "/schedule/%@/%@"
let IkachanShiftActivity = IkachanActivity + "/shift/%@"

// Widget.
let MaxWidgetEntryCount = 30
