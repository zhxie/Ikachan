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
    
    func floorToMin() -> Date {
        let interval = self - Date(timeIntervalSince1970: 0)
        let secs = interval - interval.truncatingRemainder(dividingBy: 60)
        
        return Date(timeIntervalSince1970: secs)
    }
}

func timeSpan(current: Date, startTime: Date, endTime: Date) -> String {
    if current >= startTime {
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
        
        if elapsed == 0 {
            return format2(interval: elapsed)
        } else {
            return String(format: "-%@", format2(interval: elapsed))
        }
    }
}

func absoluteTimeSpan(current: Date, startTime: Date, endTime: Date) -> String {
    if current >= startTime {
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
        
        return format2(interval: elapsed)
    }
}

func absoluteLongIntentsTimeSpan(current: Date, startTime: Date, endTime: Date) -> String {
    if current >= startTime {
        var elapsed = endTime - current
        if elapsed < 0 {
            elapsed = 0
        }
        
        return format3(interval: elapsed)
    } else {
        var elapsed = startTime - current
        if elapsed < 0 {
            elapsed = 0
        }
        
        return format3(interval: elapsed)
    }
}

func timeSpanDescriptor(current: Date, startTime: Date) -> LocalizedStringKey {
    if current >= startTime {
        return "remaining"
    } else {
        return "next"
    }
}

func naturalTimeSpan(startTime: Date, endTime: Date) -> String {
    let current = Date()
    
    if current >= startTime {
        var elapsed = endTime - current
        if elapsed < 0 {
            elapsed = 0
        }
        
        return String(format: "%@_remaining".localizedString, format(interval: elapsed))
    } else {
        var elapsed = startTime - current
        if elapsed < 0 {
            elapsed = 0
        }
        
        return String(format: "in_%@".localizedString, format(interval: elapsed))
    }
}

func scheduleTimePeriod(startTime: Date, endTime: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    
    let startTime = dateFormatter.string(from: startTime)
    let endTime = dateFormatter.string(from: endTime)
    
    return String(format: "%@ - %@", startTime, endTime)
}

func scheduleTimePeriod2(startTime: Date, endTime: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    
    let startTime = dateFormatter.string(from: startTime)
    let endTime = dateFormatter.string(from: endTime)
    
    return String(format: "%@-%@", startTime, endTime)
}

func shiftTimePeriod(startTime: Date, endTime: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "M/d HH:mm"
    
    let startTime = dateFormatter.string(from: startTime)
    let endTime = dateFormatter.string(from: endTime)
    
    return String(format: "%@ - %@", startTime, endTime)
}

func shiftTimePeriod2(startTime: Date, endTime: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "M/d HH:mm"
    
    let startTime = dateFormatter.string(from: startTime)
    let endTime = dateFormatter.string(from: endTime)
    
    return String(format: "%@-%@", startTime, endTime)
}

private func format(interval: TimeInterval) -> String {
    let mins = Int((interval / 60).rounded())
    
    let min = mins % 60
    let hour = (mins % 1440) / 60
    let day = mins / 1440
    
    var results: [String] = []
    
    if day > 0 {
        results.append(String(format: "%dd".localizedString, day))
    }
    if hour > 0 {
        results.append(String(format: "%dh".localizedString, hour))
    }
    if min > 0 {
        results.append(String(format: "%dm".localizedString, min))
    }
    if results.isEmpty {
        results.append("0m".localizedString)
    }
    
    return results.concate(delimiter: "_".localizedString)
}

private func format2(interval: TimeInterval) -> String {
    let mins = Int((interval / 60).rounded())
    
    let min = mins % 60
    let hour = (mins % 1440) / 60
    let day = mins / 1440
    
    if day > 0 || hour >= 10 {
        if day >= 10 {
            return String(format: "%dd+", day)
        } else if day > 0 {
            if hour > 0 {
                return String(format: "%dd%dh+", day, hour)
            } else {
                return String(format: "%dd+", day)
            }
        } else {
            return String(format: "%dh+", hour)
        }
    } else {
        if hour > 0 {
            if min > 0 {
                return String(format: "%dh%dm", hour, min)
            } else {
                return String(format: "%dh", hour)
            }
        } else {
            return String(format: "%dm", min)
        }
    }
}

private func format3(interval: TimeInterval) -> String {
    let mins = Int((interval / 60).rounded())
    
    let min = mins % 60
    let hour = (mins % 1440) / 60
    let day = mins / 1440
    
    var results: [String] = []
    
    if day > 1 {
        results.append(String(format: "%d_days".localizedIntentsString, day))
    } else if day > 0 {
        results.append(String(format: "%d_day".localizedIntentsString, day))
    }
    if hour > 1 {
        results.append(String(format: "%d_hours".localizedIntentsString, hour))
    } else if hour > 0 {
        results.append(String(format: "%d_hour".localizedIntentsString, hour))
    }
    if min > 1 {
        results.append(String(format: "%d_mins".localizedIntentsString, min))
    } else if min > 0 {
        results.append(String(format: "%d_min".localizedIntentsString, min))
    }
    if results.isEmpty {
        results.append("0_min".localizedIntentsString)
    }
    
    return results.concate(delimiter: "_".localizedString)
}
