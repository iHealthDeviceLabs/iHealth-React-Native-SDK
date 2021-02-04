//
//  AM3S_V2.h
//  iHealthDemoCode
//
//  Created by user on 16/8/12.
//  Copyright © 2016年 zhiwei jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMMacroFile.h"
/**
 AM3S_V2
 */
@interface AM3S_V2 : NSObject
@property (strong, nonatomic) NSMutableString *am3SRandomString;
@property (strong, nonatomic) NSString *currentUUID;
@property (strong, nonatomic) NSString *serialNumber;
@property (strong, nonatomic) NSString *firmwareVersion;



/**
 * Get device userID
 * @param getDeviceUserIDBlock  get userID
 * @param errorBlock Communication error codes, see AM3S error descriptions.
 */
-(void)commandAM3SGetDeviceUserID:(DisposeAM3SGetDeviceUserIDBlock)getDeviceUserIDBlock withErrorBlock:(DisposeAM3SErrorBlock)errorBlock;



/**
 * Set RandomNumber
 * @param setRandomNumberBlock randomNumber
 * @param errorBlock Communication error codes, see AM3S error descriptions.
 */
-(void)commandAM3SSetRandomNumber:(DisposeAM3SSetRandomNumberBlock)setRandomNumberBlock withErrorBlock:(DisposeAM3SErrorBlock)errorBlock;


/**
 * Sync time
 * @param syncTimeBlock True: Success， False: Failed.
 * @param errorBlock Communication error codes, see AM3S error descriptions.
 */
-(void)commandAM3SSyncTime:(DisposeAM3SSyncTimeBlock)syncTimeBlock withErrorBlock:(DisposeAM3SErrorBlock)errorBlock;

/**
 * Set time format and nation
 * @param timeFormatAndNation AM3STimeFormat_hh,AM3STimeFormat_HH,AM3STimeFormat_NoEuropeAndhh,AM3STimeFormat_EuropeAndhh,AM3STimeFormat_NoEuropeAndHH,AM3STimeFormat_EuropeAndHH,
 * @param setTimeFormatBlock True: Success， False: Failed.
 * @param errorBlock Communication error codes, see AM3S error descriptions.
 * @Notice  Notice: Firmware version 1.0.0 and above supports AM3STimeFormat_NoEuropeAndhh,AM3STimeFormat_EuropeAndhh,AM3STimeFormat_NoEuropeAndHH,AM3STimeFormat_EuropeAndHH,
 */
-(void)commandAM3SSetTimeFormatAndNation:(AM3STimeFormatAndNation)timeFormatAndNation withFinishResult:(DisposeAM3STimeFormatAndNationSettingBlock)setTimeFormatBlock withErrorBlock:(DisposeAM3SErrorBlock)errorBlock;

/**
 * Binding AM3S to user,Account binding requires an active internet connection.
 * @param userID userID, ranging from 1 – 2147483647.
 * @param finishResultBlock True: Success， False: Failed.
 * @param errorBlock Communication error codes, see AM3S error descriptions.
 */
-(void)commandAM3SSetUserID:(NSNumber*)userID withFinishResult:(DisposeAM3SSetDeviceUserIDBlock)finishResultBlock withErrorBlock:(DisposeAM3SErrorBlock)errorBlock;

/**
 * AM3S initialization,Must be called the first time to ensure that the AM3S has correct user information, goals, time, battery checks, etc.
 * @param user User information, needs to include the following：age(int)、height(cm,1-255)、weight(kg,1-255)、bmr(user basal metabolic)、sex(UserSex_Female or UserSex_Male)、activityLevel (activityLevel=1, Sedentary,spend most of day sitting.activityLevel=2, Active,spend a good part of day doing some physical activity.activityLevel=3, Very Active,spend most of day doing heavy physical activity.)
 * @param unit AM3SKmUnit_mile or AM3SKmUnit_km
 * @param activeGoalNumber User goal number of steps,ranging from 4 – 2147483647. Default is 10,000
 * @param setUserInfoFinishBlock True: Success， False: Failed.
 * @param setBMRfinishResultBlock True: Success， False: Failed.
 * @param errorBlock Communication error codes, see AM3S error descriptions.
 */

-(void)commandAM3SSetUserInfo:(HealthUser *)user withUnit:(AM3SKmUnit)unit withActiveGoal:(NSNumber *)activeGoalNumber withSetUserInfoFinishResult:(DisposeAM3SSetUserInfoBlock)setUserInfoFinishBlock withSetBMR:(DisposeAM3SSetBMRBlock)setBMRfinishResultBlock withErrorBlock:(DisposeAM3SErrorBlock)errorBlock;





/**
 * Upload AM3S data,Data type: 5 minutes of active data, total number of steps for the day, and total calories.Also includes the number of steps for the 5 minutes of motion data, total calories for the current time, calories of the steps, and total calories.
 * @param activeTransmissionBlock activeTransmission: Start uploading motion data, including parameters：Start date，yyyy-MM-dd(ActiveHistoryDateYear,ActiveHistoryDateMonth,ActiveHistoryDateDay)，ActiveStepSize：Length of each step，ActiveHistoryTotoalNum：Number of records.
 * @param activeHistoryDataBlock active data，including the following parameters：AMDate、AMCalorie、AMstepNum、AMstepSize、dataID、Start. AMDate：Workout time,AMCalorie: Current time total calories,AMStepNum：Total number of steps,dataID：data ID,Start：represents the beginning of a movement.
 * @param activeFinishTransmissionBlock Upload complete.
 * @param errorBlock Communication error codes, see AM3S error descriptions.
 */
-(void)commandAM3SStartSyncActiveData:(DisposeAM3SActiveStartTransmission)activeTransmissionBlock
               withActiveHistoryData:(DisposeAM3SActiveHistoryData)activeHistoryDataBlock
        withActiveFinishTransmission:(DisposeAM3SActiveFinishTransmission)activeFinishTransmissionBlock withErrorBlock:(DisposeAM3SErrorBlock)errorBlock;
/**
 * Upload AM3S data,Data type: 5 minutes of sleep data
 * @param sleepTransmissionBlock sleepTransmission:Start uploading sleep data,, including parameters：SleepHistoryDate、AM3SSleepHistoryTotoalNum.SleepHistoryDate：Sleep start time，yyyy-MM-dd HH:mm:ss(SleepHistoryDateYear,SleepHistoryDateMonth,SleepHistoryDateDay,SleepHistoryDateHour,SleepHistoryDateMinute,SleepHistoryDateSeconds).SleepHistoryTotoalNum: Number of records
 * @param sleepHistoryDataBlock Sleep data, including the following parameters:：AMDate、SleepData、dataID.AMDate：Sleep time, SleepData: Sleep grade, 0: awake, 1: light sleep, 2: deep sleep ,dataID: data ID.
 * @param sleepFinishTransmissionBlock Upload complete.
 * @param errorBlock Communication error codes, see AM3S error descriptions.
 */
-(void)commandAM3SStartSyncSleepData:(DisposeAM3SSleepStartTransmission)sleepTransmissionBlock withSleepHistoryData:(DisposeAM3SSleepHistoryData)sleepHistoryDataBlock
        withSleepFinishTransmission:(DisposeAM3SSleepFinishTransmission)sleepFinishTransmissionBlock withErrorBlock:(DisposeAM3SErrorBlock)errorBlock;

/**
 * Upload AM3S data,Data type: Sync current active data
 * @param currentActiveInfoBlock Total calories and steps for today, including parameters：Step、Calories、TotalCalories.Step：Number of steps taken today.Calories：Number of calories burned today.TotalCalories：Sum calories burned and bmr today.
 * @param errorBlock Communication error codes, see AM3S error descriptions.
 */
-(void)commandAM3SStartSyncCurrentActiveData:(DisposeAM3SGetCurrentActiveInfo)currentActiveInfoBlock withErrorBlock:(DisposeAM3SErrorBlock)errorBlock;



/**
 * Upload AM3S report data.
 * @param stageDataBlock Report data, including parameters:ReportStage_Work_out(1)、ReportStage_Sleep_summary(2).ReportStage_Work_out:Report Stage active,including parameters:Work_outCalories(Workout calories burned)、Work_outLengthNumber(Workout distance)、Work_outMeasureDate(Start time)、Work_outStepNumber(Workout number of steps)、Work_outTimeNumber(Length of workout)、dataID(data ID).ReportStage_Sleep_summary:Report Stage sleep,including parameters:Sleep_summaryMeasureDate（Sleep start time）、Sleep_summarySleepTime（Sleep duration）、Sleep_summarysleepAddMinute（Correct sleep duration length）、Sleep_summarysleepEfficiency（Sleep efficiency percentage, range is 0-100）
 * @param stageDataFinishTransmissionBlock YES: Success，NO: Failed.
 * @param errorBlock Communication error codes, see AM3S error descriptions.
 */
-(void)commandAM3SStartSyncStageData:(DisposeAM3SStageMeasureDataBlock)stageDataBlock withStageDataFinishTransmission:(DisposeAM3SStageMeasureFinishBlock)stageDataFinishTransmissionBlock withErrorBlock:(DisposeAM3SErrorBlock)errorBlock;


/**
 * Get totoal alarm infomation
 * @param totoalAlarmInfoBlock Alarm array contains up to 3 alarms, each one needs the following parameters：AlarmId、Time、Week.AlarmId：1, 2, 3.Time：HH:mm.Week(Sun、Mon、Tue、Wed、Thu、Fri、Sat)True: On, False: Off
 * @param errorBlock Communication error codes, see AM3S error descriptions.
 */
-(void)commandAM3SGetTotoalAlarmInfo:(DisposeAM3STotoalAlarmData)totoalAlarmInfoBlock withErrorBlock:(DisposeAM3SErrorBlock)errorBlock;

/**
 * Set alarm.
 * @param alarmDic Alarm information, include parameters：AlarmId(1、2、3)、Time、IsRepeat、Switch、Week（Sun、Mon、Tue、Wed、Thu、Fri、Sat)
 * @param finishResultBlock True: Alarm set successfully，False: Failed.
 * @param errorBlock Communication error codes, see AM3S error descriptions.
 */
-(void)commandAM3SSetAlarmDictionary:(NSDictionary *)alarmDic withFinishResult:(DisposeAM3SSetAlarmBlock)finishResultBlock withErrorBlock:(DisposeAM3SErrorBlock)errorBlock;


/**
 * Delete alarm.
 * @param alarmID alarmID：1, 2, 3.
 * @param finishResultBlock True: Delete successful，False: Failed
 * @param errorBlock Communication error codes, see AM3S error descriptions.
 */
-(void)commandAM3SDeleteAlarmID:(NSNumber *)alarmID withFinishResult:(DisposeAM3SDeleteAlarmBlock)finishResultBlock withErrorBlock:(DisposeAM3SErrorBlock)errorBlock;

/**
 * Get reminder.
 * @param remindInfoBlock Array containing following parameters：ReminderID、Time、Switch.ReminderID：Reminder ID.Time：format HH:mm, time between reminders (HH*60+mm) minutes.Switch：Reminder on/off，True: On， False: Off.
 * @param errorBlock Communication error codes, see AM3S error descriptions.
 */
-(void)commandAM3SGetReminderInfo:(DisposeAM3SRemindInfoBlock)remindInfoBlock withErrorBlock:(DisposeAM3SErrorBlock)errorBlock;

/**
 * Set reminders.
 * @param reminderDic Array containing collowing parameters：Time、Switch。
 * @param finishResultBlock YES: Successfully set, NO: Failed.
 * @param errorBlock Communication error codes, see AM3S error descriptions.
 */
-(void)commandAM3SSetReminderDictionary:(NSDictionary *)reminderDic withFinishResult:(DisposeAM3SSetReminderBlock)finishResultBlock withErrorBlock:(DisposeAM3SErrorBlock)errorBlock;



/**
 * Get device state infomation
 * @param deviceStateInfoBlock AM status，State_wrist  (AM3S being worn on the wrist)，State_waist (AM3S worn with belt clip).
 * @param batteryBlock AM battery percentage, from 0～100.
 * @param errorBlock Communication error codes, see AM3S error descriptions.
 */
-(void)commandAM3SGetDeviceStateInfo:(DisposeAM3SStateInfoBlock)deviceStateInfoBlock withBattery:(DisposeAM3SBatteryBlock)batteryBlock withErrorBlock:(DisposeAM3SErrorBlock)errorBlock;

/**
 * Restore factory settings.
 * @param resetDeviceBlock True: Success， False: Failed.
 * @param errorBlock Communication error codes, see AM3S error descriptions.
 */
-(void)commandAM3SResetDevice:(DisposeAM3SResetDeviceBlock)resetDeviceBlock withErrorBlock:(DisposeAM3SErrorBlock)errorBlock;

/**
 * Disconnect AM3S connection.
 * @param disconnectBlock  True: Success，False: Failed.
 * @param errorBlock Communication error codes, see AM3S error descriptions.
 */
-(void)commandAM3SDisconnect:(DisposeAM3SDisconnectBlock)disconnectBlock withErrorBlock:(DisposeAM3SErrorBlock)errorBlock;


/**
 * Get time format and nation
 * @param timeAndNationBlock  (AM3STimeFormat_hh,AM3STimeFormat_HH,AM3STimeFormat_NoEuropeAndhh,AM3STimeFormat_EuropeAndhh,AM3STimeFormat_NoEuropeAndHH,AM3STimeFormat_EuropeAndHH)
 * @param errorBlock Communication error codes, see AM3S error descriptions.
 */
-(void)commandAM3SGetTimeFormatAndNation:(DisposeAM3STimeFormatAndNationBlock)timeAndNationBlock withErrorBlock:(DisposeAM3SErrorBlock)errorBlock;




/**
 * Get user infomation
 * @param userInfoBlock including parameters:Age,Step,Height,Gender,Weight,Unit,goal(TotalStep1、TotalStep2、TotalStep3)
 * @param errorBlock Communication error codes, see AM3S error descriptions.
 */
-(void)commandAM3SGetUserInfo:(DisposeAM3SUserInfoBlock)userInfoBlock withErrorBlock:(DisposeAM3SErrorBlock)errorBlock;



/**
 * Set BMR
 * @param bmr ranging from 0 – 5000.
 * @param finishResultBlock True: Delete successful，False: Failed
 * @param errorBlock Communication error codes, see AM3S error descriptions.
 */
-(void)commandAM3SSetBMR:(NSNumber *)bmr withFinishResult:(DisposeAM3SSetBMRBlock)finishResultBlock withErrorBlock:(DisposeAM3SErrorBlock)errorBlock;





/**
 * Get Picture.
 * @param pictureBlock Picture_one,Picture_two
 * @param errorBlock Communication error codes, see AM3S error descriptions.
 */
-(void)commandAM3SGetPicture:(DisposeAM3SGetPictureBlock)pictureBlock withErrorBlock:(DisposeAM3SErrorBlock)errorBlock;

/**
 * Set Picture.
 * @param pictures Picture_one,Picture_two
 * @param finishResultBlock True: Success，False: Failed.
 * @param errorBlock Communication error codes, see AM3S error descriptions.
 */
-(void)commandAM3SSetPicture:(AM3SPicture)pictures withFinishResult:(DisposeAM3SSetPictureBlock)finishResultBlock withErrorBlock:(DisposeAM3SErrorBlock)errorBlock;

@end
