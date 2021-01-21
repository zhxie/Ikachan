//
//  Date.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/17.
//

import Foundation
import SwiftUI

extension Date {
    static func -(left: Date, right: Date) -> TimeInterval {
        return left.timeIntervalSinceReferenceDate - right.timeIntervalSinceReferenceDate
    }
}

func timeSpan(startTime: Date, endTime: Date) -> String {
    let current = Date()
    
    if current > startTime {
        var elapsed = endTime - current
        if elapsed < 0 {
            elapsed = 0
        }
        
        return format2(interval: elapsed)
    } else {
        var elapsed = startTime - current
        if elapsed < 0 {
            elapsed = 0
        }
        
        return String(format: "-%@", format2(interval: elapsed))
    }
}

func naturalTimeSpan(startTime: Date, endTime: Date) -> String {
    let current = Date()
    
    if current > startTime {
        var elapsed = endTime - current
        if elapsed < 0 {
            elapsed = 0
        }
        
        return String(format: NSLocalizedString("%@_remaining", comment: ""), format(interval: elapsed))
    } else {
        var elapsed = startTime - current
        if elapsed < 0 {
            elapsed = 0
        }
        
        return String(format: NSLocalizedString("in_%@", comment: ""), format(interval: elapsed))
    }
}

func naturalTimeSpan2(startTime: Date, endTime: Date) -> (LocalizedStringKey, String) {
    let current = Date()
    
    if current > startTime {
        var elapsed = endTime - current
        if elapsed < 0 {
            elapsed = 0
        }
        
        return ("remaining", format2(interval: elapsed))
    } else {
        var elapsed = startTime - current
        if elapsed < 0 {
            elapsed = 0
        }
        
        return ("next", format2(interval: elapsed))
    }
}

func scheduleTimePeriod(startTime: Date, endTime: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    
    let startTime = dateFormatter.string(from: startTime)
    let endTime = dateFormatter.string(from: endTime)
    
    return String(format: "%@ - %@", startTime, endTime)
}

func shiftTimePeriod(startTime: Date, endTime: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "M/dd HH:mm"
    
    let startTime = dateFormatter.string(from: startTime)
    let endTime = dateFormatter.string(from: endTime)
    
    return String(format: "%@ - %@", startTime, endTime)
}

private func format(interval: TimeInterval) -> String {
    let mins = Int((interval / 60).rounded())
    
    let min = mins % 60
    let hour = (mins % 1440) / 60
    let day = mins / 1440
    
    var result = String(format: NSLocalizedString("%d_m", comment: ""), min)
    
    if hour > 0 {
        result = String(format: NSLocalizedString("%d_h_%@", comment: ""), hour, result)
    }
    
    if day > 0 {
        result = String(format: NSLocalizedString("%d_d_%@", comment: ""), day, result)
    }
    
    return result
}

private func format2(interval: TimeInterval) -> String {
    let mins = Int((interval / 60).rounded())
    
    let min = mins % 60
    let hour = (mins % 1440) / 60
    let day = mins / 1440
    
    if day > 0 || hour >= 10 {
        return String(format: "%dd%dh", day, hour)
    } else {
        if hour > 0 {
            return String(format: "%dh%dm", hour, min)
        } else {
            return String(format: "%dm", min)
        }
    }
}
