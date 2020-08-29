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

    @IBOutlet weak var addFlightWindow: NSWindow!
    
    let demoWindowController = DemoWindowController()

    @IBAction func showDemoWindow(_ sender: AnyObject) {
        demoWindowController.show()
    }

}
