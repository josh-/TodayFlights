//
//  TodayFlightsTests.m
//  TodayFlightsTests
//
//  Created by Josh Parnham on 29/8/20.
//  Copyright © 2020 Josh Parnham. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "FUFlightViewController.h"

@interface TodayFlightsTests : XCTestCase

@end

@implementation TodayFlightsTests

- (void)testClassExists {
    Class class = NSClassFromString(@"FUFlightViewController");
    
    XCTAssertNotNil(class);
}

- (void)testResponseToSelector {
    FUFlightViewController *flightViewController = [FUFlightViewController alloc];
    BOOL responseToSelector = [flightViewController respondsToSelector:@selector(initWithFlightCode:airlineCode:)];
    
    XCTAssertTrue(responseToSelector);
}

@end
