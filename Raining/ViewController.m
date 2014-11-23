//
//  ViewController.m
//  Raining
//
//  Created by Mark Hambly on 11/23/14.
//  Copyright (c) 2014 Mark Hambly. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)button1Pressed:(id)sender {
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:2];
    localNotification.alertBody = @"Hello Notification";
    localNotification.alertAction = @"Is It Raining?";
    localNotification.userInfo = @{};
    localNotification.timeZone = [NSTimeZone localTimeZone];
    localNotification.category = @"watch";
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}
@end
