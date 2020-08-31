//
//  AddFlightViewController.swift
//  TodayFlights
//
//  Created by Josh Parnham on 10/2/17.
//  Copyright © 2017 Josh Parnham. All rights reserved.
//

import Cocoa

class AddFlightViewController: NSViewController, NSTextFieldDelegate {
    @IBOutlet weak var airlineCodeTextField: NSTextField!
    @IBOutlet weak var routeNumberTextField: NSTextField!

    override func viewDidLoad() {
        guard let defaults = TodayFlightsUserDefaults.sharedInstance else { return }
        
        if let airlineCode = defaults.string(forKey: "airlineCode") {
            airlineCodeTextField.stringValue = airlineCode
        }
        if let routeNumber = defaults.string(forKey: "routeNumber") {
            routeNumberTextField.stringValue = routeNumber
        }
    }

    func controlTextDidChange(_ notification: Notification) {
        guard let defaults = TodayFlightsUserDefaults.sharedInstance else { return }
        
        let changedField = notification.object
        if changedField as? NSTextField == airlineCodeTextField {
            defaults.setValue(airlineCodeTextField.stringValue, forKey: "airlineCode")
        }
        else if changedField as? NSTextField == routeNumberTextField {
            defaults.setValue(routeNumberTextField.stringValue, forKey: "routeNumber")
        }
    }
    
    @IBAction func save(_ sender: NSButton) {
        guard let defaults = TodayFlightsUserDefaults.sharedInstance else { return }
        
        defaults.setValue(airlineCodeTextField.stringValue, forKey: "airlineCode")
        defaults.setValue(routeNumberTextField.stringValue, forKey: "routeNumber")
    }
    
    @IBAction func helpButtonClicked(_ sender: NSButton) {
        let helpUrlString = "https://support.apple.com/guide/mac-help/mchl2fb1258f/mac#mchl81797ce0"
        guard let url = URL(string: helpUrlString) else {
            return
        }
        
        NSWorkspace.shared.open(url)
    }
}
