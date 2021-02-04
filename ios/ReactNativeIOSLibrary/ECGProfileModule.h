//
//  ECGProfileModule.h
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2018/1/5.
//  Copyright © 2018年 daiqingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<React/RCTAssert.h>)
#import <React/RCTBridgeModule.h>
#else
#import "RCTBridgeModule.h"
#endif

#pragma mark - General

#define kACTION    @"action"
#define kMAC       @"mac"
#define kType      @"type"

#define kACTION_GET_ALL_CONNECTED_DEVICES   @"ACTION_GET_ALL_CONNECTED_DEVICES"
#define kDEVICES @"devices"

#pragma mark -  ECG3
// Error
#define kACTION_ERROR_ECG @"ACTION_ERROR_ECG"
#define kERROR_NUM_ECG  @"ERROR_NUM_ECG"
#define kERROR_DESCRIPTION_ECG   @"ERROR_DESCRIPTION_ECG"
// Battery
#define kACTION_BATTERY_ECG   @"ACTION_BATTERY_ECG"
#define kBATTERY_ECG   @"BATTERY_ECG"
// Sync time
#define kACTION_SYSTIME   @"ACTION_SYSTIME"
// Start measure
#define kACTION_MEASURE_WAVEData   @"ACTION_MEASURE_WAVEData"
#define kACTION_MEASURE_ECGPulse   @"ACTION_MEASURE_ECGPulse"
#define kMEASURE_WAVEData   @"MEASURE_WAVEData"
#define kMEASURE_ECGPulse   @"MEASURE_ECGPulse"
// Stop measure
#define kACTION_STOPMEASURE_ECG   @"ACTION_STOPMEASURE_ECG"
// Electrod status
#define kACTION_ELECTRODE_STATUS    @"ACTION_ELECTRODE_STATUS"
#define kELECTRODE_STATUS @"ELECTRODE_STATUS"

#pragma mark - ECG3USB
// Error
#define kACTION_ERROR_ECGUSB   @"ACTION_ERROR_ECGUSB"
#define kERROR_DESCRIPTION_ECGUSB   @"ERROR_DESCRIPTION_ECGUSB"
#define kERROR_NUM_ECGUSB   @"ERROR_NUM_ECGUSB"
// Sync data
#define kACTION_SYNCDATA_ECGUSB   @"ACTION_SYNCDATA_ECGUSB"
#define kACTION_STARTSYNCDATA_ECGUSB   @"ACTION_STARTSYNCDATA_ECGUSB"
#define kACTION_SYNCDATAINFO_ECGUSB   @"ACTION_SYNCDATAINFO_ECGUSB"
#define kDATAINFO   @"DATAINFO"
#define kACTION_FINISHSYNCDATA_ECGUSB   @"ACTION_FINISHSYNCDATA_ECGUSB"
#define kACTION_SYNCDATAPROGRESS_ECGUSB   @"ACTION_SYNCDATAPROGRESS_ECGUSB"
#define kPROGRESS   @"PROGRESS"
// Delete data
#define kACTION_DELETEDATA_ECGUSB   @"ACTION_DELETEDATA_ECGUSB"
// SPLICE
#define kACTION_SPLICE   @"ACTION_SPLICE"
#define kSPLICE_DATA   @"SPLICE_DATA"
#define kSPLICE_ERROR_DESCRIPTION @"SPLICE_ERROR_DESCRIPTION"
// Get cache
#define kACTION_GET_CACHE @"ACTION_GET_CACHE"
#define kGET_CACHE_DATA @"GET_CACHE_DATA"
// Filter
#define kACTION_FILTER @"ACTION_FILTER"
#define kFILTER_DATA @"FILTER_DATA"
#define kFILTER_ERROR_DESCRIPTION @"FILTER_ERROR_DESCRIPTION"

@interface ECGProfileModule : NSObject<RCTBridgeModule>

@end
