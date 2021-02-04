//
//  BG1SProfileModule.m
//  ReactNativeIOSLibrary
//
//  Created by user on 2019/11/14.
//  Copyright © 2019 daiqingquan. All rights reserved.
//

#import "BG1SProfileModule.h"

@implementation BG1SProfileModule

RCT_EXPORT_MODULE()

#pragma mark
#pragma mark - constantsToExport


- (NSDictionary *)constantsToExport
{
    return @{
             @"ACTION_MEASUREMENT_RESULT":@"action_measurement_result",
             BG1S_ACTION:@"action",
             BG1S_DEVICE:@"device",
             BG1S_KEY_MAC:@"mac",
             kACTION_GET_ALL_CONNECTED_DEVICES:kACTION_GET_ALL_CONNECTED_DEVICES,
             BG1S_RESULT:@"result",
             BG1S_UNIT_FLAG:@"unit_flag",
             BG1S_THERMOMETER_TYPE:@"thermometer_type",
             kRN_ACTION_STRIP_IN              :kRN_ACTION_STRIP_IN,
             kRN_ACTION_STRIP_OUT             :kRN_ACTION_STRIP_OUT,
             kRN_ACTION_GET_BLOOD             :kRN_ACTION_GET_BLOOD,
             kRN_ACTION_ONLINE_RESULT_BG      :kRN_ACTION_ONLINE_RESULT_BG,
             kRN_ACTION_GET_FUNCTION          :kRN_ACTION_GET_FUNCTION
             };
};


+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

@end
