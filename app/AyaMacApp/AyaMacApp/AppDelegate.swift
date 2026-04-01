//
//  AppDelegate.swift
//  AyaMacApp
//
//  Created by Raven Nelson on 2026/3/31.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusItem: NSStatusItem!
    var eventMonitor: Any?
    var lastExplanation: String = ""

    func applicationDidFinishLaunching(_ notification: Notification) {
        
        // Create menu bar item
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem.button?.title = "Aya"
        
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Fix Grammar", action: #selector(fixGrammar), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Show Explanation", action: #selector(showExplanation), keyEquivalent: ""))
        
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
        
        // Register global hotkey: Cmd + Shift + F
        eventMonitor = NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { event in
            if event.modifierFlags.contains(.command) &&
               event.modifierFlags.contains(.shift) &&
               event.charactersIgnoringModifiers == "f" {
                
                self.fixGrammar()
            }
        }
    }

    // MARK: - Main Feature: Fix Selected Text
    
    @objc func fixGrammar() {
        Task {
            // Step 1: Copy currently selected text
            simulateCopy()
            
            // Wait briefly to ensure clipboard is updated
            try? await Task.sleep(nanoseconds: 300_000_000)
            
            let pasteboard = NSPasteboard.general
            let input = pasteboard.string(forType: .string) ?? ""
            
            if input.isEmpty {
                print("No selected text found")
                return
            }
            
            // Step 2: Send selected text to local Aya model
            let result = await callAya(text: input)
            
            // Step 3: Split result into fixed text and explanation
            let parts = result.components(separatedBy: "|||")
            let fixed = parts.first ?? result
            let explanation = parts.count > 1 ? parts[1] : ""
            
            // Store explanation for optional viewing
            self.lastExplanation = explanation
            
            // Step 4: Replace clipboard content with corrected text
            pasteboard.clearContents()
            pasteboard.setString(fixed, forType: .string)
            
            // Step 5: Paste corrected text back to replace selection
            simulatePaste()
            
            print("Fixed:", fixed)
        }
    }

    // MARK: - Show Explanation Popup
    
    @objc func showExplanation() {
        let alert = NSAlert()
        alert.messageText = "Explanation"
        alert.informativeText = lastExplanation.isEmpty ? "No explanation available." : lastExplanation
        alert.runModal()
    }

    // MARK: - Local Aya API Call
    
    func callAya(text: String) async -> String {
        let url = URL(string: "http://127.0.0.1:8000/v1/chat/completions")!
        
        let body: [String: Any] = [
            "messages": [
                [
                    "role": "user",
                    "content": """
Fix grammar only. Do not change tone or wording unless necessary.
Return JSON ONLY:
{
  "fixed": "...",
  "explanation": "..."
}

Text: \(text)
"""
                ]
            ]
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: body)
        
        do {
            // Perform network request to local model
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
            let choices = json["choices"] as! [[String: Any]]
            let message = choices[0]["message"] as! [String: Any]
            let content = message["content"] as! String
            
            // Attempt to parse structured JSON response
            if let data = content.data(using: .utf8),
               let parsed = try? JSONSerialization.jsonObject(with: data) as? [String: String] {
                
                let fixed = parsed["fixed"] ?? content
                let explanation = parsed["explanation"] ?? ""
                
                return "\(fixed)|||\(explanation)"
            }
            
            return content
            
        } catch {
            print("API error:", error)
            return "Error: Unable to process request"
        }
    }

    // MARK: - Simulate Copy (Cmd + C)
    
    func simulateCopy() {
        let source = CGEventSource(stateID: .hidSystemState)
        
        let cmdDown = CGEvent(keyboardEventSource: source, virtualKey: 0x37, keyDown: true)
        let cDown = CGEvent(keyboardEventSource: source, virtualKey: 0x08, keyDown: true)
        cDown?.flags = .maskCommand
        
        let cUp = CGEvent(keyboardEventSource: source, virtualKey: 0x08, keyDown: false)
        let cmdUp = CGEvent(keyboardEventSource: source, virtualKey: 0x37, keyDown: false)
        
        // Post keyboard events to simulate Cmd+C
        cmdDown?.post(tap: .cghidEventTap)
        cDown?.post(tap: .cghidEventTap)
        cUp?.post(tap: .cghidEventTap)
        cmdUp?.post(tap: .cghidEventTap)
    }

    // MARK: - Simulate Paste (Cmd + V)
    
    func simulatePaste() {
        let source = CGEventSource(stateID: .hidSystemState)
        
        let cmdDown = CGEvent(keyboardEventSource: source, virtualKey: 0x37, keyDown: true)
        let vDown = CGEvent(keyboardEventSource: source, virtualKey: 0x09, keyDown: true)
        vDown?.flags = .maskCommand
        
        let vUp = CGEvent(keyboardEventSource: source, virtualKey: 0x09, keyDown: false)
        let cmdUp = CGEvent(keyboardEventSource: source, virtualKey: 0x37, keyDown: false)
        
        // Post keyboard events to simulate Cmd+V
        cmdDown?.post(tap: .cghidEventTap)
        vDown?.post(tap: .cghidEventTap)
        vUp?.post(tap: .cghidEventTap)
        cmdUp?.post(tap: .cghidEventTap)
    }
}
