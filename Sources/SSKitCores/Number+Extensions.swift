//
//  Number+Extensions.swift
//  SSKit
//
//  Created by SUU on 04/09/2023.
//

import Foundation

public extension Int {
    
    func toTimeString() -> String {
        let milliseconds = self
        var finalTimerString = ""
        var minutesString = ""
        var secondsString = ""
        let hours = Int(milliseconds / (60 * 60))
        let minutes = Int(milliseconds % (60 * 60)) / (60)
        let seconds = Int((milliseconds % (60 * 60)) % (60))
        if hours > 0 {
            if hours < 10 {
                finalTimerString = "0\(hours):"
            } else {
                finalTimerString = "\(hours):"
            }
        }
        if minutes < 10 {
            minutesString = "0\(minutes):"
        } else {
            minutesString = "\(minutes):"
        }
        if seconds < 10 {
            secondsString = "0\(seconds)"
        } else {
            secondsString = "\(seconds)"
        }
        
        finalTimerString = "\(finalTimerString)\(minutesString)\(secondsString)"
        return finalTimerString
    }
    
}
