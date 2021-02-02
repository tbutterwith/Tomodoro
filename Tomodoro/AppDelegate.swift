//
//  AppDelegate.swift
//  Tomodoro
//
//  Created by Thomas Butterwith on 24/01/2021.
//

import Cocoa
import SwiftUI
import KeyboardShortcuts

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var prefsViewController: WindowController?
    var statusBarItem: NSStatusItem?
    var runLoop: Timer!
    var notifyService: NotificationHandler!
    @IBOutlet weak var menu: NSMenu!
    
    var timer: PomodoroTimer!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        notifyService = NotificationHandler()
        KeyboardShortcuts.onKeyUp(for: .toggleTimer) { [self] in toggleTimer()}
        KeyboardShortcuts.onKeyUp(for: .startBreak) { [self] in startBreak()}
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let menu = menu {
            statusBarItem?.menu = menu
            menu.delegate = self
        }
        
        timer = PomodoroTimer()
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        setDefaultBarIcon()
        statusBarItem?.button?.action = #selector(self.handleBarItemClick(sender:))
        statusBarItem?.button?.sendAction(on: [.leftMouseUp, .rightMouseUp])
    }
    
    func setDefaultBarIcon () {
        statusBarItem?.button?.image = NSImage(named: "TomatoIcon")
        statusBarItem?.button?.imagePosition = NSControl.ImagePosition.imageLeft
        statusBarItem?.button?.title = timer.getTimeString()
    }
    
    func startBreak() {
        timer.startBreak()
        if !timer.isRunning {
            toggleTimer()
        }
    }
    
    func toggleTimer() {
        timer.toggle()
        if timer.isRunning {
            runLoop = Timer(timeInterval: 1.0, target: self, selector: #selector(updateStatus), userInfo: nil, repeats: true)
            runLoop.tolerance = 0.1
            RunLoop.current.add(runLoop, forMode: .common)
        } else {
            resetTimer()
        }
    }
    
    func resetTimer() {
        runLoop.invalidate()
        timer.reset()
        setDefaultBarIcon()
    }
    
    @objc func handleBarItemClick(sender: NSStatusBarButton) {
        let event = NSApp.currentEvent!
        
        if event.type ==  NSEvent.EventType.rightMouseUp {
            toggleTimer()
        } else {
            statusBarItem?.popUpMenu(menu)
        }
    }
    
    @objc func updateStatus() {
        // Refresh the menu bar icon
        statusBarItem?.button?.title = timer.getTimeString()
        
        // Update the timer
        timer.running()
        
        if timer.isFinished() {
            if timer.isBreak {
                notifyService.sendBreakEndNotification()
            } else {
                notifyService.sendTimerEndNotification()
            }
            timer.nextPhase()
        }
    }
}

extension AppDelegate: NSMenuDelegate {
    func menuWillOpen(_ menu: NSMenu) {
       
    }
    
    
    func menuDidClose(_ menu: NSMenu) {
        
    }
}
