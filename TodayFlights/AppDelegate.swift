//
//  AppDelegate.swift
//  TodayFlights
//
//  Created by Josh Parnham on 8/12/16.
//  Copyright © 2016 Josh Parnham. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSUserNotificationCenterDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var addFlightWindow: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
//        loadFlightData(sender: nil)   
    }
    
    @IBAction func loadFlightData(sender: NSButton?) {
        guard let defaults = TodayFlightsUserDefaults.sharedInstance else { return }
        
        guard
            let airlineCode = defaults.string(forKey: "airlineCode"),
            let routeNumber = defaults.string(forKey: "routeNumber") else {
            return
        }
        
        if let routeNumberInt = UInt64(routeNumber) {
            let flightViewController: FUFlightViewController = FUFlightViewController(flightCode: routeNumberInt, airlineCode: airlineCode)
            self.window.contentViewController = flightViewController
        }
    }

}

