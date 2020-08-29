//
//  DemoWindowController.swift
//  TodayFlights
//
//  Created by Josh Parnham on 29/8/20.
//  Copyright © 2020 Josh Parnham. All rights reserved.
//

import Cocoa

class DemoWindowController: NSWindowController {
    required init?(coder: NSCoder) {
        fatalError("Use -init")
    }
    
    init() {
        let window = NSWindow(
            contentRect: NSZeroRect,
            styleMask: [.titled, .closable, .miniaturizable],
            backing: NSWindow.BackingStoreType.buffered,
            defer: true
        )
        
        super.init(window: window)
    }
    
    public func show() {
        guard
            let defaults = TodayFlightsUserDefaults.sharedInstance,
            let airlineCode = defaults.string(forKey: "airlineCode"),
            airlineCode.count > 0,
            let routeNumber = defaults.string(forKey: "routeNumber"),
            let routeNumberInt = UInt64(routeNumber) else {
                showAlert()
                return
        }
        
        guard
            let window = window,
            let flightViewController = FUFlightViewController(flightCode: routeNumberInt, airlineCode: airlineCode) else {
            return
        }
        
        window.title = "TodayFlights - \(airlineCode)\(routeNumber)"
        window.contentViewController = flightViewController
        window.center()
        window.makeKeyAndOrderFront(self)
    }
    
    private func showAlert() {
        let alert = NSAlert()
        alert.messageText = "No flight added"
        alert.informativeText = "Add flight information in the Add Flight window or the Today widget before viewing the demo"
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
}
