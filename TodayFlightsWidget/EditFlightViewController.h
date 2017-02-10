//
//  EditFlightViewController.h
//  TodayFlights
//
//  Created by Josh Parnham on 20/12/16.
//  Copyright © 2016 Josh Parnham. All rights reserved.
//

@import AppKit;
@import NotificationCenter;

@interface EditFlightViewController : NCWidgetListViewController <NSTextFieldDelegate>

@property (strong, nonatomic) IBOutlet NSTextField *airlineCodeTextField;
@property (strong, nonatomic) IBOutlet NSTextField *routeNumberTextField;

@end
