//
//  POProfileModule.m
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2016/12/4.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import "PO1ProfileModule.h"

@implementation PO1ProfileModule


RCT_EXPORT_MODULE()

#pragma mark
#pragma mark - constantsToExport


- (NSDictionary *)constantsToExport
{
    return @{
             @"ACTION_GET_BATTERY":@"ACTION_GET_BATTERY",
             
             @"ACTION_BO_MEASUREMENT":@"ACTION_BO_MEASUREMENT",
             
             @"ACTION_ERROR_PO1":@"ACTION_ERROR_PO1",
             
             @"ACTION_GET_ALL_CONNECTED_DEVICES":@"ACTION_GET_ALL_CONNECTED_DEVICES",
             
             @"BATTERY":@"BATTERY",
             
             @"ERROR_DESCRIPTION":@"ERROR_DESCRIPTION",
             
             @"ERROR_ID":@"ERROR_ID",
             
             @"STATUS":@"STATUS",
             
             @"BLOOD_OXYGEN":@"BLOOD_OXYGEN",
             
             @"PULSE":@"PULSE",
             
             @"PULSE_FORCE":@"PULSE_FORCE",
             
             @"PI":@"PI",
             
             @"WAVE":@"WAVE",
             
             };
};


+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

@end
