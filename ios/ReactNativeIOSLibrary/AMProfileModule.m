//
//  AMProfileModule.m
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2016/11/23.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import "AMProfileModule.h"
                
@implementation AMProfileModule

RCT_EXPORT_MODULE()

#pragma mark
#pragma mark - constantsToExport

- (NSDictionary *)constantsToExport

{
    return @{
             
             @"ACTION_ERROR_AM":@"error_am",
             
             
             @"ACTION_RESET_AM":@"reset_am",
             @"ACTION_USERID_AM":@"userid_am",
             @"ACTION_SET_USERID_SUCCESS_AM":@"set_userid_success_am",
             @"ACTION_SYNC_TIME_SUCCESS_AM":@"set_sync_time_success_am",
             @"ACTION_SET_USERINFO_SUCCESS_AM":@"set_userinfo_success_am",
             @"ACTION_GET_USERINFO_AM":@"get_userinfo_am",
             @"ACTION_GET_ALARMNUM_AM":@"get_alarmnum_am",
             @"ACTION_GET_ALARMINFO_AM":@"get_alarminfo_am",
             @"ACTION_SET_ALARMINFO_SUCCESS_AM":@"set_alarminfo_success_am",
             @"ACTION_DELETE_ALARM_SUCCESS_AM":@"delete_alarm_success_am",
             @"ACTION_GET_ACTIVITY_REMIND_AM":@"get_activity_remind_am",
             @"ACTION_SET_ACTIVITYREMIND_SUCCESS_AM":@"set_activityremind_success_am",
             @"ACTION_SYNC_ACTIVITY_DATA_AM":@"sync_activity_data_am",
             @"ACTION_SYNC_SLEEP_DATA_AM":@"sync_sleep_data_am",
             @"ACTION_SYNC_STAGE_DATA_AM":@"sync_stage_data_am",
             @"ACTION_SYNC_REAL_DATA_AM":@"sync_real_data_am",
             @"ACTION_QUERY_STATE_AM":@"query_state_am",
             @"ACTION_SET_BMR_SUCCESS_AM":@"set_bmr_success_am",
             @"ACTION_GET_RANDOM_AM":@"get_random_am",
             @"ACTION_SET_SWIMINFO_AM":@"set_swiminfo_am",
             @"ACTION_GET_SWIMINFO_AM":@"get_swiminfo_am",
             @"ACTION_SET_HOUR_MODE_SUCCESS_AM":@"set_hour_mode_success_am",
             @"ACTION_GET_HOUR_MODE_AM":@"get_hour_mode_am",

             
             @"ACTION_SET_DEVICE_MODE_AM":@"set_device_mode_am",
             @"ACTION_SET_PICTURE_SUCCESS_AM":@"set_picture_success_am",
             @"ACTION_GET_PICTURE_AM":@"get_picture_am",
             
             @"ACTION_CLOUD_BINDING_AM_SUCCESS":@"cloud_bind_am_success",
             @"ACTION_CLOUD_BINDING_AM_FAIL":@"cloud_bind_am_fail",
             @"ACTION_CLOUD_UNBINDING_AM_SUCCESS":@"cloud_unbind_am_success",
             @"ACTION_CLOUD_UNBINDING_AM_FAIL":@"cloud_unbind_am_fail",
             @"ACTION_CLOUD_SEARCH_AM":@"cloud_search_am",
             @"ACTION_CLOUD_SEARCH_FAIL_AM":@"cloud_search_fail",
             @"ACTION_GET_ALL_CONNECTED_DEVICES":@"ACTION_GET_ALL_CONNECTED_DEVICES",
             
             
             
             @"ERROR_NUM_AM":@"error",
             @"ERROR_DESCRIPTION_AM":@"description",

             
             @"ERROR_ID_ILLEGAL_ARGUMENT":@"ERROR_ID_ILLEGAL_ARGUMENT",
             @"ERROR_ID_VERSION_NOT_SUPPORT":@"ERROR_ID_VERSION_NOT_SUPPORT",
             
             @"RESET_AM":@"reset",
             @"USERID_AM":@"userid",
             @"GET_USER_AGE_AM":@"age",
             @"GET_USER_STEP_AM":@"step",
             @"GET_USER_HEIGHT_AM":@"height",
             @"GET_USER_SEX_AM":@"gender",
             @"GET_USER_WEIGHT_AM":@"weight",
             @"GET_USER_UNIT_AM":@"unit",
             @"GET_USER_TARGET1_AM":@"target1",
             @"GET_USER_TARGET2_AM":@"target2",
             @"GET_USER_TARGET3_AM":@"target3",
             @"GET_USER_SWIMTARGET_AM":@"swim_target",
             @"GET_ALARMNUM_AM":@"alarmclocknumber",
             @"GET_ALARMNUM_ID_AM":@"alarmclocknumberid",
             @"GET_ALARM_CLOCK_DETAIL":@"alarmclockdetail",
             @"GET_ALARM_ID_AM":@"alarmid",
             @"GET_ALARM_TIME_AM":@"time",
             @"GET_ALARM_ISREPEAT_AM":@"repeat",
             @"GET_ALARM_WEEK_AM":@"get_alarm_week",
             @"GET_ALARM_WEEK_SUNDAY_AM":@"sun",
             @"GET_ALARM_WEEK_MONDAY_AM":@"mon",
             @"GET_ALARM_WEEK_TUESDAY_AM":@"tue",
             @"GET_ALARM_WEEK_WEDNESDAY_AM":@"wed",
             @"GET_ALARM_WEEK_THURSDAY_AM":@"thu",
             @"GET_ALARM_WEEK_FRIDAY_AM":@"fri",
             @"GET_ALARM_WEEK_SATURDAY_AM":@"sat",
             @"GET_ALARM_ISON_AM":@"switch",
             @"GET_ACTIVITY_REMIND_TIME_AM":@"time",
             @"GET_ACTIVITY_REMIND_ISON_AM":@"switch",
             @"SYNC_ACTIVITY_DATA_AM":@"activity",
             @"SYNC_ACTIVITY_DATA_TIME_AM":@"time",
             @"SYNC_ACTIVITY_DATA_STEP_AM":@"step",
             @"SYNC_ACTIVITY_DATA_STEP_LENGTH_AM":@"stepsize",
             @"SYNC_ACTIVITY_DATA_CALORIE_AM":@"calorie",
             @"SYNC_ACTIVITY_EACH_DATA_AM":@"activity_each_data",
             @"DATAID":@"dataID",
             @"SYNC_SLEEP_DATA_AM":@"sleep",
             @"SYNC_SLEEP_DATA_TIME_AM":@"time",
             @"SYNC_SLEEP_DATA_LEVEL_AM":@"level",
             @"SYNC_SLEEP_EACH_DATA_AM":@"sleep_each_data",
             @"SYNC_STAGE_DATA_AM":@"stage_data",
             @"SYNC_STAGE_DATA_TYPE_WORKOUT_AM":@"stage_data_type_workout",
             @"SYNC_STAGE_DATA_TYPE_AM":@"type",
             @"SYNC_STAGE_DATA_WORKOUT_STEP_AM":@"stage_data_workout_step",
             @"SYNC_STAGE_DATA_STOP_TIME_AM":@"stoptime",
             @"SYNC_STAGE_DATA_USED_TIME_AM":@"usedtime",
             @"SYNC_STAGE_DATA_DISTANCE_AM":@"stage_data_distance",
             @"SYNC_STAGE_DATA_CALORIE_AM":@"calorie",
             @"SYNC_STAGE_DATA_SWIM_CUTINDIF_AM":@"stage_data_cutindif",
             @"SYNC_STAGE_DATA_TYPE_SWIM_AM":@"swim",
             @"SYNC_STAGE_DATA_SWIM_PULL_TIMES_AM":@"number of strokes",
             @"SYNC_STAGE_DATA_SWIM_STROKE_AM":@"swimming stroke",
             @"SYNC_STAGE_DATA_SWIM_TURNS_AM":@"number of turns",
             @"SYNC_STAGE_DATA_SWIMPOOL_LENGTH_AM":@"stage_data_swimpool_length",
             @"SYNC_STAGE_DATA_SWIM_CUTOUTDIF_AM":@"stage_data_cutoutdif",
             @"SYNC_STAGE_DATA_SWIM_PROCESSFLAG_AM":@"stage_data_processflag",
             @"SYNC_STAGE_DATA_TYPE_SLEEP_AM":@"sleep",
             @"SYNC_STAGE_DATA_SLEEP_EFFICIENCY_AM":@"sleepefficiency",
             @"SYNC_STAGE_DATA_SLEEP_IS50MIN_AM":@"is50min",
             @"SYNC_STAGE_DATA_TYPE_PAGE_VIEW_SUMMARY":@"page_view_summary",
             @"SYNC_STAGE_DATA_VIEW_SUMMARY_DATE_AM":@"stage_data_view_summary_date",
             @"SYNC_STAGE_DATA_VIEW_SUMMARY_STEP_AM":@"stage_data_view_summary_step",
             @"SYNC_STAGE_DATA_VIEW_SUMMARY_DISTANCE_AM":@"stage_data_view_summary_distance",
             @"SYNC_STAGE_DATA_VIEW_SUMMARY_CALORIE_AM":@"stage_data_view_summary_calorie",
             @"SYNC_STAGE_DATA_VIEW_SUMMARY_TARGET_AM":@"stage_data_view_summary_target",
             @"SYNC_STAGE_DATA_VIEW_SUMMARY_SWIM_AM":@"stage_data_view_summary_swim",
             @"SYNC_REAL_STEP_AM":@"step",
             @"SYNC_REAL_CALORIE_AM":@"calorie",
             @"SYNC_REAL_TOTALCALORIE_AM":@"totalcalories",
             @"QUERY_STATE_AM":@"query_state",
             @"QUERY_BATTERY_AM":@"battery",
             @"GET_RANDOM_AM":@"random",
             @"GET_SWIMLANE_LENGTH_AM":@"get_swimlane_length",
             @"GET_SWIM_UNIT_AM":@"get_swim_unit_am",
             @"GET_SWIM_SWITCH_AM":@"get_swim_switch_am",
             @"GET_SWIM_CUTOUT_HOUR_AM":@"get_swim_cutout_hour_am",
             @"GET_SWIM_CUTOUT_MINUTE_AM":@"get_swim_cutout_min_am",
             @"GET_PICTURE_AM":@"get_picture_am",

             
        
             @"AM_SET_MALE":@1,
             @"AM_SET_FEMALE":@0,
             @"AM_SET_UNIT_METRIC":@1,
             @"AM_SET_UNIT_IMPERIAL_STANDARD":@0,
             @"AM_SET_12_HOUR_MODE":@0,
             @"AM_SET_24_HOUR_MODE":@1,
             @"AM_SET_EUROPE_12_HOUR_MODE":@3,
             @"AM_SET_EUROPE_24_HOUR_MODE":@5,
             @"AM_SET_EXCEPT_EUROPE_12_HOUR_MODE":@2,
             @"AM_SET_EXCEPT_EUROPE_24_HOUR_MODE":@4,
             @"GET_HOUR_MODE_AM":@"hourtype",
             @"AM_DEVICE_MODE_SLEEP":@0,
             @"AM_DEVICE_MODE_ACTIVITY":@1,
             @"AM_DEVICE_MODE_FLIGHT":@2,
             @"AM_DEVICE_MODE_DRIVING":@3,
             };
};




+ (BOOL)requiresMainQueueSetup
{
    return YES;
}






































































@end
