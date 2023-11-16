//
//  AppDelegate.swift
//  ThreadUsage
//
//  Created by BEKIR TEK on 16.11.2023.
//

import Foundation

public class Helper {
    
    public class func getCurrentTime() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "m:ss.SS"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    public class func calculateTimeInterval(start: Date?, end: Date?) -> String {
        guard let start, let end else { return "nil value detected" }
        let timeInterval = end.timeIntervalSince(start)
        let minutes = Int(timeInterval / 60)
        let seconds = Int(timeInterval.truncatingRemainder(dividingBy: 60))
        let milliseconds = Int((timeInterval.truncatingRemainder(dividingBy: 1)) * 100)
        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
    }
    
    public class func printCurrentTimeMillis() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss.SSS"
        let formattedDate = dateFormatter.string(from: date)
        print("Current Time (with milliseconds): \(formattedDate)")
    }
    
    public class func printStartTimeMillis(_ object: String) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss.SSS"
        let formattedDate = dateFormatter.string(from: date)
        print("\(object) Started at: \(formattedDate) 🌿🌿🌿🌿🌿")
    }
    
    public class func printEndTimeMillis(_ object: String) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss.SSS"
        let formattedDate = dateFormatter.string(from: date)
        print("\(object) End at: \(formattedDate) 🔥🔥🔥🔥🔥")
    }
    
    public class func calculateTimeIntervalString(start: String?, end: String?, format: String = "m:ss.SS") -> String? {
        guard let start, let end else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let startDate = dateFormatter.date(from: start),
           let endDate = dateFormatter.date(from: end) {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let minutes = Int(abs(timeInterval) / 60)
            let seconds = Int(abs(timeInterval.truncatingRemainder(dividingBy: 60)))
            let milliseconds = Int((abs(timeInterval.truncatingRemainder(dividingBy: 1))) * 100)
            
            return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
        }
        return nil
    }
}
