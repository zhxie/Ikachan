//
//  Date.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/17.
//

import Foundation

func timeDescription(startTime: Date, endTime: Date) -> String {
    let current = Date()
    
    if current > startTime {
        let (day, hour, min) = timeSpan(startTime: current, endTime: endTime)
        
        return String(format: "%@_remaining", formatTime(day: day, hour: hour, min: min))
    } else {
        let (day, hour, min) = timeSpan(startTime: current, endTime: startTime)
        
        return String(format: "in_%@", formatTime(day: day, hour: hour, min: min))
    }
}

func timeSpan(startTime: Date, endTime: Date) -> (Int, Int, Int) {
    let delta = Int(endTime.timeIntervalSinceReferenceDate - startTime.timeIntervalSinceReferenceDate)
    
    let day = delta / 86400
    let hour = (delta % 86400) / 3600
    let min = (delta % 3600) / 60
    
    if day < 0 || hour < 0 || min < 0 {
        return (0, 0, 0)
    }
    
    return (day, hour, min)
}

func formatTime(day: Int, hour: Int, min: Int) -> String {
    var result = String(format: "%d_m", min)
    
    if hour > 0 {
        result = String(format: "%d_h_%@", hour, result)
    }
    
    if day > 0 {
        result = String(format: "%d_d_%@", day, result)
    }
    
    return result
}
