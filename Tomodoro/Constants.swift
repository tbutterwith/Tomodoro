//
//  Constants.swift
//  Tomodoro
//
//  Created by Thomas Butterwith on 25/01/2021.
//

import Foundation

import KeyboardShortcuts

extension KeyboardShortcuts.Name {
    static let toggleTimer = Self("toggleTimer", default: .init(.t, modifiers: [.command, .option]))
    static let startBreak = Self("startBreak", default: .init(.b, modifiers: [.command, .option]))
}


let TIMER_LENGTH_DEFAULT:Double = 25 * 60
let BREAK_LENGTH_DEFAULT:Double = 5 * 60
