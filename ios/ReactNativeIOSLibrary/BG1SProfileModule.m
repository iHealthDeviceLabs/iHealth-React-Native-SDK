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
             BG1S_ACTION:BG1S_ACTION,
             BG1S_DEVICE:BG1S_DEVICE,
             BG1S_KEY_MAC:BG1S_KEY_MAC,
             BG1S_TYPE:BG1S_TYPE,
             OPERATION_DESCRIBE:OPERATION_DESCRIBE,
             STRIP_INSERTION_STATUS:STRIP_INSERTION_STATUS,
             kACTION_GET_ALL_CONNECTED_DEVICES:kACTION_GET_ALL_CONNECTED_DEVICES,
             @"ACTION_STRIP_INSERTION_STATUS"  :ACTION_STRIP_INSERTION_STATUS,
             @"ACTION_GET_BLOOD"             :ACTION_GET_BLOOD,
             @"ACTION_MEASURE_RESULT"      :ACTION_MEASURE_RESULT,
             @"ACTION_CODE_ANALYSIS"             :ACTION_CODE_ANALYSIS,
             @"INFO_BATTERY_BG1S"                :INFO_BATTERY_BG1S,
             @"INFO_VERSION_CODE_BLOOD_BG1S"                :INFO_VERSION_CODE_BLOOD_BG1S,
             @"INFO_VERSION_CODE_CTL_BG1S"                :INFO_VERSION_CODE_CTL_BG1S,
             @"ACTION_ERROR_BG1S"                :ACTION_ERROR_BG1S,
             @"ERROR_NUM_BG1S"                :ERROR_NUM_BG1S,
             @"ERROR_DESCRIPTION_BG1S"                :ERROR_DESCRIPTION_BG1S,
             @"MEASURE_RESULT"          :MEASURE_RESULT,
             @"MEASURE_MODE"            :MEASURE_MODE
             };
};


+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

@end
