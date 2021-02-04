//
//  BTMProfileModule.m
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2016/12/4.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import "BTMProfileModule.h"

@implementation BTMProfileModule


RCT_EXPORT_MODULE()

#pragma mark
#pragma mark - constantsToExport


- (NSDictionary *)constantsToExport
{
    return @{
             @"ACTION_BTM_BATTERY":BTM_ACTION_BATTERY,
             @"BTM_BATTERY":BTM_BATTERY,
             @"ACTION_BTM_MEMORY":BTM_ACTION_MEMORY,
             @"ACTION_BTM_MEASURE":BTM_ACTION_MEASURE,
             @"ACTION_BTM_CALLBACK":BTM_ACTION_CALLBACK,
             @"ACTION_ERROR_BTM":BTM_ACTION_ERROR,
             @"MEMORY_COUNT":BTM_MEMORY_COUNT,
             @"BTM_TEMPERATURE_ARRAY":BTM_TEMPERATURE_ARRAY,
             @"BTM_TEMPERATURE_TARGET":BTM_TEMPERATURE_TARGET,
             @"BTM_TEMPERATURE":BTM_TEMPERATURE,
             @"BTM_MEASURE_TIME":BTM_MEASURE_TIME,
             @"ERROR_NUM_BTM":BTM_ERROR_NUM,
             @"ERROR_DESCRIPTION_BTM":BTM_ERROR_DESCRIPTION,
             @"devices":BTM_ERROR_DESCRIPTION,
             @"ACTION_GET_ALL_CONNECTED_DEVICES":@"ACTION_GET_ALL_CONNECTED_DEVICES",
             };
};


+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

@end
