//
//  Date.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/17.
//

import Foundation

extension Date {
    static func -(left: Date, right: Date) -> TimeInterval {
        return left.timeIntervalSinceReferenceDate - right.timeIntervalSinceReferenceDate
    }
}

func timeDescription(startTime: Date, endTime: Date) -> String {
    let current = Date()
    
    if current > startTime {
        var elapsed = endTime - current
        if elapsed < 0 {
            elapsed = 0
        }
        
        return String(format: "%@_remaining", format(interval: elapsed))
    } else {
        var elapsed = startTime - current
        if elapsed < 0 {
            elapsed = 0
        }
        
        return String(format: "in_%@", format(interval: startTime - current))
    }
}

private func format(interval: TimeInterval) -> String {
    let mins = Int((interval / 60).rounded())
    
    let min = mins % 60
    let hour = (mins % 1440) / 60
    let day = mins / 1440
    
    var result = String(format: "%d_m", min)
    
    if hour > 0 {
        result = String(format: "%d_h_%@", hour, result)
    }
    
    if day > 0 {
        result = String(format: "%d_d_%@", day, result)
    }
    
    return result
}
