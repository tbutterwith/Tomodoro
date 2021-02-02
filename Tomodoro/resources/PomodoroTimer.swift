//
//  Timer.swift
//  Tomodoro
//
//  Created by Thomas Butterwith on 24/01/2021.
//

import Foundation

class PomodoroTimer {
    var isRunning: Bool
    var isBreak: Bool
    var remainingTime: TimeInterval
    var timerLength: Double = TIMER_LENGTH_DEFAULT
    var breakLength: Double = BREAK_LENGTH_DEFAULT
    
    
    init() {
        isRunning = false
        remainingTime = timerLength // 25 minutes
        isBreak = false
    }
    
    func reset() {
        isRunning = false
        remainingTime = timerLength
    }
    
    func getTimeString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .pad
        
        return formatter.string(from: remainingTime) ?? ""
    }
    
    @objc func toggle() {
        isRunning = !isRunning
    }
    
    @objc func running() {
        if isRunning {
            remainingTime = remainingTime.advanced(by: -1)
        }
    }
    
    func nextPhase() {
        if isBreak {
            remainingTime = timerLength
            isBreak = false
            return
        }
            
        startBreak()
    }
    
    func startBreak() {
        remainingTime = breakLength
        isBreak = true
    }
    
    func isFinished() -> Bool {
        return remainingTime <= 0
    }
}
