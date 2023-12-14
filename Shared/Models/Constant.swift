//
//  Constant.swift
//  Ikachan
//
//  Created by Sketch on 2023/12/11.
//

import Foundation

// Models.
let PreviewStage = Stage(name: "Shifty Station", image: URL(string: "https://app.splatoon2.nintendo.net/images/bundled/c25db34e168b45e36bbdbf156d421763.png")!)
let PreviewWeapon = Weapon(name: "Random", image: URL(string: "https://app.splatoon2.nintendo.net/images/coop_weapons/746f7e90bc151334f0bf0d2a1f0987e311b03736.png")!)
let PreviewSplatoon2Schedule = Splatoon2Schedule(startTime: Date(), endTime: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, mode: .regularBattle, rule: .turfWar, stages: [PreviewStage, PreviewStage])
let PreviewSplatoon2Shift = Splatoon2Shift(startTime: Date(), endTime: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, stage: PreviewStage, weapons: [PreviewWeapon, PreviewWeapon, PreviewWeapon, PreviewWeapon])
let PreviewSplatoon3Schedule = Splatoon3Schedule(startTime: Date(), endTime: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, mode: .regularBattle, rule: .turfWar, stages: [PreviewStage, PreviewStage], challenge: "New Season Challenge")
let PreviewSplatoon3Shift = Splatoon3Shift(startTime: Date(), endTime: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, mode: .salmonRun, stage: PreviewStage, weapons: [PreviewWeapon, PreviewWeapon, PreviewWeapon, PreviewWeapon], kingSalmonid: KingSalmonid(name: "Cohozuna", image: "cohozuna_3"))

// API.
let Splatnet2URL = "https://app.splatoon2.nintendo.net"
let Splatoon2InkURL = "https://splatoon2.ink"
let Splatoon2InkScheduleURL = Splatoon2InkURL + "/data/schedules.json"
let Splatoon2InkShiftURL = Splatoon2InkURL + "/data/coop-schedules.json"
let Splatoon2InkLocaleURL = Splatoon2InkURL + "/data/locale/%@.json"
let Splatoon3InkURL = "https://splatoon3.ink"
let Splatoon3InkAssetsURL = Splatoon3InkURL + "/assets/splatnet/v2"
let Splatoon3InkScheduleURL = Splatoon3InkURL + "/data/schedules.json"
let Splatoon3InkLocaleURL = Splatoon3InkURL + "/data/locale/%@.json"

let Timeout: Double = 60

// Intent.
let UserActivity = "name.sketch.Ikachan"

// Widget.
let MaxScheduleWidgetEntryCount = 6
let MaxShiftWidgetEntryCount = 1
