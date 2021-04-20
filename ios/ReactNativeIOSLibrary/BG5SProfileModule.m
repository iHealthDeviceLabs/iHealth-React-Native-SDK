//
//  BG5SProfileModule.m
//  ReactNativeIOSLibrary
//
//  Created by soso on 2019/4/24.
//  Copyright © 2019 daiqingquan. All rights reserved.
//

#import "BG5SProfileModule.h"
#import "RNBGMacro.h"

@implementation BG5SProfileModule


RCT_EXPORT_MODULE()

#pragma mark
#pragma mark - constantsToExport


- (NSDictionary *)constantsToExport
{
    
    
    
    return @{
             @"Event_Notify":@"event_notify_bg5s",
             kRN_ACTION_ERROR_BG              :kACTION_ERROR_BG,
             kRN_ACTION_SET_TIME              :kACTION_SET_TIME,
             kRN_ACTION_SET_UNIT              :kACTION_SET_UNIT,
             kRN_ACTION_GET_BATTERY           :kACTION_GET_BATTERY,
             kRN_ACTION_START_MEASURE         :kACTION_START_MEASURE,
             kRN_ACTION_GET_OFFLINEDATA_COUNT :kACTION_GET_OFFLINEDATA_COUNT,
             kRN_ACTION_GET_OFFLINE_DATA       :kACTION_GET_OFFLINE_DATA,
             kRN_ACTION_DELETE_OFFLINE_DATA   :kACTION_DELETE_OFFLINE_DATA,
             kRN_ACTION_SET_BOTTLEMESSAGE     :kACTION_SET_BOTTLEMESSAGE,
             kRN_ACTION_GET_BOTTLEMESSAGE     :kACTION_GET_BOTTLEMESSAGE,
             kRN_ACTION_SET_BOTTLEID          :kACTION_SET_BOTTLEID,
             kRN_ACTION_GET_BOTTLEID          :kACTION_GET_BOTTLEID,
             kRN_ACTION_STRIP_IN              :kACTION_STRIP_IN,
             kRN_ACTION_STRIP_OUT             :kACTION_STRIP_OUT,
             kRN_ACTION_GET_BLOOD             :kACTION_GET_BLOOD,
             kRN_ACTION_ONLINE_RESULT_BG      :kACTION_ONLINE_RESULT_BG,
             kRN_ACTION_CODE_ANALYSIS         :kACTION_CODE_ANALYSIS,
             kRN_ACTION_GET_ALL_CONNECTED_DEVICES :kACTION_GET_ALL_CONNECTED_DEVICES,
             kRN_ERROR_NUM_BG                 :kERROR_NUM_BG,
             kRN_ERROR_DESCRIPTION_BG         :kERROR_DESCRIPTION_BG,
             kRN_GET_BATTERY                  :kGET_BATTERY,
             kRN_GET_OFFLINEDATA_COUNT        :kGET_OFFLINEDATA_COUNT,
             kRN_GET_OFFLINEDATA              :kGET_OFFLINEDATA,
             kRN_SET_BOTTLEMESSAGE            :kSET_BOTTLEMESSAGE,
             kRN_START_MODE                   :kSTART_MODE,
             kRN_GET_EXPIRECTIME              :kGET_EXPIRECTIME,
             kRN_GET_USENUM                   :kGET_USENUM,
             kRN_GET_BOTTLEID                 :kGET_BOTTLEID,
             kRN_ONLINE_RESULT_BG             :kONLINE_RESULT_BG,
             kRN_DATA_ID                      :kDATA_ID,
             kRN_STRIP_NUM_BG                 :kSTRIP_NUM_BG,
             kRN_STRIP_EXPIRETIME_BG          :kSTRIP_EXPIRETIME_BG,
             kRN_BOTTLEID_BG                  :kBOTTLEID_BG,
             kRN_ACTION_DELETE_USED_STRIP     :kACTION_DELETE_USED_STRIP,
             kRN_ACTION_ADJUST_OFFLINE_DATA   :kACTION_ADJUST_OFFLINE_DATA,
             INFO_BATTERY_LEVEL               :INFO_BATTERY_LEVEL,
             INFO_TIME               :INFO_TIME,
             INFO_TIMEZONE               :INFO_TIMEZONE,
             INFO_USED_STRIP               :INFO_USED_STRIP,
             INFO_OFFLINE_DATA_NUM               :INFO_OFFLINE_DATA_NUM,
             INFO_CODE_VERSION_BLOOD               :INFO_CODE_VERSION_BLOOD,
             INFO_CODE_VERSION_CTL               :INFO_CODE_VERSION_CTL,
             INFO_UNIT               :INFO_UNIT,
             kACTION_RESULT          :kACTION_RESULT,
             RESULT_VALUE            :RESULT_VALUE,
             kACTION_ENTER_CHARGED_STATE :kACTION_ENTER_CHARGED_STATE,
             kACTION_LEAVE_CHARGED_STATE :kACTION_LEAVE_CHARGED_STATE,
             kACTION_SET_OFFINEMODEL:kACTION_SET_OFFINEMODEL,
             };
};


+ (BOOL)requiresMainQueueSetup
{
    return YES;
}
@end
