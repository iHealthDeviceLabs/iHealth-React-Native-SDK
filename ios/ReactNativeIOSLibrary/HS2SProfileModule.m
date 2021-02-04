//
//  HSProfileModule.m
//  ReactNativeIOSLibrary
//
//  Created by ihealth on 16/12/2.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import "HS2SProfileModule.h"

@implementation HS2SProfileModule

RCT_EXPORT_MODULE()

#pragma mark
#pragma mark - constantsToExport
@synthesize bridge = _bridge;

-(NSDictionary *)constantsToExport{
    return @{
             @"ACTION_LIVEDATA_HS" : ACTION_LIVEDATA_HS,
             @"LIVEDATA_HS" : LIVEDATA_HS,
             
             @"ACTION_ONLINE_RESULT_HS" : ACTION_ONLINE_RESULT_HS,
             @"DATAID" : DATAID,
             @"WEIGHT_HS" : WEIGHT_HS,
             @"FAT_HS" : FAT_HS,
             @"WATER_HS" : WATER_HS,
             @"MUSCLE_HS" : MUSCLE_HS,
             @"SKELETON_HS" : SKELETON_HS,
             @"FATELEVEL_HS" : FATELEVEL_HS,
             @"DCI_HS" : DCI_HS,
             
             
             @"ACTION_HISTORICAL_DATA_HS" : ACTION_HISTORICAL_DATA_HS,
             @"HISTORDATA_HS" :HISTORDATA_HS,
             @"MEASUREMENT_DATE_HS" : MEASUREMENT_DATE_HS,
             @"ACTION_HISTORICAL_DATA_COMPLETE_HS" :ACTION_HISTORICAL_DATA_COMPLETE_HS,
             @"ACTION_NO_HISTORICALDATA" : ACTION_NO_HISTORICALDATA,
             
             @"ACTION_ERROR_HS" : ACTION_ERROR_HS,
             @"ERROR_NUM_HS" : ERROR_NUM_HS,
             @"ERROR_ID_ILLEGAL_ARGUMENT" : ERROR_ID_ILLEGAL_ARGUMENT,
             @"ERROR_ID_WIFI_DISABLED" : ERROR_ID_WIFI_DISABLED,
             @"ERROR_DESCRIPTION_HS" : ERROR_DESCRIPTION_HS,
             
             @"ACTION_GET_ALL_CONNECTED_DEVICES":ACTION_GET_ALL_CONNECTED_DEVICES,
             
             @"ACTION_BATTERY_HS":ACTION_BATTARY_HS,
             @"BATTERY_HS":BATTERY_HS,
             
             @"ACTION_GET_HS2S_DEVICE_INFO":ACTION_GET_HS2S_DEVICE_INFO,
             
             @"ACTION_SET_HS2S_UNIT":ACTION_SET_HS2S_UNIT,
             
             @"HS2S_DEVICE_INFO":HS2S_DEVICE_INFO,
             
             @"HS2S_SET_RESULT":HS2S_SET_RESULT,
             
             @"ACTION_GET_HS2S_USER_INFO":ACTION_GET_HS2S_USER_INFO,
             
             @"HS2S_USER_INFO_ARRAY":HS2S_USER_INFO_ARRAY,
             
             @"HS2S_USER_INFO_COUNT":HS2S_USER_INFO_COUNT,
             
             @"ACTION_UPDATE_HS2S_USER_INFO":ACTION_UPDATE_HS2S_USER_INFO,
             
             @"ACTION_DELETE_HS2S_USER":ACTION_DELETE_HS2S_USER,
             
             @"ACTION_GET_HS2S_MEMORY_COUNT":ACTION_GET_HS2S_MEMORY_COUNT,
             
             @"MEMORY_COUNT":MEMORY_COUNT,
             
             @"ACTION_GET_HS2S_MEMORY_DATA":ACTION_GET_HS2S_MEMORY_DATA,
             
             @"MEMORY_DATA":MEMORY_DATA,
             
             @"ACTION_GET_HS2S_ANONYMOUS_MEMORY_COUNT":ACTION_GET_HS2S_ANONYMOUS_MEMORY_COUNT,
             
             @"ACTION_GET_HS2S_ANONYMOUS_MEMORY_DATA":ACTION_GET_HS2S_ANONYMOUS_MEMORY_DATA,
             
             @"ACTION_DELETE_HS2S_ANONYMOUS_MEMORY_DATA":ACTION_DELETE_HS2S_ANONYMOUS_MEMORY_DATA,
             
             @"ACTION_ONLINE_WEIGHTANDBody_INFO":ACTION_ONLINE_WEIGHTANDBody_INFO,
             
             @"ACTION_MEASURE_FINISH":ACTION_MEASURE_FINISH,
             
             @"ACTION_RESET_DEVICE":ACTION_RESET_DEVICE,
             
             @"ACTION_BroadCastType_DEVICE":ACTION_BroadCastType_DEVICE,
             
             @"HS2S_DEVICE_BATTERY":HS2S_DEVICE_BATTERY,
             
             @"HS2S_DEVICE_UNIT":HS2S_DEVICE_UNIT,
             
             @"HS2S_DEVICE_USER_COUNT":HS2S_DEVICE_USER_COUNT,
             
             @"HS2S_BODYBUILDING":HS2S_BODYBUILDING,
             
             @"HS2S_IMPEDANCE":HS2S_IMPEDANCE,
             
             @"HS2S_HEIGHT":HS2S_HEIGHT,
             
             @"HS2S_AGE":HS2S_AGE,
             
             @"HS2S_GENDER":HS2S_GENDER,
             
             @"HS2S_WEIGTH":HS2S_WEIGTH,
             
             @"HS2S_CREATE_TIME":HS2S_CREATE_TIME,
             
             @"HS2S_USER_ID":HS2S_USER_ID,
             
             @"HS2S_INSTRUCTION_TYPE":HS2S_INSTRUCTION_TYPE,
             
             @"HS2S_DATA_BODY_FAT_RESULT":HS2S_DATA_BODY_FAT_RESULT,
             
             @"ACTION_HS2S_ONLINE_DATA":ACTION_HS2S_ONLINE_DATA,
             
             @"ACTION_HS2S_ONLINE_RESULT":ACTION_HS2S_ONLINE_RESULT,
             
             @"ACTION_HS2S_BODYFAT_RESULT":ACTION_HS2S_BODYFAT_RESULT,
             
             @"ACTION_HS2S_MEASURE_FINISH":ACTION_HS2S_MEASURE_FINISH,
             
             @"ACTION_HS2S_RESET_DEVICE":ACTION_HS2S_RESET_DEVICE,
             
             @"HS2S_FAT_WEIGHT":HS2S_FAT_WEIGHT,
             
             @"HS2S_FAT_CONTROL":HS2S_FAT_CONTROL,
             
             @"HS2S_WEIGHT_CONTROL":HS2S_WEIGHT_CONTROL,
             
             @"HS2S_WEIGHT_CONTROL":HS2S_WEIGHT_CONTROL,
             
             @"HS2S_STANDARD_WEIGHT":HS2S_STANDARD_WEIGHT,
             
             @"HS2S_SKELETAL_MUSCLE_MASS":HS2S_SKELETAL_MUSCLE_MASS,
             
             @"HS2S_BODY_WATER_RATE":HS2S_BODY_WATER_RATE,
             
             @"HS2S_MUSCLE_MASS":HS2S_MUSCLE_MASS,
             
             @"HS2S_MUSCLE_CONTROL":HS2S_MUSCLE_CONTROL,
             
             @"HS2S_PHYSICAL_AGE":HS2S_PHYSICAL_AGE,
             
             @"HS2S_VISCERAL_FAT_GRADE":HS2S_VISCERAL_FAT_GRADE,
             
             @"HS2S_PROTEIN_RATE":HS2S_PROTEIN_RATE,
             
             @"HS2S_BONE_SALT_CONTENT":HS2S_BONE_SALT_CONTENT,
             
             @"HS2S_BODY_FIT_PERCENTAGE":HS2S_BODY_FIT_PERCENTAGE,
             
             @"HS2S_MEASURE_TIME":HS2S_MEASURE_TIME,
             
             };

}


+ (BOOL)requiresMainQueueSetup
{
    return YES;
}
@end
