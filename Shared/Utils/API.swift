//
//  Splatoon2Ink.swift
//  Ikachan
//
//  Created by Sketch on 2021/2/5.
//

import UIKit
import Intents
import SwiftyJSON

enum Error {
    case NoError
    case RequestFailed
    case NonSuccessfulResponse
    case ParseFailed
    
    var name: String {
        switch self {
        case .NoError:
            return "no_error"
        case .RequestFailed:
            return "request_failed"
        case .NonSuccessfulResponse:
            return "non_successful_response"
        case .ParseFailed:
            return "parse_failed"
        }
    }
}

private func fetchSplatoon2Schedules(locale: JSON, completion: @escaping ([Splatoon2Schedule], Error) -> Void) {
    do {
        var request = URLRequest(url: URL(string: Splatoon2InkScheduleURL)!)
        request.timeoutInterval = Timeout
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion([], .RequestFailed)
            } else {
                let response = response as! HTTPURLResponse
                let status = response.statusCode
                guard (200...299).contains(status) else {
                    completion([], .NonSuccessfulResponse)
                    
                    return
                }
                
                if let json = try? JSON(data: data!) {
                    var schedules: [Splatoon2Schedule] = []
                    for (_, value) in json {
                        for schedule in value.arrayValue {
                            let startTime = Date(timeIntervalSince1970: schedule["start_time"].doubleValue)
                            let endTime = Date(timeIntervalSince1970: schedule["end_time"].doubleValue)
                            let mode = Splatoon2ScheduleMode.allCases.first { mode in
                                mode.key == schedule["game_mode"]["key"].stringValue
                            }!
                            let rule = Splatoon2Rule(rawValue: schedule["rule"]["key"].stringValue)!
                            let stages = [Stage(name: locale["stages"][schedule["stage_a"]["id"].stringValue]["name"].stringValue, image: URL(string: Splatnet2URL + schedule["stage_a"]["image"].stringValue)!), Stage(name: locale["stages"][schedule["stage_b"]["id"].stringValue]["name"].stringValue, image: URL(string: Splatnet2URL + schedule["stage_b"]["image"].stringValue)!)]
                            schedules.append(Splatoon2Schedule(startTime: startTime, endTime: endTime, mode: mode, rule: rule, stages: stages))
                        }
                    }
                    
                    completion(schedules, .NoError)
                } else {
                    completion([], .ParseFailed)
                }
            }
        }
        .resume()
    }
}
private func fetchSplatoon2Shifts(locale: JSON, completion: @escaping ([Splatoon2Shift], Error) -> Void) {
    do {
        var request = URLRequest(url: URL(string: Splatoon2InkShiftURL)!)
        request.timeoutInterval = Timeout
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion([], .RequestFailed)
            } else {
                let response = response as! HTTPURLResponse
                let status = response.statusCode
                guard (200...299).contains(status) else {
                    completion([], .NonSuccessfulResponse)
                    
                    return
                }
                
                if let json = try? JSON(data: data!) {
                    var previousTime = Date(timeIntervalSince1970: 0)
                    var shifts: [Splatoon2Shift] = []
                    for shift in json["details"].arrayValue {
                        let startTime = Date(timeIntervalSince1970: shift["start_time"].doubleValue)
                        if startTime <= previousTime {
                            continue
                        }
                        let endTime = Date(timeIntervalSince1970: shift["end_time"].doubleValue)
                        let stage = Stage(name: locale["coop_stages"][shift["stage"]["image"].stringValue]["name"].stringValue, image: URL(string: Splatnet2URL + shift["stage"]["image"].stringValue)!)
                        var weapons: [Weapon] = []
                        for weapon in shift["weapons"].arrayValue {
                            if Int(weapon["id"].stringValue)! < 0 {
                                weapons.append(Weapon(name: locale["coop_special_weapons"][weapon["coop_special_weapon"]["image"].stringValue]["name"].stringValue, image: URL(string: Splatnet2URL + weapon["coop_special_weapon"]["image"].stringValue)!))
                            } else {
                                weapons.append(Weapon(name: locale["weapons"][weapon["id"].stringValue]["name"].stringValue, image: URL(string: Splatnet2URL + weapon["weapon"]["image"].stringValue)!, thumbnail: URL(string: Splatnet2URL + weapon["weapon"]["thumbnail"].stringValue)!))
                            }
                        }
                        shifts.append(Splatoon2Shift(startTime: startTime, endTime: endTime, stage: stage, weapons: weapons))
                        previousTime = startTime
                    }
                    for shift in json["schedules"].arrayValue {
                        let startTime = Date(timeIntervalSince1970: shift["start_time"].doubleValue)
                        if startTime <= previousTime {
                            continue
                        }
                        let endTime = Date(timeIntervalSince1970: shift["end_time"].doubleValue)
                        shifts.append(Splatoon2Shift(startTime: startTime, endTime: endTime))
                        previousTime = startTime
                    }
                    
                    completion(shifts, .NoError)
                } else {
                    completion([], .ParseFailed)
                }
            }
        }
        .resume()
    }
}
private func fetchSplatoon3Schedules(locale: JSON, completion: @escaping ([Splatoon3Schedule], Error) -> Void) {
    do {
        var request = URLRequest(url: URL(string: Splatoon3InkScheduleURL)!)
        request.timeoutInterval = Timeout
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion([], .RequestFailed)
            } else {
                let response = response as! HTTPURLResponse
                let status = response.statusCode
                guard (200...299).contains(status) else {
                    completion([], .NonSuccessfulResponse)
                    
                    return
                }
                
                if let json = try? JSON(data: data!) {
                    var schedules: [Splatoon3Schedule] = []
                    let innerData = json["data"]
                    for schedule in innerData["regularSchedules"]["nodes"].arrayValue {
                        let startTime = Date(utc: schedule["startTime"].stringValue)
                        let endTime = Date(utc: schedule["endTime"].stringValue)
                        let matchSetting = schedule["regularMatchSetting"]
                        if matchSetting.isNull {
                            continue
                        }
                        let rule = Splatoon3Rule.allCases.first { rule in
                            rule.key == matchSetting["vsRule"]["rule"].stringValue.lowercased()
                        }!
                        var stages: [Stage] = []
                        for stage in matchSetting["vsStages"].arrayValue {
                            stages.append(Stage(name: locale["stages"][stage["id"].stringValue]["name"].stringValue, image: URL(string: stage["image"]["url"].stringValue.replacingOccurrences(of: "low_", with: "high_").replacingOccurrences(of: "_1", with: "_0"))!, thumbnail: URL(string: stage["image"]["url"].stringValue)!))
                        }
                        schedules.append(Splatoon3Schedule(startTime: startTime, endTime: endTime, mode: Splatoon3ScheduleMode.regularBattle, rule: rule, stages: stages))
                    }
                    for schedule in innerData["bankaraSchedules"]["nodes"].arrayValue {
                        let startTime = Date(utc: schedule["startTime"].stringValue)
                        let endTime = Date(utc: schedule["endTime"].stringValue)
                        for matchSetting in schedule["bankaraMatchSettings"].arrayValue {
                            if matchSetting.isNull {
                                continue
                            }
                            let mode = Splatoon3ScheduleMode.allCases.first { mode in
                                mode.anarchyKey == matchSetting["bankaraMode"].stringValue.lowercased()
                            }!
                            let rule = Splatoon3Rule.allCases.first { rule in
                                rule.key == matchSetting["vsRule"]["rule"].stringValue.lowercased()
                            }!
                            var stages: [Stage] = []
                            for stage in matchSetting["vsStages"].arrayValue {
                                stages.append(Stage(name: locale["stages"][stage["id"].stringValue]["name"].stringValue, image: URL(string: stage["image"]["url"].stringValue.replacingOccurrences(of: "low_", with: "high_").replacingOccurrences(of: "_1", with: "_0"))!, thumbnail: URL(string: stage["image"]["url"].stringValue)!))
                            }
                            schedules.append(Splatoon3Schedule(startTime: startTime, endTime: endTime, mode: mode, rule: rule, stages: stages))
                        }
                    }
                    for schedule in innerData["xSchedules"]["nodes"].arrayValue {
                        let startTime = Date(utc: schedule["startTime"].stringValue)
                        let endTime = Date(utc: schedule["endTime"].stringValue)
                        let matchSetting = schedule["xMatchSetting"]
                        if matchSetting.isNull {
                            continue
                        }
                        let rule = Splatoon3Rule.allCases.first { rule in
                            rule.key == matchSetting["vsRule"]["rule"].stringValue.lowercased()
                        }!
                        var stages: [Stage] = []
                        for stage in matchSetting["vsStages"].arrayValue {
                            stages.append(Stage(name: locale["stages"][stage["id"].stringValue]["name"].stringValue, image: URL(string: stage["image"]["url"].stringValue.replacingOccurrences(of: "low_", with: "high_").replacingOccurrences(of: "_1", with: "_0"))!, thumbnail: URL(string: stage["image"]["url"].stringValue)!))
                        }
                        schedules.append(Splatoon3Schedule(startTime: startTime, endTime: endTime, mode: Splatoon3ScheduleMode.xBattle, rule: rule, stages: stages))
                    }
                    for schedule in innerData["eventSchedules"]["nodes"].arrayValue {
                        let matchSetting = schedule["leagueMatchSetting"]
                        if matchSetting.isNull {
                            continue
                        }
                        let rule = Splatoon3Rule.allCases.first { rule in
                            rule.key == matchSetting["vsRule"]["rule"].stringValue.lowercased()
                        }!
                        var stages: [Stage] = []
                        for stage in matchSetting["vsStages"].arrayValue {
                            stages.append(Stage(name: locale["stages"][stage["id"].stringValue]["name"].stringValue, image: URL(string: stage["image"]["url"].stringValue.replacingOccurrences(of: "low_", with: "high_").replacingOccurrences(of: "_1", with: "_0"))!, thumbnail: URL(string: stage["image"]["url"].stringValue)!))
                        }
                        let challenge = locale["events"][matchSetting["leagueMatchEvent"]["id"].stringValue]["name"].stringValue
                        for timePeriod in schedule["timePeriods"].arrayValue {
                            let startTime = Date(utc: timePeriod["startTime"].stringValue)
                            let endTime = Date(utc: timePeriod["endTime"].stringValue)
                            schedules.append(Splatoon3Schedule(startTime: startTime, endTime: endTime, mode: Splatoon3ScheduleMode.challenges, rule: rule, stages: stages, challenge: challenge))
                        }
                    }
                    for schedule in innerData["festSchedules"]["nodes"].arrayValue {
                        let startTime = Date(utc: schedule["startTime"].stringValue)
                        let endTime = Date(utc: schedule["endTime"].stringValue)
                        for matchSetting in schedule["festMatchSettings"].arrayValue {
                            if matchSetting.isNull {
                                continue
                            }
                            let mode = Splatoon3ScheduleMode.allCases.first { mode in
                                mode.splatfestKey == matchSetting["festMode"].stringValue.lowercased()
                            }!
                            let rule = Splatoon3Rule.allCases.first { rule in
                                rule.key == matchSetting["vsRule"]["rule"].stringValue.lowercased()
                            }!
                            var stages: [Stage] = []
                            for stage in matchSetting["vsStages"].arrayValue {
                                stages.append(Stage(name: locale["stages"][stage["id"].stringValue]["name"].stringValue, image: URL(string: stage["image"]["url"].stringValue.replacingOccurrences(of: "low_", with: "high_").replacingOccurrences(of: "_1", with: "_0"))!, thumbnail: URL(string: stage["image"]["url"].stringValue)!))
                            }
                            schedules.append(Splatoon3Schedule(startTime: startTime, endTime: endTime, mode: mode, rule: rule, stages: stages))
                        }
                    }
                    
                    let splatfest = innerData["currentFest"]
                    if !splatfest.isNull {
                        let startTime = Date(utc: splatfest["midtermTime"].stringValue)
                        let endTime = Date(utc: splatfest["endTime"].stringValue)
                        let stage = Stage(name: locale["stages"][splatfest["tricolorStage"]["id"].stringValue]["name"].stringValue, image: URL(string: splatfest["tricolorStage"]["image"]["url"].stringValue)!)
                        schedules.append(Splatoon3Schedule(startTime: startTime, endTime: endTime, mode: Splatoon3ScheduleMode.tricolorBattle, rule: Splatoon3Rule.tricolorTurfWar, stages: [stage]))
                    }

                    schedules.sort { a, b in
                        a.startTime < b.startTime
                    }
                    completion(schedules, .NoError)
                } else {
                    completion([], .ParseFailed)
                }
            }
        }
        .resume()
    }
}
private func fetchSplatoon3Shifts(locale: JSON, completion: @escaping ([Splatoon3Shift], Error) -> Void) {
    do {
        var request = URLRequest(url: URL(string: Splatoon3InkScheduleURL)!)
        request.timeoutInterval = Timeout
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion([], .RequestFailed)
            } else {
                let response = response as! HTTPURLResponse
                let status = response.statusCode
                guard (200...299).contains(status) else {
                    completion([], .NonSuccessfulResponse)
                    
                    return
                }
                
                if let json = try? JSON(data: data!) {
                    var shifts: [Splatoon3Shift] = []
                    let innerData = json["data"]["coopGroupingSchedule"]
                    for shift in innerData["regularSchedules"]["nodes"].arrayValue {
                        let startTime = Date(utc: shift["startTime"].stringValue)
                        let endTime = Date(utc: shift["endTime"].stringValue)
                        let setting = shift["setting"]
                        let stage = Stage(name: locale["stages"][setting["coopStage"]["id"].stringValue]["name"].stringValue, image: URL(string: setting["coopStage"]["image"]["url"].stringValue)!, thumbnail: URL(string: setting["coopStage"]["thumbnailImage"]["url"].stringValue)!)
                        var weapons: [Weapon] = []
                        for weapon in setting["weapons"].arrayValue {
                            weapons.append(Weapon(name: locale["weapons"][weapon["__splatoon3ink_id"].stringValue]["name"].stringValue, image: URL(string: weapon["image"]["url"].stringValue)!, thumbnail: URL(string: weapon["image"]["url"].stringValue.replacingOccurrences(of: "_0", with: "_1"))!))
                        }
                        let kingSalmonid = locale["bosses"][setting["boss"]["id"].stringValue]["name"].stringValue
                        shifts.append(Splatoon3Shift(startTime: startTime, endTime: endTime, mode: Splatoon3ShiftMode.salmonRun, stage: stage, weapons: weapons, kingSalmonid: kingSalmonid))
                    }
                    for shift in innerData["bigRunSchedules"]["nodes"].arrayValue {
                        let startTime = Date(utc: shift["startTime"].stringValue)
                        let endTime = Date(utc: shift["endTime"].stringValue)
                        let setting = shift["setting"]
                        let stage = Stage(name: locale["stages"][setting["coopStage"]["id"].stringValue]["name"].stringValue, image: URL(string: setting["coopStage"]["image"]["url"].stringValue)!, thumbnail: URL(string: setting["coopStage"]["thumbnailImage"]["url"].stringValue)!)
                        var weapons: [Weapon] = []
                        for weapon in setting["weapons"].arrayValue {
                            weapons.append(Weapon(name: locale["weapons"][weapon["__splatoon3ink_id"].stringValue]["name"].stringValue, image: URL(string: weapon["image"]["url"].stringValue)!, thumbnail: URL(string: weapon["image"]["url"].stringValue.replacingOccurrences(of: "_0", with: "_1"))!))
                        }
                        let kingSalmonid = locale["bosses"][setting["boss"]["id"].stringValue]["name"].stringValue
                        shifts.append(Splatoon3Shift(startTime: startTime, endTime: endTime, mode: Splatoon3ShiftMode.bigRun, stage: stage, weapons: weapons, kingSalmonid: kingSalmonid))
                    }
                    for shift in innerData["teamContestSchedules"]["nodes"].arrayValue {
                        let startTime = Date(utc: shift["startTime"].stringValue)
                        let endTime = Date(utc: shift["endTime"].stringValue)
                        let setting = shift["setting"]
                        let stage = Stage(name: locale["stages"][setting["coopStage"]["id"].stringValue]["name"].stringValue, image: URL(string: setting["coopStage"]["image"]["url"].stringValue)!, thumbnail: URL(string: setting["coopStage"]["thumbnailImage"]["url"].stringValue)!)
                        var weapons: [Weapon] = []
                        for weapon in setting["weapons"].arrayValue {
                            weapons.append(Weapon(name: locale["weapons"][weapon["__splatoon3ink_id"].stringValue]["name"].stringValue, image: URL(string: weapon["image"]["url"].stringValue)!, thumbnail: URL(string: weapon["image"]["url"].stringValue.replacingOccurrences(of: "_0", with: "_1"))!))
                        }
                        shifts.append(Splatoon3Shift(startTime: startTime, endTime: endTime, mode: Splatoon3ShiftMode.bigRun, stage: stage, weapons: weapons))
                    }
                    
                    shifts.sort { a, b in
                        a.startTime < b.startTime
                    }
                    completion(shifts, .NoError)
                } else {
                    completion([], .ParseFailed)
                }
            }
        }
        .resume()
    }
}

enum Locale: String, CaseIterable {
    case japanese = "japanese"
    case english = "english"
    case chineseSimplified = "chinese_simplified"
    
    var splatoon2LanguageCode: String {
        switch self {
        case .japanese:
            return "ja"
        case .english:
            return "en"
        case .chineseSimplified:
            return "zh-CN"
        }
    }
    var splatoon2UseLocaleFile: Bool {
        switch self {
        case .japanese, .english:
            return false
        case .chineseSimplified:
            return true
        }
    }
    var splatoon3LanguageCode: String {
        switch self {
        case .japanese:
            return "ja-JP"
        case .english:
            return "en-US"
        case .chineseSimplified:
            return "zh-CN"
        }
    }
    
    static var localizedLocale: Locale {
        let languageCode = NSLocale.preferredLanguages[0]
        return translateLanguageCode(languageCode: languageCode)
    }
    static var localizedIntentsLocale: Locale {
        let languageCode = INPreferences.siriLanguageCode()
        return translateLanguageCode(languageCode: languageCode)
    }
}

private func translateLanguageCode(languageCode: String) -> Locale {
    if languageCode.starts(with: "en") {
        return .english
    } else if languageCode.starts(with: "ja") {
        return .japanese
    } else if languageCode.starts(with: "zh") {
        return .chineseSimplified
    } else {
        return .english
    }
}

func fetchSplatoon2Schedules(locale: Locale, completion: @escaping ([Splatoon2Schedule], Error) -> Void) {
    do {
        if locale.splatoon2UseLocaleFile {
            if let asset = NSDataAsset(name: String(format: "splatoon_2_locale_%@", locale.splatoon2LanguageCode), bundle: Bundle.main) {
                if let json = try? JSON(data: asset.data) {
                    fetchSplatoon2Schedules(locale: json, completion: completion)
                    
                    return
                }
            }
        }
        
        var request = URLRequest(url: URL(string: String(format: Splatoon2InkLocaleURL, locale.splatoon2LanguageCode))!)
        request.timeoutInterval = Timeout
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion([], .RequestFailed)
            } else {
                let response = response as! HTTPURLResponse
                let status = response.statusCode
                guard (200...299).contains(status) else {
                    completion([], .NonSuccessfulResponse)
                    
                    return
                }
                
                if let json = try? JSON(data: data!) {
                    fetchSplatoon2Schedules(locale: json, completion: completion)
                } else {
                    completion([], .ParseFailed)
                }
            }
        }
        .resume()
    }
}
func fetchSplatoon2Shifts(locale: Locale, completion: @escaping ([Splatoon2Shift], Error) -> Void) {
    do {
        if locale.splatoon2UseLocaleFile {
            if let asset = NSDataAsset(name: String(format: "splatoon_2_locale_%@", locale.splatoon2LanguageCode), bundle: Bundle.main) {
                if let json = try? JSON(data: asset.data) {
                    fetchSplatoon2Shifts(locale: json, completion: completion)
                    
                    return
                }
            }
        }
        
        var request = URLRequest(url: URL(string: String(format: Splatoon2InkLocaleURL, locale.splatoon2LanguageCode))!)
        request.timeoutInterval = Timeout
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion([], .RequestFailed)
            } else {
                let response = response as! HTTPURLResponse
                let status = response.statusCode
                guard (200...299).contains(status) else {
                    completion([], .NonSuccessfulResponse)
                    
                    return
                }
                
                if let json = try? JSON(data: data!) {
                    fetchSplatoon2Shifts(locale: json, completion: completion)
                } else {
                    completion([], .ParseFailed)
                }
            }
        }
        .resume()
    }
}
func fetchSplatoon3Schedules(locale: Locale, completion: @escaping ([Splatoon3Schedule], Error) -> Void) {
    do {
        var request = URLRequest(url: URL(string: String(format: Splatoon3InkLocaleURL, locale.splatoon3LanguageCode))!)
        request.timeoutInterval = Timeout
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion([], .RequestFailed)
            } else {
                let response = response as! HTTPURLResponse
                let status = response.statusCode
                guard (200...299).contains(status) else {
                    completion([], .NonSuccessfulResponse)
                    
                    return
                }
                
                if let json = try? JSON(data: data!) {
                    fetchSplatoon3Schedules(locale: json, completion: completion)
                } else {
                    completion([], .ParseFailed)
                }
            }
        }
        .resume()
    }
}
func fetchSplatoon3Shifts(locale: Locale, completion: @escaping ([Splatoon3Shift], Error) -> Void) {
    do {
        var request = URLRequest(url: URL(string: String(format: Splatoon3InkLocaleURL, locale.splatoon3LanguageCode))!)
        request.timeoutInterval = Timeout
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion([], .RequestFailed)
            } else {
                let response = response as! HTTPURLResponse
                let status = response.statusCode
                guard (200...299).contains(status) else {
                    completion([], .NonSuccessfulResponse)
                    
                    return
                }
                
                if let json = try? JSON(data: data!) {
                    fetchSplatoon3Shifts(locale: json, completion: completion)
                } else {
                    completion([], .ParseFailed)
                }
            }
        }
        .resume()
    }
}

func fetchSplatoon2(locale: Locale, completion: @escaping ([Splatoon2Schedule], [Splatoon2Shift], Error) -> Void) {
    do {
        if locale.splatoon2UseLocaleFile {
            if let asset = NSDataAsset(name: String(format: "splatoon_2_locale_%@", locale.splatoon2LanguageCode), bundle: Bundle.main) {
                if let json = try? JSON(data: asset.data) {
                    fetchSplatoon2Schedules(locale: json) { schedules, error in
                        guard error == .NoError else {
                            completion([], [], error)
                            
                            return
                        }
                        
                        fetchSplatoon2Shifts(locale: json) { shifts, error in
                            guard error == .NoError else {
                                completion([], [], error)
                                
                                return
                            }
                            
                            completion(schedules, shifts, error)
                        }
                    }
                    
                    return
                }
            }
        }
        
        var request = URLRequest(url: URL(string: String(format: Splatoon2InkLocaleURL, locale.splatoon2LanguageCode))!)
        request.timeoutInterval = Timeout
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion([], [], .RequestFailed)
            } else {
                let response = response as! HTTPURLResponse
                let status = response.statusCode
                guard (200...299).contains(status) else {
                    completion([], [], .NonSuccessfulResponse)
                    
                    return
                }
                
                if let json = try? JSON(data: data!) {
                    fetchSplatoon2Schedules(locale: json) { schedules, error in
                        guard error == .NoError else {
                            completion([], [], error)
                            
                            return
                        }
                        
                        fetchSplatoon2Shifts(locale: json) { shifts, error in
                            guard error == .NoError else {
                                completion([], [], error)
                                
                                return
                            }
                            
                            completion(schedules, shifts, error)
                        }
                    }
                } else {
                    completion([], [], .ParseFailed)
                }
            }
        }
        .resume()
    }
}
func fetchSplatoon3(locale: Locale, completion: @escaping ([Splatoon3Schedule], [Splatoon3Shift], Error) -> Void) {
    do {
        var request = URLRequest(url: URL(string: String(format: Splatoon3InkLocaleURL, locale.splatoon3LanguageCode))!)
        request.timeoutInterval = Timeout
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion([], [], .RequestFailed)
            } else {
                let response = response as! HTTPURLResponse
                let status = response.statusCode
                guard (200...299).contains(status) else {
                    completion([], [], .NonSuccessfulResponse)
                    
                    return
                }
                
                if let json = try? JSON(data: data!) {
                    fetchSplatoon3Schedules(locale: json) { schedules, error in
                        guard error == .NoError else {
                            completion([], [], error)
                            
                            return
                        }
                        
                        fetchSplatoon3Shifts(locale: json) { shifts, error in
                            guard error == .NoError else {
                                completion([], [], error)
                                
                                return
                            }
                            
                            completion(schedules, shifts, error)
                        }
                    }
                } else {
                    completion([], [], .ParseFailed)
                }
            }
        }
        .resume()
    }
}
