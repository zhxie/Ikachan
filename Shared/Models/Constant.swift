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
let Splatoon3InkAssetsURL = Splatoon3InkURL + "/assets/splatnet"
let Splatoon3InkScheduleURL = Splatoon3InkURL + "/data/schedules.json"

struct Unknown {
    static let name = "unknown"
    static let assetImage = "unknown"
    static let iconImage = "/images/coop_weapons/746f7e90bc151334f0bf0d2a1f0987e311b03736.png"
    static let iconImageUrl = Splatnet2URL + iconImage
    static let stageImage = "/images/bundled/c25db34e168b45e36bbdbf156d421763.png"
    static let stageImageUrl = Splatnet2URL + stageImage
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
