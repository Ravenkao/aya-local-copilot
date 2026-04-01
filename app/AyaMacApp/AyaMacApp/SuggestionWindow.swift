//
//  SuggestionWindow.swift
//  AyaMacApp
//
//  Created by Raven Nelson on 2026/3/31.
//

import Cocoa

@MainActor
class SuggestionWindow {
    
    var window: NSWindow!
    
    init(original: String, suggestion: String, explanation: String, onAccept: @escaping () -> Void) {
        
        let contentRect = NSRect(x: 0, y: 0, width: 400, height: 240)
        
        window = NSWindow(
            contentRect: contentRect,
            styleMask: [.titled, .closable],
            backing: .buffered,
            defer: false
        )
        
        window.level = .floating
        window.title = "Grammar Suggestion"
        
        let view = NSView(frame: contentRect)
        
        // Original
        let originalLabel = NSTextField(labelWithString: "Original:")
        originalLabel.frame = NSRect(x: 20, y: 190, width: 300, height: 20)
        
        let originalText = NSTextField(wrappingLabelWithString: original)
        originalText.frame = NSRect(x: 20, y: 150, width: 360, height: 40)
        
        // Suggestion
        let suggestionLabel = NSTextField(labelWithString: "Suggestion:")
        suggestionLabel.frame = NSRect(x: 20, y: 120, width: 300, height: 20)
        
        let suggestionText = NSTextField(wrappingLabelWithString: suggestion)
        suggestionText.frame = NSRect(x: 20, y: 90, width: 360, height: 30)
        
        // Explanation
        let explanationLabel = NSTextField(labelWithString: "Explanation:")
        explanationLabel.frame = NSRect(x: 20, y: 60, width: 300, height: 20)
        
        let explanationText = NSTextField(wrappingLabelWithString: explanation)
        explanationText.frame = NSRect(x: 20, y: 20, width: 360, height: 40)
        
        // Accept button
        let acceptButton = NSButton(title: "Accept", target: nil, action: nil)
        acceptButton.frame = NSRect(x: 280, y: 0, width: 100, height: 30)
        
        acceptButton.action = #selector(handleAccept)
        
        objc_setAssociatedObject(acceptButton, "callback", onAccept, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        view.addSubview(originalLabel)
        view.addSubview(originalText)
        view.addSubview(suggestionLabel)
        view.addSubview(suggestionText)
        view.addSubview(explanationLabel)
        view.addSubview(explanationText)
        view.addSubview(acceptButton)
        
        window.contentView = view
        
        let mouse = NSEvent.mouseLocation
        window.setFrameOrigin(NSPoint(x: mouse.x - 200, y: mouse.y - 120))
    }
    
    @objc func handleAccept(_ sender: NSButton) {
        if let callback = objc_getAssociatedObject(sender, "callback") as? () -> Void {
            callback()
        }
        window.close()
    }
    
    func show() {
        window.makeKeyAndOrderFront(nil)
    }
}
