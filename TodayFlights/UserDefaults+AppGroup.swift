//
//  UserDefaults+AppGroup.swift
//  TodayFlights
//
//  Created by Josh Parnham on 10/2/17.
//  Copyright © 2017 Josh Parnham. All rights reserved.
//

import Foundation

class TodayFlightsUserDefaults {
    static let sharedInstance: UserDefaults? = {
        let defaults = UserDefaults(suiteName: "group.com.joshparnham.TodayFlights")
        defaults?.register(defaults: ["airlineCode": "", "routeNumber": ""])
        return defaults
    }()
}
