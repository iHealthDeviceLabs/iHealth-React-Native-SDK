//
//  AM3.h
//  testShareCommunication
//
//  Created by daiqingquan on 13-10-15.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMMacroFile.h"

/**
 AM3
 */
@interface AM3 : NSObject
@property (strong, nonatomic) NSString *currentUUID;
@property (strong, nonatomic) NSString *serialNumber;
@property (strong, nonatomic) NSString *firmwareVersion;

/**
 * Get device userID 
 * @param getDeviceUserIDBlock  get userID
 * @param errorBlock Communication error codes, see AM3 error descriptions.
 */
-(void)commandAM3GetDeviceUserID:(DisposeAM3GetDeviceUserIDBlock)getDeviceUserIDBlock withErrorBlock:(DisposeAM3ErrorBlock)errorBlock;


/**
 * Sync time
 * @param syncTimeBlock True: Success， False: Failed.
 * @param errorBlock Communication error codes, see AM3 error descriptions.
 */
-(void)commandAM3SyncTime:(DisposeAM3SyncTimeBlock)syncTimeBlock withErrorBlock:(DisposeAM3ErrorBlock)errorBlock;


/**
 * Set time format and nation
 * @param timeFormat  AM3TimeFormat_hh,AM3TimeFormat_HH
 * @param setTimeFormatBlock True: Success， False: Failed.
 * @param errorBlock Communication error codes, see AM3 error descriptions.
 * @Notice  Notice: Firmware version 1.1.9 and above supports this function
 */
-(void)commandAM3SetTimeFormatAndNation:(AM3TimeFormat)timeFormat withFinishResult:(DisposeAM3TimeFormatSettingBlock)setTimeFormatBlock withErrorBlock:(DisposeAM3ErrorBlock)errorBlock;

/**
 * Binding AM3 to user,Account binding requires an active internet connection.
 * @param userID userID, ranging from 1 – 2147483647.
 * @param finishResultBlock True: Success， False: Failed.
 * @param errorBlock Communication error codes, see AM3 error descriptions.
 */
-(void)commandAM3SetUserID:(NSNumber*)userID withFinishResult:(DisposeAM3SetDeviceUserIDBlock)finishResultBlock withErrorBlock:(DisposeAM3ErrorBlock)errorBlock;


/**
 * AM3 initialization,Must be called the first time to ensure that the AM3 has correct user information, goals, time, battery checks, etc.
 * @param user User information, needs to include the following：age(int)、height(cm,1-255)、weight(kg,1-255)、bmr(user basal metabolic)、sex(UserSex_Female or UserSex_Male)、activityLevel (activityLevel=1, Sedentary,spend most of day sitting.activityLevel=2, Active,spend a good part of day doing some physical activity.activityLevel=3, Very Active,spend most of day doing heavy physical activity.)
 * @param unit AM3StateUnit_mile or AM3StateUnit_km
 * @param activeGoalNumber User goal number of steps,ranging from 4 – 65535. Default is 10,000
 * @param setUserInfoFinishBlock True: Success， False: Failed.
 * @param setBMRFinishResultBlock True: Success， False: Failed.
 * @param errorBlock Communication error codes, see AM3 error descriptions.
 */
-(void)commandAM3SetUserInfo:(HealthUser *)user withUnit:(AM3StateUnit)unit withActiveGoal:(NSNumber *)activeGoalNumber withSetUserInfoFinishResult:(DisposeAM3SetUserInfoBlock)setUserInfoFinishBlock withSetBMR:(DisposeAM3SetBMRBlock)setBMRFinishResultBlock withErrorBlock:(DisposeAM3ErrorBlock)errorBlock;


/**
 * Upload AM3 data,Data type: 5 minutes of active data, total number of steps for the day, and total calories.Also includes the number of steps for the 5 minutes of motion data, total calories for the current time, calories of the steps, and total calories.
 * @param activeTransmissionBlock activeTransmission: Start uploading motion data, including parameters：Start date，yyyy-MM-dd(ActiveHistoryDateYear,ActiveHistoryDateMonth,ActiveHistoryDateDay)，ActiveStepSize：Length of each step，ActiveHistoryTotoalNum：Number of records.
 * @param activeHistoryDataBlock active data，including the following parameters：AMDate、AMCalorie、AMstepNum、AMstepSize、dataID、Start. AMDate：Workout time,AMCalorie: Current time total calories,AMStepNum：Total number of steps,dataID：data ID,Start：represents the beginning of a movement.
 * @param activeFinishTransmissionBlock Upload complete.
 * @param errorBlock Communication error codes, see AM3 error descriptions.
 */
-(void)commandAM3StartSyncActiveData:(DisposeAM3ActiveStartTransmission)activeTransmissionBlock withActiveHistoryData:(DisposeAM3ActiveHistoryData)activeHistoryDataBlock withActiveFinishTransmission:(DisposeAM3ActiveFinishTransmission)activeFinishTransmissionBlock withErrorBlock:(DisposeAM3ErrorBlock)errorBlock;


/**
 * Upload AM3 data,Data type: 5 minutes of sleep data,
 * @param sleepTransmissionBlock sleepTransmission:Start uploading sleep data,, including parameters：SleepHistoryDate、AM3SleepHistoryTotoalNum.SleepHistoryDate：Sleep start time，yyyy-MM-dd HH:mm:ss(SleepHistoryDateYear,SleepHistoryDateMonth,SleepHistoryDateDay,SleepHistoryDateHour,SleepHistoryDateMinute,SleepHistoryDateSeconds).SleepHistoryTotoalNum: Number of records
 * @param sleepHistoryDataBlock Sleep data, including the following parameters:：AMDate、SleepData、dataID.AMDate：Sleep time, SleepData: Sleep grade, 0: awake, 1: light sleep, 2: deep sleep ,dataID: data ID.
 * @param sleepFinishTransmissionBlock Upload complete.
 * @param errorBlock Communication error codes, see AM3 error descriptions.
 */
-(void)commandAM3StartSyncSleepData:(DisposeAM3SleepStartTransmission)sleepTransmissionBlock withSleepHistoryData:(DisposeAM3SleepHistoryData)sleepHistoryDataBlock withSleepFinishTransmission:(DisposeAM3SleepFinishTransmission)sleepFinishTransmissionBlock withErrorBlock:(DisposeAM3ErrorBlock)errorBlock;

/**
 * Upload AM3 data,Data type: Sync current active data
 * @param currentActiveInfoBlock Total calories and steps for today, including parameters：Step、Calories、TotalCalories.Step：Number of steps taken today.Calories：Number of calories burned today.TotalCalories：Sum calories burned and bmr today.
 * @param errorBlock Communication error codes, see AM3 error descriptions.
 */
-(void)commandAM3StartSyncCurrentActiveData:(DisposeAM3GetCurrentActiveInfo)currentActiveInfoBlock withErrorBlock:(DisposeAM3ErrorBlock)errorBlock;

/**
 * Get totoal alarm infomation
 * @param totoalAlarmInfoBlock Alarm array contains up to 3 alarms, each one needs the following parameters：AlarmId、Time、Week.AlarmId：1, 2, 3.Time：HH:mm.Week(Sun、Mon、Tue、Wed、Thu、Fri、Sat)True: On, False: Off
 * @param errorBlock Communication error codes, see AM3 error descriptions.
 */
-(void)commandAM3GetTotoalAlarmInfo:(DisposeAM3TotoalAlarmData)totoalAlarmInfoBlock withErrorBlock:(DisposeAM3ErrorBlock)errorBlock;

/**
 * Set alarm.
 * @param alarmDic Alarm information, include parameters：AlarmId、Time、IsRepeat、Switch、（Sun、Mon、Tue、Wed、Thu、Fri、Sat)
 * @param finishResultBlock True: Alarm set successfully，False: Failed.
 * @param errorBlock Communication error codes, see AM3 error descriptions.
 */
-(void)commandAM3SetAlarmDictionary:(NSDictionary *)alarmDic withFinishResult:(DisposeAM3SetAlarmBlock)finishResultBlock withErrorBlock:(DisposeAM3ErrorBlock)errorBlock;

/**
 * Delete alarm.
 * @param alarmID alarmID：1, 2, 3.
 * @param finishResultBlock True: Delete successful，False: Failed
 * @param errorBlock Communication error codes, see AM3 error descriptions.
 */
-(void)commandAM3DeleteAlarmID:(NSNumber *)alarmID withFinishResult:(DisposeAM3DeleteAlarmBlock)finishResultBlock withErrorBlock:(DisposeAM3ErrorBlock)errorBlock;


/**
 * Get reminder.
 * @param remindInfoBlock Array containing following parameters：ReminderID、Time、Switch.ReminderID：Reminder ID.Time：format HH:mm, time between reminders (HH*60+mm) minutes.Switch：Reminder on/off，True: On， False: Off.
 * @param errorBlock Communication error codes, see AM3 error descriptions.
 */
-(void)commandAM3GetReminderInfo:(DisposeAM3RemindInfoBlock)remindInfoBlock withErrorBlock:(DisposeAM3ErrorBlock)errorBlock;

/**
 * Set reminders.
 * @param reminderDic Array containing collowing parameters：Time、Switch。
 * @param finishResultBlock YES: Successfully set, NO: Failed.
 * @param errorBlock Communication error codes, see AM3 error descriptions.
 */
-(void)commandAM3SetReminderDictionary:(NSDictionary *)reminderDic withFinishResult:(DisposeAM3SetReminderBlock)finishResultBlock withErrorBlock:(DisposeAM3ErrorBlock)errorBlock;

/**
 * Get device state infomation
 * @param deviceStateInfoBlock AM status，State_wrist  (AM3 being worn on the wrist)，State_waist (AM3 worn with belt clip).
 * @param batteryBlock AM3 battery percentage, from 0～100.
 * @param errorBlock Communication error codes, see AM3 error descriptions.
 */
-(void)commandAM3GetDeviceStateInfo:(DisposeAM3StateInfoBlock)deviceStateInfoBlock withBattery:(DisposeAM3BatteryBlock)batteryBlock withErrorBlock:(DisposeAM3ErrorBlock)errorBlock;

/**
 * Restore factory settings.
 * @param resetDeviceBlock True: Success， False: Failed.
 * @param errorBlock Communication error codes, see AM3 error descriptions.
 */
-(void)commandAM3ResetDevice:(DisposeAM3ResetDeviceBlock)resetDeviceBlock  withErrorBlock:(DisposeAM3ErrorBlock)errorBlock;

/**
 * Disconnect AM3 connection.
 * @param disconnectBlock  True: Success，False: Failed.
 * @param errorBlock Communication error codes, see AM3 error descriptions.
 */
-(void)commandAM3Disconnect:(DisposeAM3DisconnectBlock)disconnectBlock withErrorBlock:(DisposeAM3ErrorBlock)errorBlock;


/**
 * Get time format
 * @param timeFormat  (AM3TimeFormat_hh,AM3TimeFormat_HH)
 * @param errorBlock Communication error codes, see AM3 error descriptions.
 * @Notice  Notice: Firmware version 1.1.9 and above supports this function
 */
-(void)commandAM3GetTimeFormat:(DisposeAM3TimeFormatBlock)timeFormat withErrorBlock:(DisposeAM3ErrorBlock)errorBlock;


/**
 * Get user infomation
 * @param userInfoBlock including parameters:Age,Step,Height,Gender,Weight,Unit,goal(TotalStep1、TotalStep2、TotalStep3)
 * @param errorBlock Communication error codes, see AM3 error descriptions.
 */
-(void)commandAM3GetUserInfo:(DisposeAM3UserInfoBlock)userInfoBlock withErrorBlock:(DisposeAM3ErrorBlock)errorBlock;

/**
 * Set state model
 * @param state including AM3SetStateModel_sleep,AM3SetStateModel_active,AM3SetStateModel_fly,AM3SetStateModel_drive
 * @param finishResultBlock True: Delete successful，False: Failed
 * @param errorBlock Communication error codes, see AM3 error descriptions.
 * @Notice  Notice: Firmware version 1.1.1 and above supports AM3SetStateModel_drive
 */
-(void)commandAM3SetStateModel:(AM3StateModel)state withFinishResult:(DisposeAM3SetStateModelBlock)finishResultBlock withErrorBlock:(DisposeAM3ErrorBlock)errorBlock;


/**
 * Set BMR
 * @param bmr ranging from 0 – 5000.
 * @param finishResultBlock True: Delete successful，False: Failed
 * @param errorBlock Communication error codes, see AM3 error descriptions.
 * @Notice  Notice: Firmware version 1.0.2 and above supports this function
 */
-(void)commandAM3SetBMR:(NSNumber *)bmr withFinishResult:(DisposeAM3SetBMRBlock)finishResultBlock withErrorBlock:(DisposeAM3ErrorBlock)errorBlock;
@end
