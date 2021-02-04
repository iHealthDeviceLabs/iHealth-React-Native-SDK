//
//  POProfileModule.m
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2016/12/4.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import "POProfileModule.h"

@implementation POProfileModule


RCT_EXPORT_MODULE()

#pragma mark
#pragma mark - constantsToExport


- (NSDictionary *)constantsToExport
{
    return @{
             @"ACTION_BATTERY_PO":@"ACTION_BATTERY_PO",
             @"BATTERY_PO":PO_BATTERY,
             @"ACTION_LIVEDA_PO":@"ACTION_LIVEDA_PO",
             @"PULSE_WAVE_PO":@"pulseWave",
             @"PI_PO":@"pi",
             @"PULSE_STRENGTH_PO":@"pulsestrength",
             @"BLOOD_OXYGEN_PO":@"bloodoxygen",
             @"PULSE_RATE_PO":@"heartrate",
             @"ACTION_RESULTDATA_PO":@"ACTION_RESULTDATA_PO",
             @"DATAID":@"dataID",
             @"ACTION_OFFLINEDATA_PO":@"ACTION_OFFLINEDATA_PO",
             @"OFFLINEDATA_PO":@"offLineData",
             @"MEASURE_DATE_PO":@"MEASURE_DATE_PO",
             @"ACTION_NO_OFFLINEDATA_PO":@"ACTION_NO_OFFLINEDATA_PO",
             @"ACTION_ERROR_PO":@"ACTION_ERROR_PO",
             @"ACTION_GET_ALL_CONNECTED_DEVICES":@"ACTION_GET_ALL_CONNECTED_DEVICES",
             };
};


+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

@end
