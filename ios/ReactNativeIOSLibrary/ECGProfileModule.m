//
//  ECGProfileModule.m
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2018/1/5.
//  Copyright © 2018年 daiqingquan. All rights reserved.
//

#import "ECGProfileModule.h"

@implementation ECGProfileModule

RCT_EXPORT_MODULE()

#pragma mark
#pragma mark - constantsToExport


- (NSDictionary *)constantsToExport
{
    return @{
             kACTION_GET_ALL_CONNECTED_DEVICES:kACTION_GET_ALL_CONNECTED_DEVICES,
             
             kACTION_ERROR_ECG:kACTION_ERROR_ECG,
             kERROR_NUM_ECG:kERROR_NUM_ECG,
             kERROR_DESCRIPTION_ECG:kERROR_DESCRIPTION_ECG,
              
             kACTION_BATTERY_ECG:kACTION_BATTERY_ECG,
             kBATTERY_ECG:kBATTERY_ECG,
             
             kACTION_SYSTIME:kACTION_SYSTIME,
             
             kACTION_MEASURE_WAVEData:kACTION_MEASURE_WAVEData,
             kACTION_MEASURE_ECGPulse:kACTION_MEASURE_ECGPulse,
             kMEASURE_WAVEData:kMEASURE_WAVEData,
             kMEASURE_ECGPulse:kMEASURE_ECGPulse,
             
             kACTION_STOPMEASURE_ECG:kACTION_STOPMEASURE_ECG,
             
             kACTION_ELECTRODE_STATUS:kACTION_ELECTRODE_STATUS,
             kELECTRODE_STATUS:kELECTRODE_STATUS,
             
             kACTION_ERROR_ECGUSB:kACTION_ERROR_ECGUSB,
             kERROR_NUM_ECGUSB:kERROR_NUM_ECGUSB,
             kERROR_DESCRIPTION_ECGUSB:kERROR_DESCRIPTION_ECGUSB,
             
             kACTION_SYNCDATA_ECGUSB:kACTION_SYNCDATA_ECGUSB,
             kACTION_STARTSYNCDATA_ECGUSB:kACTION_STARTSYNCDATA_ECGUSB,
             kACTION_SYNCDATAINFO_ECGUSB:kACTION_SYNCDATAINFO_ECGUSB,
             kDATAINFO:kDATAINFO,
             kACTION_FINISHSYNCDATA_ECGUSB:kACTION_FINISHSYNCDATA_ECGUSB,
             kACTION_SYNCDATAPROGRESS_ECGUSB:kACTION_SYNCDATAPROGRESS_ECGUSB,
             kPROGRESS:kPROGRESS,
             
             kACTION_DELETEDATA_ECGUSB:kACTION_DELETEDATA_ECGUSB,
             
             kACTION_SPLICE:kACTION_SPLICE,
             kSPLICE_DATA:kSPLICE_DATA,
             kSPLICE_ERROR_DESCRIPTION:kSPLICE_ERROR_DESCRIPTION,
             
             kACTION_GET_CACHE:kACTION_GET_CACHE,
             kGET_CACHE_DATA:kGET_CACHE_DATA,
             
             kACTION_FILTER:kACTION_FILTER,
             kFILTER_DATA:kFILTER_DATA,
             kFILTER_ERROR_DESCRIPTION:kFILTER_ERROR_DESCRIPTION,
             
             };
};

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

@end
