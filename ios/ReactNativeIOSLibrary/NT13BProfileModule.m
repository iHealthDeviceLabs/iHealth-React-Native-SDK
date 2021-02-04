//
//  NT13BProfileModule.m
//  ReactNativeIOSLibrary
//
//  Created by user on 2019/11/14.
//  Copyright © 2019 daiqingquan. All rights reserved.
//

#import "NT13BProfileModule.h"

@implementation NT13BProfileModule

RCT_EXPORT_MODULE()

#pragma mark
#pragma mark - constantsToExport


- (NSDictionary *)constantsToExport
{
    return @{
             @"ACTION_MEASUREMENT_RESULT":@"action_measurement_result",
             NT13B_ACTION:@"action",
             NT13B_DEVICE:@"device",
             NT13B_KEY_MAC:@"mac",
             kACTION_GET_ALL_CONNECTED_DEVICES:kACTION_GET_ALL_CONNECTED_DEVICES,
             NT13B_RESULT:@"result",
             NT13B_UNIT_FLAG:@"unit_flag",
             NT13B_THERMOMETER_TYPE:@"thermometer_type"
             };
};


+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

@end
