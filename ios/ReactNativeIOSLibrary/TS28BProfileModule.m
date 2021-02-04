//
//  TS28BProfileModule.m
//  ReactNativeIOSLibrary
//
//  Created by user on 2019/11/14.
//  Copyright © 2019 daiqingquan. All rights reserved.
//

#import "TS28BProfileModule.h"

@implementation TS28BProfileModule


RCT_EXPORT_MODULE()

#pragma mark
#pragma mark - constantsToExport


- (NSDictionary *)constantsToExport
{
    return @{
             @"ACTION_MEASUREMENT_RESULT":@"action_measurement_result",
             TS28B_ACTION:@"action",
             TS28B_DEVICE:@"device",
             TS28B_KEY_MAC:@"mac",
             kACTION_GET_ALL_CONNECTED_DEVICES:kACTION_GET_ALL_CONNECTED_DEVICES,
             TS28B_RESULT:@"result",
             TS28B_UNIT_FLAG:@"unit_flag",
             TS28B_THERMOMETER_TYPE:@"thermometer_type"
             };
};


+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

@end
