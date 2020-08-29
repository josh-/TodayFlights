//
//  EditFlightViewController.h
//  TodayFlightsWidget
//
//  Created by Josh Parnham on 29/8/20.
//  Copyright © 2020 Josh Parnham. All rights reserved.
//

@import AppKit;

@interface EditFlightViewController : NSViewController

@property (strong, nonatomic) IBOutlet NSTextField *airlineCodeTextField;
@property (strong, nonatomic) IBOutlet NSTextField *routeNumberTextField;

@end
