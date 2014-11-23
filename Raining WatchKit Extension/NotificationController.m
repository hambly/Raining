//
//  NotificationController.m
//  Raining WatchKit Extension
//
//  Created by Mark Hambly on 11/23/14.
//  Copyright (c) 2014 Mark Hambly. All rights reserved.
//

#import "NotificationController.h"


@interface NotificationController()
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *label;
@property (weak, nonatomic) IBOutlet WKInterfaceImage *image;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *todayLabel;

@end


@implementation NotificationController

- (instancetype)init {
    self = [super init];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
//        NSLog(@"%@ init", self);
        
    }
    return self;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
//    NSLog(@"%@ will activate", self);
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
//    NSLog(@"%@ did deactivate", self);
}


- (void)didReceiveRemoteNotification:(NSDictionary *)remoteNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler {
    // This method is called when a remote notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification inteface as quickly as possible.
    //
    // After populating your dynamic notification interface call the completion block.
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",remoteNotification[@"url"],remoteNotification[@"coordinates"]]];
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL: url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError){
            NSDictionary *weatherDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.label.text = weatherDict[@"minutely"][@"summary"];
            self.todayLabel.text = [NSString stringWithFormat:@"%@",weatherDict[@"daily"][@"data"][0][@"summary"]];
        }
    }];
    
    [self.image setImage:[UIImage imageNamed:@"rain_graph"]];
    
    
    completionHandler(WKUserNotificationInterfaceTypeCustom);
}


@end



