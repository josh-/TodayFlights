//
//  EditFlightViewController.m
//  TodayFlights
//
//  Created by Josh Parnham on 20/12/16.
//  Copyright © 2016 Josh Parnham. All rights reserved.
//

#import "EditFlightViewController.h"

@implementation EditFlightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.joshparnham.TodayFlights"];
    
    self.airlineCodeTextField.stringValue = [defaults stringForKey:@"airlineCode"];
    self.routeNumberTextField.stringValue = [defaults stringForKey:@"routeNumber"];
    
    self.preferredContentSize = self.view.frame.size;
}

- (void)viewDidAppear {
    if ([self.airlineCodeTextField acceptsFirstResponder]) {
        [self.airlineCodeTextField becomeFirstResponder];
    }
}

#pragma mark - Text field delegate

- (BOOL)control:(NSControl *)control textView:(NSTextView *)fieldEditor doCommandBySelector:(SEL)commandSelector {
    // Enter key pressed
    if (commandSelector == @selector(insertNewline:)) {
        [self dismissController:nil];
        return YES;
    }
    return NO;
}

- (void)controlTextDidChange:(NSNotification *)notification {
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.joshparnham.TodayFlights"];
    
    NSTextField *changedField = [notification object];
    if (changedField == self.airlineCodeTextField) {
        [defaults setValue:self.airlineCodeTextField.stringValue forKey:@"airlineCode"];
    }
    else if (changedField == self.routeNumberTextField) {
        [defaults setValue:self.routeNumberTextField.stringValue forKey:@"routeNumber"];
    }
}

@end
