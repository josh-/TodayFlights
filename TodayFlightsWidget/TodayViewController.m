//
//  TodayViewController.m
//  TodayFlightsWidget
//
//  Created by Josh Parnham on 27/8/20.
//  Copyright © 2020 Josh Parnham. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

#import "FUFlightViewController.h"

#import "EditFlightViewController.h"
#import "FirstRunViewController.h"

#define WIDGET_HEIGHT 515

@interface TodayViewController () <NCWidgetProviding>

@property (strong, nonatomic) FUFlightViewController *flightViewController;
@property (strong, nonatomic) EditFlightViewController *editFlightViewController;
@property (strong, nonatomic) FirstRunViewController *firstRunViewController;

@property (strong) NSDate *lastAttemptedDismissTime;

@end

@implementation TodayViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.joshparnham.TodayFlights"];
        [defaults registerDefaults:@{@"airlineCode" : @"", @"routeNumber" : @""}];
        
        self.lastAttemptedDismissTime = [NSDate date];
    }
    return self;
}

- (FUFlightViewController *)flightViewController {
    if (!_flightViewController) {
        NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.joshparnham.TodayFlights"];
        NSString *airlineCode = [defaults stringForKey:@"airlineCode"];
        NSString *routeNumber = [defaults stringForKey:@"routeNumber"];
        
        _flightViewController = [[FUFlightViewController alloc] initWithFlightCode:routeNumber.integerValue airlineCode:airlineCode];
        
        _flightViewController.view.autoresizingMask = NSViewWidthSizable;
        _flightViewController.view.frame = NSMakeRect(0, 0, 314, 510);
        _flightViewController.view.autoresizesSubviews = YES;
    }
    
    return _flightViewController;
}

- (EditFlightViewController *)editFlightViewController {
    if (!_editFlightViewController) {
        _editFlightViewController = [[EditFlightViewController alloc] init];
    }
    
    return _editFlightViewController;
}

- (FirstRunViewController *)firstRunViewController {
    if (!_firstRunViewController) {
        _firstRunViewController = [[FirstRunViewController alloc] init];
    }
    
    return _firstRunViewController;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if ([self shouldDisplayFirstRunInformation]) {
        [self.view addSubview:self.firstRunViewController.view];
        self.preferredContentSize = self.firstRunViewController.preferredContentSize;
    }
    else {
        [self.view addSubview:self.flightViewController.view];
        self.preferredContentSize = CGSizeMake(0, WIDGET_HEIGHT);
        
        [self.view setAutoresizesSubviews:YES];
    }
}

#pragma mark - Methods

- (void)reloadFlightData {
    [self.firstRunViewController.view removeFromSuperview];
    
    [self.flightViewController.view removeFromSuperview];
    self.flightViewController = nil;
    
    if ([self shouldDisplayFirstRunInformation]) {
        [self.view addSubview:self.firstRunViewController.view];
        self.preferredContentSize = self.firstRunViewController.preferredContentSize;
    }
    else {
        self.preferredContentSize = CGSizeMake(0, WIDGET_HEIGHT);
        [self.view addSubview:self.flightViewController.view];
    }
}

- (void)endWidgetEditingMode {
    SEL sel = NSSelectorFromString(@"setWidgetMode:");
    id extensionContextDelegate = [self.extensionContext performSelector:@selector(delegate)];
    NSMethodSignature *signature = [[extensionContextDelegate class] instanceMethodSignatureForSelector:sel];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.selector = sel;
    [invocation performSelector:@selector(invokeWithTarget:) withObject:extensionContextDelegate afterDelay:0.1]; // Needs to be performed after delay to prevent crash
}

- (BOOL)shouldDisplayFirstRunInformation {
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.joshparnham.TodayFlights"];
    return [[defaults stringForKey:@"airlineCode"] length] == 0 || [[defaults stringForKey:@"routeNumber"] length] == 0;
}

#pragma mark - Widget provisioning delegate

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult result))completionHandler {
    [self reloadFlightData];
    completionHandler(NCUpdateResultNewData);
}

- (NSEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(NSEdgeInsets)defaultMarginInset {
    return NSEdgeInsetsMake(0, 3, 0, 0);
}

- (void)widgetDidBeginEditing {
    if ([self.presentedViewControllers containsObject:self.editFlightViewController] && [[NSDate date] timeIntervalSinceDate:self.lastAttemptedDismissTime] <= 1) {
        // This method is often called repeatedly, so do nothing if we attempted to dismiss the edit controller in the last second
    }
    else {
        if ([self.presentedViewControllers containsObject:self.editFlightViewController]) {
            // If the edit controller is being shown, then dismiss it
            [self endWidgetEditingMode];
            [self reloadFlightData];
            
            self.lastAttemptedDismissTime = [NSDate date];
            [self dismissViewController:self.editFlightViewController];
        }
        else {
            // Since this method can also be called when the info button is pressed, show the edit controller if it not currently being shown
            // https://stackoverflow.com/questions/24970533/show-viewcontroller-on-extension-info-button-edit-mode
            int64_t timeDelta = 0.5 * NSEC_PER_SEC;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, timeDelta), dispatch_get_main_queue(), ^{
                [self presentViewControllerInWidget:self.editFlightViewController];
            });
        }
    }
}

- (void)widgetDidEndEditing {
    if ([self presentingViewController] == self.editFlightViewController) {
        [self dismissViewController:self.editFlightViewController];
    }
}

- (BOOL)widgetAllowsEditing {
    return YES;
}

@end

