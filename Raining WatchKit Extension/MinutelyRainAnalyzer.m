//
//  MinutelyRainAnalyzer.m
//  Raining
//
//  Created by Mark Hambly on 11/23/14.
//  Copyright (c) 2014 Mark Hambly. All rights reserved.
//

#import "MinutelyRainAnalyzer.h"

@interface MinutelyRainAnalyzer ()

@property (nonatomic, assign) BOOL isRaining;
@property (nonatomic, assign) BOOL willRain;
@property (nonatomic, assign) BOOL willContinueRaining;
@property (nonatomic, assign) BOOL isHeavy;

@end

@implementation MinutelyRainAnalyzer

+ (UIImage *)rainImageForMinutelyRainArray:(NSArray *)minutelyArray {
    MinutelyRainAnalyzer *analyzer = [[MinutelyRainAnalyzer alloc] init];
    RainType rainType = [analyzer analyzeRainArray:minutelyArray];
    
    NSString *img;
    switch (rainType) {
        case RainTypeRainingNoStopHeavy:
            img = @"RainingNoStopHeavy";
            break;
        case RainTypeRainingNoStopLight:
            img = @"RainingNoStopLight";
            break;
        case RainTypeRainingWillStopHeavy:
            img = @"RainingWillStopHeavy";
            break;
        case RainTypeRainingWillStopLight:
            img = @"RainingWillStopLight";
            break;
        case RainTypeNotRainingWillStartNoStopHeavy:
            img = @"NotRainingWillStartNoStopHeavy";
            break;
        case RainTypeNotRainingWillStartNoStopLight:
            img = @"NotRainingWillStartNoStopLight";
            break;
        case RainTypeNotRainingWillStartWillStopHeavy:
            img = @"NotRainingWillStartWillStopHeavy";
            break;
        case RainTypeNotRainingWillStartWillStopLight:
            img = @"NotRainingWillStartWillStopLight";
            break;
        case RainTypeNoRain:
            img = @"NoRain";
            break;
            
        default:
            img = @"NoRain";
            break;
    }
    
    return [UIImage imageNamed:img];
}

- (RainType)analyzeRainArray:(NSArray *)array {
    
    NSDictionary *initialConditions = array[0];
    if (initialConditions[@"precipType"]){
        self.isRaining = [self isProbable:initialConditions];
    }
    
    NSDictionary *finalConditions = array[(array.count - 1)];
    if (finalConditions[@"precipType"]){
        self.willContinueRaining = [self isProbable:finalConditions];
    }
    
    for (NSDictionary *rainDict in array){
        
        if (rainDict[@"precipType"] && !self.isRaining && !self.willRain){
            self.willRain = [self isProbable:rainDict];
        }
        
        if (rainDict[@"precipIntensity"]){
            NSNumber *intensity = rainDict[@"precipIntensity"];
            if (intensity.floatValue > 0.1f){
                self.isHeavy = YES;
            }
        }
        
    }
    
    if (self.isRaining && self.willContinueRaining &&self.isHeavy){
        return RainTypeRainingNoStopHeavy;
    } else if (self.isRaining && self.willContinueRaining && !self.isHeavy){
        return RainTypeRainingNoStopLight;
    } else if (self.isRaining && !self.willContinueRaining && self.isHeavy){
        return RainTypeRainingWillStopHeavy;
    } else if (self.isRaining && !self.willContinueRaining && !self.isHeavy){
        return RainTypeRainingWillStopLight;
    } else if (!self.isRaining && self.willRain && self.willContinueRaining && self.isHeavy){
        return RainTypeNotRainingWillStartNoStopHeavy;
    } else if (!self.isRaining && self.willRain && self.willContinueRaining && !self.isHeavy){
        return RainTypeNotRainingWillStartNoStopLight;
    } else if (!self.isRaining && self.willRain && !self.willContinueRaining && self.isHeavy){
        return RainTypeNotRainingWillStartWillStopHeavy;
    } else if (!self.isRaining && self.willRain && !self.willContinueRaining && !self.isHeavy){
        return RainTypeNotRainingWillStartWillStopLight;
    }
    
    return RainTypeNoRain;
}

- (BOOL)isProbable:(NSDictionary *)dict{
    if (dict[@"precipProbability"]){
        NSNumber *probability = dict[@"precipProbability"];
        if (probability.floatValue >= 0.4){
            return YES;
        }
    }
    return NO;
}

@end
