//
//  PreferencesView.swift
//  Tomodoro
//
//  Created by Thomas Butterwith on 28/01/2021.
//

import Cocoa
import KeyboardShortcuts

class PreferencesView: NSViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        buildView()
    }
    
    func buildView() {
        
        let frame = NSView(frame: NSRect(x: 0, y: 0, width: 400, height: 100))
        
        let toggleTimerLabel = getLabel(text: "Toggle Timer")
        frame.addSubview(toggleTimerLabel)
        let startBreakLabel = getLabel(text: "Start Break")
        frame.addSubview(startBreakLabel)

        let toggleTimerRecorder = KeyboardShortcuts.RecorderCocoa(for: .toggleTimer)
        toggleTimerRecorder.translatesAutoresizingMaskIntoConstraints = false
        frame.addSubview(toggleTimerRecorder)
        
        let startBreakRecorder = KeyboardShortcuts.RecorderCocoa(for: .startBreak)
        startBreakRecorder.translatesAutoresizingMaskIntoConstraints = false
        frame.addSubview(startBreakRecorder)
        
        
        toggleTimerLabel.leadingAnchor.constraint(equalTo: frame.leadingAnchor, constant: 40).isActive = true
        toggleTimerRecorder.leadingAnchor.constraint(equalTo: frame.leadingAnchor, constant: 200).isActive = true
        
        startBreakLabel.leadingAnchor.constraint(equalTo: frame.leadingAnchor, constant: 40).isActive = true
        startBreakRecorder.leadingAnchor.constraint(equalTo: frame.leadingAnchor, constant: 200).isActive = true
        
        toggleTimerLabel.centerYAnchor.constraint(equalTo: frame.topAnchor, constant: 30).isActive = true
        toggleTimerRecorder.centerYAnchor.constraint(equalTo: frame.topAnchor, constant: 30).isActive = true
        
        startBreakLabel.centerYAnchor.constraint(equalTo: toggleTimerLabel.bottomAnchor, constant: 30).isActive = true
        startBreakRecorder.centerYAnchor.constraint(equalTo: toggleTimerRecorder.bottomAnchor, constant: 30).isActive = true

        self.view.addSubview(frame)
        
        applyFrameConstraints(view: frame)
    }
    
    func applyFrameConstraints(view: NSView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let viewContraints = [
            view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            view.widthAnchor.constraint(equalToConstant: 400),
            view.heightAnchor.constraint(equalToConstant: 150)
        ]
        
        NSLayoutConstraint.activate(viewContraints)
    }
    
    func getLabel(text:String) -> NSTextField {
        let label = NSTextField(frame: NSMakeRect(0,0, 10, 20))
        let fontSize = label.font!.pointSize
        label.font = NSFont.systemFont(ofSize: fontSize, weight: NSFont.Weight.bold)
        
        
        label.usesSingleLineMode = true
        label.stringValue = text
        label.isBezeled = false
        label.drawsBackground = false
        label.isEditable = false
        label.sizeToFit()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
}
