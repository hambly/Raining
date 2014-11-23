//
//  MinutelyRainAnalyzer.h
//  Raining
//
//  Created by Mark Hambly on 11/23/14.
//  Copyright (c) 2014 Mark Hambly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

typedef enum {
    RainTypeRainingNoStopHeavy,
    RainTypeRainingNoStopLight,
    RainTypeRainingWillStopHeavy,
    RainTypeRainingWillStopLight,
    RainTypeNotRainingWillStartNoStopHeavy,
    RainTypeNotRainingWillStartNoStopLight,
    RainTypeNotRainingWillStartWillStopHeavy,
    RainTypeNotRainingWillStartWillStopLight,
    RainTypeNoRain
} RainType;

@interface MinutelyRainAnalyzer : NSObject

+ (UIImage *)rainImageForMinutelyRainArray:(NSArray *)minutelyArray;

@end
