//
//  BG5SProfileModule.h
//  ReactNativeIOSLibrary
//
//  Created by soso on 2019/4/24.
//  Copyright © 2019 daiqingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<React/RCTAssert.h>)
#import <React/RCTBridgeModule.h>
#else
#import "RCTBridgeModule.h"
#endif


// Commom in BG5Module.js & BG5LModule.js
#define kACTION_ERROR_BG              @"ACTION_ERROR_BG"
#define kACTION_GET_STATUS_INFO       @"ACTION_GET_STATUS_INFO"
#define kACTION_SET_TIME              @"ACTION_SET_TIME"
#define kACTION_SET_UNIT              @"ACTION_SET_UNIT"
#define kACTION_GET_BATTERY           @"ACTION_GET_BATTERY"
#define kACTION_START_MEASURE         @"ACTION_START_MEASURE"
#define kACTION_GET_OFFLINEDATA_COUNT @"ACTION_GET_OFFLINEDATA_COUNT"
#define kACTION_GET_OFFLINEDATA       @"ACTION_GET_OFFLINEDATA"
#define kACTION_DELETE_OFFLINEDATA    @"ACTION_DELETE_OFFLINEDATA"
#define kACTION_SET_BOTTLEMESSAGE     @"ACTION_SET_BOTTLEMESSAGE"
#define kACTION_GET_BOTTLEMESSAGE     @"ACTION_GET_BOTTLEMESSAGE"
#define kACTION_SET_BOTTLEID          @"ACTION_SET_BOTTLEID"
#define kACTION_GET_BOTTLEID          @"ACTION_GET_BOTTLEID"
#define kACTION_STRIP_IN              @"ACTION_STRIP_IN"
#define kACTION_STRIP_OUT             @"ACTION_STRIP_OUT"
#define kACTION_GET_BLOOD             @"ACTION_GET_BLOOD"
#define kACTION_ONLINE_RESULT_BG      @"ACTION_ONLINE_RESULT_BG"
#define kACTION_ADJUST_OFFLINE_DATA   @"ACTION_ADJUST_OFFLINE_DATA"
#define kACTION_DELETE_USED_STRIP     @"ACTION_DELETE_USED_STRIP"
#define kACTION_SET_OFFINEMODEL       @"ACTION_SET_OFFINEMODEL"



#define kERROR_NUM_BG                 @"ERROR_NUM_BG"
#define kERROR_DESCRIPTION_BG         @"ERROR_DESCRIPTION_BG"
#define kGET_BATTERY                  @"GET_BATTERY"
#define kGET_OFFLINEDATA_COUNT        @"GET_OFFLINEDATA_COUNT"
#define kGET_OFFLINEDATA              @"GET_OFFLINEDATA"
#define kSET_BOTTLEMESSAGE            @"SET_BOTTLEMESSAGE"
#define kSTART_MODE                   @"START_MODE"
#define kGET_EXPIRECTIME              @"GET_EXPIRECTIME"
#define kGET_USENUM                   @"GET_USENUM"
#define kGET_BOTTLEID                 @"GET_BOTTLEID"
#define kONLINE_RESULT_BG             @"ONLINE_RESULT_BG"
#define kDATA_ID                      @"DATA_ID"
#define kACTION_CODE_ANALYSIS         @"ACTION_CODE_ANALYSIS"
#define kSTRIP_NUM_BG                 @"STRIP_NUM_BG"
#define kSTRIP_EXPIRETIME_BG          @"STRIP_EXPIRETIME_BG"
#define kBOTTLEID_BG                  @"BOTTLEID_BG"
#define kACTION_GET_ALL_CONNECTED_DEVICES   @"ACTION_GET_ALL_CONNECTED_DEVICES"


typedef NS_ENUM(NSInteger,RNBGError) {
    RNBGError_Unknown = -1,
    RNBGError_InputParameterError = 400,
    RNBGError_FunctionCallOrderError = 402,
    RNBGError_MeasureModeNotMatched = 403,
    RNBGError_DisconnectFunctionNotSupportIniOSPlatform = 404, // only for BG5s
    RNBGError_getBottleInfoFromQRFunctionInpurParameterError = 405,
};

@interface BG5SProfileModule : NSObject<RCTBridgeModule>

@end


