//
//  BG1ProfileModule.m
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2016/11/23.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import "BG1ProfileModule.h"

@implementation BG1ProfileModule


RCT_EXPORT_MODULE()

#pragma mark
#pragma mark - constantsToExport


- (NSDictionary *)constantsToExport
{
    return @{
             
             @"ACTION_ERROR_BG":@"action_measure_error",
             @"ACTION_GET_BATTERY":@"action_battery_bg",
             @"ACTION_KEEP_LINK":@"action_keep_link",
             @"ACTION_SET_TIME":@"action_set_time",
             @"ACTION_SET_UNIT":@"action_set_unit",
             @"ACTION_START_MEASURE":@"action_start_measure",
             @"ACTION_GET_OFFLINEDATA_COUNT":@"action_historicalnum_bg",
             @"ACTION_GET_OFFLINEDATA":@"action_historicaldata_bg",
             @"ACTION_DELETE_OFFLINEDATA":@"action_delete_historical_data",
             @"ACTION_SET_BOTTLEMESSAGE":@"action_set_bottle_message_success",
             @"ACTION_GET_BOTTLEMESSAGE":@"action_get_codeinfo",
             @"ACTION_SET_BOTTLEID":@"action_set_bottle_message_success",
             @"ACTION_GET_BOTTLEID":@"action_get_bottleid",
             
             @"ACTION_BG1_SENDCODE_RESULT":@"action_sendcode_result_for_bg1",
             @"ACTION_BG1_MEASURE_ERROR":@"action_measure_error_for_bg1",
             @"ACTION_BG1_MEASURE_STRIP_IN":@"action_measure_strip_in_for_bg1",
             @"ACTION_BG1_MEASURE_GET_BLOOD":@"action_measure_get_blood_for_bg1",
             @"ACTION_BG1_MEASURE_RESULT":@"action_measure_result_for_bg1",
             @"ACTION_BG1_MEASURE_STRIP_OUT":@"action_measure_strip_out_for_bg1",
             @"ACTION_BG1_MEASURE_STANDBY":@"action_measure_standby_for_bg1",
             @"ACTION_CODE_ANALYSIS":@"action_code_analysis_bg",
             
             
             @"BG1_SENDCODE_RESULT":@"sendcode_result_for_bg1",
             @"BG1_MEASURE_ERROR":@"action_measure_error_for_bg1",
             @"BG1_MEASURE_RESULT":@"measure_result_for_bg1",
             @"DATA_ID":@"dataID",
             
             @"STRIP_NUM_BG":@"stripNum",
             @"STRIP_EXPIRETIME_BG":@"overDate",
             @"BOTTLEID_BG":@"bottleId",
             
             
              @"ERROR_NUM_BG":@"error",
              @"GET_BATTERY":@"battery",
              @"KEEP_LINK":@"keep_link",
              @"SET_TIME":@"set_time",
              @"SET_UNIT":@"set_unit",
              @"START_MEASURE":@"start_measure",
              @"GET_OFFLINEDATA_COUNT":@"count",
              @"GET_OFFLINEDATA":@"his_data_bg",
              @"DELETE_OFFLINEDATA":@"delete_historical_data",
              @"GET_USENUM":@"usenum",
              @"SET_BOTTLEMESSAGE":@"set_bottle_message",
              @"GET_BOTTLEID":@"bottleid",
              @"SET_BOTTLEID":@"set_bottle_message"
             
             
             
             
             };
};

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}


@end
