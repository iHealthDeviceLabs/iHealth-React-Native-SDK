//
//  HSProfileModule.h
//  ReactNativeIOSLibrary
//
//  Created by ihealth on 16/12/2.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<React/RCTAssert.h>)
#import <React/RCTBridgeModule.h>
#else
#import "RCTBridgeModule.h"
#endif

@interface HS2SProfileModule : NSObject<RCTBridgeModule>

#define ACTION_LIVEDATA_HS  @"liveData_hs"
#define LIVEDATA_HS  @"value"

#define ACTION_ONLINE_RESULT_HS  @"online_result_hs"
#define DATAID @"dataID"
#define WEIGHT_HS  @"value"
#define FAT_HS  @""
#define WATER_HS  @""
#define MUSCLE_HS  @""
#define SKELETON_HS  @""
#define FATELEVEL_HS  @""
#define DCI_HS  @""

#define ACTION_GET_ALL_CONNECTED_DEVICES @"action_get_all_connected_devices"
#define ACTION_HISTORICAL_DATA_HS  @"historicaldata_hs"
#define HISTORDATA_HS  @"historyData"
#define MEASUREMENT_DATE_HS  @"date"
#define ACTION_HISTORICAL_DATA_COMPLETE_HS @"finishTranslate"
#define ACTION_NO_HISTORICALDATA  @"noHistoryData"
#define BATTERY_HS @"battery_hs"
#define ACTION_BATTARY_HS  @"action_get_battery_hs"
#define ACTION_ERROR_HS  @"error_hs"
#define ERROR_NUM_HS  @"error"
#define ERROR_ID_ILLEGAL_ARGUMENT  @"400"
#define ERROR_ID_WIFI_DISABLED  @""
#define ERROR_DESCRIPTION_HS @"description"



#define ACTION_GET_HS2S_DEVICE_INFO @"action_get_device_info"

#define ACTION_SET_HS2S_UNIT  @"action_set_unit"

#define ACTION_GET_HS2S_USER_INFO  @"action_get_user_info"

#define ACTION_UPDATE_HS2S_USER_INFO  @"action_create_or_update_user_info"

#define ACTION_DELETE_HS2S_USER  @"action_delete_user_info"

#define ACTION_GET_HS2S_MEMORY_COUNT  @"action_history_data_num"

#define ACTION_GET_HS2S_MEMORY_DATA  @"action_history_data"

#define ACTION_DELETE_HS2S_MEMORY_DATA  @"action_delete_history_data"

#define ACTION_GET_HS2S_ANONYMOUS_MEMORY_COUNT  @"action_anonymous_data_num"

#define ACTION_GET_HS2S_ANONYMOUS_MEMORY_DATA  @"action_anonymous_data"

#define ACTION_DELETE_HS2S_ANONYMOUS_MEMORY_DATA  @"action_delete_anonymous_history_data"

#define ACTION_HS2S_ONLINE_DATA  @"action_online_real_time_data"

#define ACTION_HS2S_ONLINE_RESULT  @"action_online_result"

#define ACTION_HS2S_BODYFAT_RESULT  @"action_body_fat_result"

#define ACTION_ONLINE_WEIGHTANDBody_INFO  @"online_weigthandbody_info"

#define ACTION_BroadCastType_DEVICE  @"broadCastType_device"

#define ACTION_RESET_DEVICE  @"reset_device"

#define ACTION_MEASURE_FINISH  @"measure_finish"

#define HS2S_DEVICE_INFO  @"device_info"

#define HS2S_DEVICE_BATTERY  @"battery"

#define HS2S_DEVICE_UNIT  @"unit_current"

#define HS2S_DEVICE_USER_COUNT  @"user_count"

#define HS2S_USER_INFO_ARRAY  @"user_info_array"

#define HS2S_USER_INFO_COUNT  @"user_info_count"

#define HS2S_BODYBUILDING  @"body_building"

#define HS2S_IMPEDANCE  @"impedance"

#define HS2S_HEIGHT  @"height"

#define HS2S_AGE  @"age"

#define HS2S_GENDER  @"gender"

#define HS2S_WEIGTH  @"weight"

#define HS2S_CREATE_TIME  @"create_time"

#define HS2S_INSTRUCTION_TYPE  @"instruction_type"

#define HS2S_USER_ID  @"user_id"

#define MEMORY_COUNT  @"history_data_count"

#define MEMORY_DATA  @"history_data"

#define HS2S_DATA_BODY_FAT_RESULT  @"data_body_fat_result"

#define HS2S_SET_RESULT  @"result"

#define ACTION_HS2S_MEASURE_FINISH  @"action_measure_finish_at_critical"

#define ACTION_HS2S_RESET_DEVICE  @"action_restore_fatory_settings"

#define HS2S_FAT_WEIGHT  @"fat_weight"

#define HS2S_FAT_CONTROL  @"fat_control"

#define HS2S_WEIGHT_CONTROL  @"weight_control"

#define HS2S_STANDARD_WEIGHT  @"standard_weight"

#define HS2S_SKELETAL_MUSCLE_MASS  @"skeletal_muscle_mass"

#define HS2S_BODY_WATER_RATE  @"body_water_rate"

#define HS2S_MUSCLE_MASS  @"muscle_mass"

#define HS2S_MUSCLE_CONTROL  @"muscle_control"

#define HS2S_PHYSICAL_AGE  @"physical_age"

#define HS2S_VISCERAL_FAT_GRADE  @"visceral_fat_grade"

#define HS2S_PROTEIN_RATE  @"protein_rate"

#define HS2S_BONE_SALT_CONTENT  @"bone_salt_content"

#define HS2S_BODY_FIT_PERCENTAGE  @"body_fit_percentage"

#define HS2S_MEASURE_TIME  @"measure_time"


#define ACTION_HS2S_LightUp_DEVICE  @"action_lightup_settings"

#define HS2S_DEVICE_STATUS  @"device_status"

#define ACTION_HS2S_MEASURE_HEARTRATE_DEVICE_STATUS  @"action_measure_heartrate_device_status"

#define ACTION_HS2S_MEASURE_HEARTRATE  @"action_measure_heartrate"

#define HS2S_MEASURE_HEARTRATE_RESULT  @"measure_heartrate_result"


#define ACTION_HS2S_EXIT_MEASURE_HEARTRATE_STATUS  @"action_exit_measure_heartrate_status"



@end
