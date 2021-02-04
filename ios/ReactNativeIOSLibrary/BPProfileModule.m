//
//  BPProfileModule.m
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2016/11/23.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import "BPProfileModule.h"
#import "BPMacroFile.h"
@implementation BPProfileModule




RCT_EXPORT_MODULE()

#pragma mark
#pragma mark - constantsToExport


- (NSDictionary *)constantsToExport
{
    return @{
             @"ACTION_ERROR_BP":kACTION_ERROR_BP,
             @"ACTION_BATTERY_BP":kACTION_BATTERY_BP,
             @"ACTION_ZOREING_BP":kACTION_ZOREING_BP,
             @"ACTION_ZOREOVER_BP":kACTION_ZOREOVER_BP,
             @"ACTION_ONLINE_PRESSURE_BP":kACTION_ONLINE_PRESSURE_BP,
             @"ACTION_ONLINE_PULSEWAVE_BP":kACTION_ONLINE_PULSEWAVE_BP,
             @"ACTION_ONLINE_RESULT_BP":kACTION_ONLINE_RESULT_BP,
             @"ACTION_HISTORICAL_NUM_BP":kACTION_HISTORICAL_NUM_BP,
             @"ACTION_HISTORICAL_DATA_BP":kACTION_HISTORICAL_DATA_BP,
             @"ACTION_HISTORICAL_OVER_BP":kACTION_HISTORICAL_OVER_BP,
             @"ACTION_FUNCTION_INFORMATION_BP":kACTION_FUNCTION_INFORMATION_BP,
             @"ACTION_SET_UNIT_SUCCESS_BP":kACTION_SET_UNIT_SUCCESS_BP,
             @"ACTION_SET_ANGLE_SUCCESS_BP":kACTION_SET_ANGLE_SUCCESS_BP,
             @"ACTION_INTERRUPTED_BP":kACTION_INTERRUPTED_BP,
             
             @"ACTION_ENABLE_OFFLINE_BP":kACTION_ENABLE_OFFLINE_BP,
             @"ACTION_DISENABLE_OFFLINE_BP":kACTION_DISENABLE_OFFLINE_BP,
             @"ACTION_IS_ENABLE_OFFLINE":kACTION_IS_ENABLE_OFFLINE,
             
             @"ERROR_NUM_BP":kERROR_NUM_BP,
             @"BATTERY_BP":kBATTERY_BP,
             @"BLOOD_PRESSURE_BP":kBLOOD_PRESSURE_BP,
             @"FLAG_HEARTBEAT_BP":kFLAG_HEARTBEAT_BP,
             @"PULSEWAVE_BP":kPULSEWAVE_BP,
             @"HIGH_BLOOD_PRESSURE_BP":kHIGH_BLOOD_PRESSURE_BP,
             @"LOW_BLOOD_PRESSURE_BP":kLOW_BLOOD_PRESSURE_BP,
             @"PULSE_BP":kPULSE_BP,
             @"MEASUREMENT_DATE_BP":kMEASUREMENT_DATE_BP,
             @"MEASUREMENT_AHR_BP":kMEASUREMENT_AHR_BP,
             @"MEASUREMENT_HSD_BP":kMEASUREMENT_HSD_BP,
             @"MEASUREMENT_STRAT_ANGLE_BP":kMEASUREMENT_STRAT_ANGLE_BP,
             @"MEASUREMENT_ANGLE_CHANGE_BP":kMEASUREMENT_ANGLE_CHANGE_BP,
             @"MEASUREMENT_HAND_BP":kMEASUREMENT_HAND_BP,
             @"DATAID":kDATAID,
             @"IS_ENABLE_OFFLINE":kIS_ENABLE_OFFLINE,
             
             @"HISTORICAL_NUM_BP":kHISTORICAL_NUM_BP,
             @"HISTORICAL_DATA_BP":kHISTORICAL_DATA_BP,
             
             @"FUNCTION_IS_UPAIR_MEASURE":kFUNCTION_IS_UPAIR_MEASURE,
             @"FUNCTION_IS_ARM_MEASURE":kFUNCTION_IS_ARM_MEASURE,
             @"FUNCTION_HAVE_ANGLE_SENSOR":kFUNCTION_HAVE_ANGLE_SENSOR,
             @"FUNCTION_HAVE_OFFLINE":kFUNCTION_HAVE_OFFLINE,
             @"FUNCTION_HAVE_ANGLE_SETTING":kFUNCTION_HAVE_ANGLE_SETTING,
             @"FUNCTION_IS_MULTI_UPLOAD":kFUNCTION_IS_MULTI_UPLOAD,
             @"FUNCTION_HAVE_SELF_UPDATE":kFUNCTION_HAVE_SELF_UPDATE,
             @"FUNCTION_HAVE_HSD":kFUNCTION_HAVE_HSD,
             @"ERROR_DESCRIPTION_BP":kERROR_DESCRIPTION_BP,
             
             @"ACTION_ANGLE_BP":kACTION_ANGLE_BP,
             
             @"ANGLE_BP":kANGLE_BP,
             
             @"WHICH_ARM":kWHICH_ARM,
             
             @"ACTION_GET_ALL_CONNECTED_DEVICES":@"ACTION_GET_ALL_CONNECTED_DEVICES",
             };
}
+ (BOOL)requiresMainQueueSetup
{
    return YES;
}
+ (NSString*)descriptionForErrorCode:(NSInteger)errorCode{
    switch (errorCode) {
        case BPError0:
            return @"not find a suitable zero in 20s.";
        case BPError1:
            return @"not find high pressure.";
        case BPError2:
            return @"not find low pressure or the high pressure value is lower than the low pressure value.";
        case BPError3:
            return @"pressurization fast.";
        case BPError4:
            return @"pressurization slow.";
        case BPError5:
            return @"pressure exceeds 300mmHg.";
        case BPError6:
            return @"time of pressure greater than 15 mmHg exceeds 160s.";
        case BPError7:
            return @"EE read and write error.";
        case BPError8:
            return @"EE three backup data error.";
        case BPError9:
            return @"retention.";
        case BPError10:
            return @"SPAN value error.";
        case BPError11:
            return @"CRC errors.";
        case BPError12:
            return @"connect error.";
        case BPError13:
            return @"low power tips.";
        case BPError14:
            return @"device bluetooth set failed";
        case BPError15:
            return @"high or low pressure value of measurement exceeds the set upper limit.";
        case BPError16:
            return @"high or low pressure value of measurement exceeds the set lower limit.";
        case BPError17:
            return @"arm movement during the measurement over the machine set point.";
        case BPNormalError:
            return @"device error, error message displayed automatically";
        case BPOverTimeError:
            return @"abnormal communication";
        case BPNoRespondError:
            return @"abnormal communication";
        case BPBeyondRangeError:
            return @"device is out of communication range.";
        case BPDidDisconnect:
            return @"device is disconnected.";
        case BPAskToStopMeasure:
            return @"measurement has been stopped.";
        case BPDeviceBusy:
            return @"device is busy doing other things";
        case BPInputParameterError:
            return @"the argument of method is illegal.";
        case 401:
            return @"the operation is illegal";
        case 900:
            return @"iOS doesn't support disconnect normal BT devices";
    }
    return @"unknown error";
}


+ (void)sendErrorToBridge:(RCTBridge *)bridge eventNotify:(NSString*)eventNotify WithCode:(NSInteger)errorCode{
    NSDictionary*  errorDict;
    
    
    if(errorCode==BPDidDisconnect){
        
    
        errorDict = @{
                      kACTION:kACTION_ERROR_BP,
                      kERROR_DESCRIPTION_BP:[self descriptionForErrorCode:errorCode]
                      };
    
    }else{
        
        
       errorDict = @{
            kACTION:kACTION_ERROR_BP,
            kERROR_NUM_BP:@(errorCode),
            kERROR_DESCRIPTION_BP:[self descriptionForErrorCode:errorCode]
            };

    
    }
    
    [self sendEventToBridge:bridge eventNotify:eventNotify WithDict:errorDict];
}

+ (void)sendEventToBridge:(RCTBridge *)bridge eventNotify:(NSString*)eventNotify WithDict:(NSDictionary*)dict{
    [bridge.eventDispatcher sendDeviceEventWithName:eventNotify body:dict];
}


@end
