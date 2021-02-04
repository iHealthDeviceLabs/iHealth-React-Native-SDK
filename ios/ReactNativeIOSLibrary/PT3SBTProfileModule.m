//
//  POProfileModule.m
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2016/12/4.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import "PT3SBTProfileModule.h"

@implementation PT3SBTProfileModule


RCT_EXPORT_MODULE()

#pragma mark
#pragma mark - constantsToExport


- (NSDictionary *)constantsToExport
{
    return @{
             kACTION_SET_TIME:@"ACTION_SET_TIME",
             kACTION_GET_BATTERY:@"ACTION_GET_BATTERY",
             kACTION_SET_UNIT:@"ACTION_SET_UNIT",
             kACTION_GET_UNIT:@"ACTION_GET_UNIT",
             kACTION_GET_HISTORY_COUNT:@"ACTION_GET_HISTORY_COUNT",
             kACTION_GET_HISTORY_DATA:@"ACTION_GET_HISTORY_DATA",
             kACTION_DELETE_HISTORY_DATA:@"ACTION_DELETE_HISTORY_DATA",
             kACTION_TEMPERATURE_MEASUREMENT:@"ACTION_TEMPERATURE_MEASUREMENT",
             kACTION_PUB_UNIT:@"ACTION_PUB_UNIT",
             kACTION_GET_ALL_CONNECTED_DEVICES:@"ACTION_GET_ALL_CONNECTED_DEVICES",
             STATUS:@"STATUS",
             BATTERY:@"BATTERY",
             UNIT:@"UNIT",
             TS:@"TS",
             COUNT:@"COUNT",
             TEMPERATURE:@"TEMPERATURE",
             HISTORY:@"HISTORY",
             };
};


+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

@end
