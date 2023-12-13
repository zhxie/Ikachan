//
//  Date.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/17.
//

import Foundation

extension Date {
    init(utc: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        self.init(timeIntervalSince1970: formatter.date(from: utc)!.timeIntervalSince1970)
    }
    
    static func -(left: Date, right: Date) -> TimeInterval {
        return left.timeIntervalSinceReferenceDate - right.timeIntervalSinceReferenceDate
    }
    
    func floorToMin() -> Date {
        let interval = self - Date(timeIntervalSince1970: 0)
        let secs = interval - interval.truncatingRemainder(dividingBy: 60)
        
        return Date(timeIntervalSince1970: secs)
    }
}

func timeSpan(start: Date, end: Date) -> String {
    let current = Date()
    let currentComponents = Calendar.current.dateComponents([.month, .day], from: current)
    let startComponents = Calendar.current.dateComponents([.month, .day], from: start)
    let endComponents = Calendar.current.dateComponents([.month, .day], from: end)
    
    let long = DateFormatter()
    long.dateFormat = "M/d HH:mm"
    let short = DateFormatter()
    short.dateFormat = "HH:mm"
    
    var startString = ""
    var endString = ""
    if startComponents.month == currentComponents.month && startComponents.day == currentComponents.day {
        startString = short.string(from: start)
    } else {
        startString = long.string(from: start)
    }
    if endComponents.month == startComponents.month && endComponents.day == startComponents.day {
        endString = short.string(from: end)
    } else {
        endString = long.string(from: end)
    }
    
    return String(format: "%@ - %@", startString, endString)
}

func absoluteTimeSpan(start: Date, end: Date) -> String {
    let startComponents = Calendar.current.dateComponents([.month, .day], from: start)
    let endComponents = Calendar.current.dateComponents([.month, .day], from: end)
    
    let long = DateFormatter()
    long.dateFormat = "M/d HH:mm"
    let short = DateFormatter()
    short.dateFormat = "HH:mm"
    
    var startString = long.string(from: start)
    var endString = ""
    if endComponents.month == startComponents.month && endComponents.day == startComponents.day {
        endString = short.string(from: end)
    } else {
        endString = long.string(from: end)
    }
    
    return String(format: "%@ - %@", startString, endString)
}
