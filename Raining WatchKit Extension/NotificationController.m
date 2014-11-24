//
//  NotificationController.m
//  Raining WatchKit Extension
//
//  Created by Mark Hambly on 11/23/14.
//  Copyright (c) 2014 Mark Hambly. All rights reserved.
//

#import "NotificationController.h"
#import "MinutelyRainAnalyzer.h"


@interface NotificationController()
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *label;
@property (weak, nonatomic) IBOutlet WKInterfaceImage *image;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *todayLabel;

@end


@implementation NotificationController

- (void)didReceiveRemoteNotification:(NSDictionary *)remoteNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",remoteNotification[@"url"],remoteNotification[@"coordinates"]]];
    
    [self.image setImage:[UIImage imageNamed:@"NoRain"]];
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL: url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError){
            NSDictionary *weatherDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            [self.image setImage:[MinutelyRainAnalyzer rainImageForMinutelyRainArray:weatherDict[@"minutely"][@"data"]]];
            self.label.text = weatherDict[@"minutely"][@"summary"];
            self.todayLabel.text = [NSString stringWithFormat:@"%@",weatherDict[@"daily"][@"data"][0][@"summary"]];
        }
    }];
    
    completionHandler(WKUserNotificationInterfaceTypeCustom);
}


@end



