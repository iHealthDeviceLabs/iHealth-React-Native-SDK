//
//  AM4.h
//  iHealthApp2
//
//  Created by 小翼 on 14-7-2.
//  Copyright (c) 2014年 andon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMMacroFile.h"

/**
 AM4
 */
@interface AM4 : NSObject
@property (strong, nonatomic) NSMutableString *am4RandomString;
@property (strong, nonatomic) NSString *currentUUID;
@property (strong, nonatomic) NSString *serialNumber;
@property (strong, nonatomic) NSString *firmwareVersion;



/**
 * Get device userID
 * @param getDeviceUserIDBlock  get userID
 * @param errorBlock Communication error codes, see AM4 error descriptions.
 */
-(void)commandAM4GetDeviceUserID:(DisposeAM4GetDeviceUserIDBlock)getDeviceUserIDBlock withErrorBlock:(DisposeAM4ErrorBlock)errorBlock;



/**
 Set RandomNumber

 @param setRandomNumberBlock randomNumber
 @param errorBlock Communication error codes, see AM4 error descriptions.
 */
-(void)commandAM4SetRandomNumber:(DisposeAM4SetRandomNumberBlock)setRandomNumberBlock withErrorBlock:(DisposeAM4ErrorBlock)errorBlock;


/**
 * Sync time
 * @param syncTimeBlock True: Success， False: Failed.
 * @param errorBlock Communication error codes, see AM4 error descriptions.
 */
-(void)commandAM4SyncTime:(DisposeAM4SyncTimeBlock)syncTimeBlock withErrorBlock:(DisposeAM4ErrorBlock)errorBlock;

/**
 * Set time format and nation
 * @param timeFormatAndNation AM4TimeFormat_hh,AM4TimeFormat_HH,AM4TimeFormat_NoEuropeAndhh,AM4TimeFormat_EuropeAndhh,AM4TimeFormat_NoEuropeAndHH,AM4TimeFormat_EuropeAndHH
 * @param setTimeFormatBlock True: Success， False: Failed.
 * @param errorBlock Communication error codes, see AM4 error descriptions.
 */
-(void)commandAM4SetTimeFormatAndNation:(AM4TimeFormatAndNation)timeFormatAndNation withFinishResult:(DisposeAM4TimeFormatAndNationSettingBlock)setTimeFormatBlock withErrorBlock:(DisposeAM4ErrorBlock)errorBlock;
/**
 * Binding AM4 to user,Account binding requires an active internet connection.
 * @param userID userID, ranging from 1 – 2147483647.
 * @param finishResultBlock True: Success， False: Failed.
 * @param errorBlock Communication error codes, see AM4 error descriptions.
 */
-(void)commandAM4SetUserID:(NSNumber*)userID withFinishResult:(DisposeAM4SetDeviceUserIDBlock)finishResultBlock withErrorBlock:(DisposeAM4ErrorBlock)errorBlock;

/**
 * AM4 initialization,Must be called the first time to ensure that the AM4 has correct user information, goals, time, battery checks, etc.
 * @param user User information, needs to include the following：age(int)、height(cm,1-255)、weight(kg,1-255)、bmr(user basal metabolic)、sex(UserSex_Female or UserSex_Male)、activityLevel (activityLevel=1, Sedentary,spend most of day sitting.activityLevel=2, Active,spend a good part of day doing some physical activity.activityLevel=3, Very Active,spend most of day doing heavy physical activity.)
 * @param unit AM4KmUnit_mile or AM4KmUnit_km
 * @param activeGoalNumber User goal number of steps,ranging from 4 – 2147483647. Default is 10,000
 * @param swimmingGoal User goal number of swimming.ranging from 1–1439. Default is 30min
 * @param setUserInfoFinishBlock True: Success， False: Failed.
 * @param setBMRfinishResultBlock True: Success， False: Failed.
 * @param errorBlock Communication error codes, see AM4 error descriptions.
 */

-(void)commandAM4SetUserInfo:(HealthUser *)user withUnit:(AM4KmUnit)unit withActiveGoal:(NSNumber *)activeGoalNumber withSwimmingGoal:(NSNumber *)swimmingGoal withSetUserInfoFinishResult:(DisposeAM4SetUserInfoBlock)setUserInfoFinishBlock withSetBMR:(DisposeAM4SetBMRBlock)setBMRfinishResultBlock withErrorBlock:(DisposeAM4ErrorBlock)errorBlock;



/**
 * Set swimming
 * @param swimmingIsOpen YES:open swimming function NO:close swimming function default:no
 * @param swimmingPoolLength swimming Pool Length,ranging from 0 – 255.
 * @param noSwimmingDate automatic drop out swim duration
 * @param unit swim unit (AM4SwimmingUnit_m or AM4SwimmingUnit_km)
 * @param finishResultBlock True: Success， False: Failed.
 * @param errorBlock Communication error codes, see AM4 error descriptions.
 */
-(void)commandAM4SetSwimmingState:(BOOL)swimmingIsOpen withSwimmingPoolLength:(NSNumber *)swimmingPoolLength withNOSwimmingTime:(NSDate *)noSwimmingDate withUnit:(AM4SwimmingUnit)unit withFinishResult:(DisposeAM4SettingSwimmingBlock)finishResultBlock withErrorBlock:(DisposeAM4ErrorBlock)errorBlock;

/**
 * Upload AM4 data,Data type: 5 minutes of active data, total number of steps for the day, and total calories.Also includes the number of steps for the 5 minutes of motion data, total calories for the current time, calories of the steps, and total calories.
 * @param activeTransmissionBlock activeTransmission: Start uploading motion data, including parameters：Start date，yyyy-MM-dd(ActiveHistoryDateYear,ActiveHistoryDateMonth,ActiveHistoryDateDay)，ActiveStepSize：Length of each step，ActiveHistoryTotoalNum：Number of records.
 * @param activeHistoryDataBlock active data，including the following parameters：AMDate、AMCalorie、AMstepNum、AMstepSize、dataID、Start. AMDate：Workout time,AMCalorie: Current time total calories,AMStepNum：Total number of steps,dataID：data ID,Start：represents the beginning of a movement.
 * @param activeFinishTransmissionBlock Upload complete.
 * @param errorBlock Communication error codes, see AM4 error descriptions.
 */
-(void)commandAM4StartSyncActiveData:(DisposeAM4ActiveStartTransmission)activeTransmissionBlock
               withActiveHistoryData:(DisposeAM4ActiveHistoryData)activeHistoryDataBlock
        withActiveFinishTransmission:(DisposeAM4ActiveFinishTransmission)activeFinishTransmissionBlock withErrorBlock:(DisposeAM4ErrorBlock)errorBlock;
/**
 * Upload AM4 data,Data type: 5 minutes of sleep data
 * @param sleepTransmissionBlock sleepTransmission:Start uploading sleep data,, including parameters：SleepHistoryDate、AM4SleepHistoryTotoalNum.SleepHistoryDate：Sleep start time，yyyy-MM-dd HH:mm:ss(SleepHistoryDateYear,SleepHistoryDateMonth,SleepHistoryDateDay,SleepHistoryDateHour,SleepHistoryDateMinute,SleepHistoryDateSeconds).SleepHistoryTotoalNum: Number of records
  * @param sleepHistoryDataBlock Sleep data, including the following parameters:：AMDate、SleepData、dataID.AMDate：Sleep time, SleepData: Sleep grade, 0: awake, 1: light sleep, 2: deep sleep ,dataID: data ID.
 * @param sleepFinishTransmissionBlock Upload complete.
 * @param errorBlock Communication error codes, see AM4 error descriptions.
 */
-(void)commandAM4StartSyncSleepData:(DisposeAM4SleepStartTransmission)sleepTransmissionBlock withSleepHistoryData:(DisposeAM4SleepHistoryData)sleepHistoryDataBlock
        withSleepFinishTransmission:(DisposeAM4SleepFinishTransmission)sleepFinishTransmissionBlock withErrorBlock:(DisposeAM4ErrorBlock)errorBlock;

/**
 * Upload AM4 data,Data type: Sync current active data
 * @param currentActiveInfoBlock Total calories and steps for today, including parameters：Step、Calories、TotalCalories.Step：Number of steps taken today.Calories：Number of calories burned today.TotalCalories：Sum calories burned and bmr today.
 * @param errorBlock Communication error codes, see AM4 error descriptions.
 */
-(void)commandAM4StartSyncCurrentActiveData:(DisposeAM4GetCurrentActiveInfo)currentActiveInfoBlock withErrorBlock:(DisposeAM4ErrorBlock)errorBlock;



/**
 * Upload AM4 report data.
 * @param stageDataBlock Report data, including parameters:ReportStage_Swimming(0)、ReportStage_Work_out(1)、ReportStage_Sleep_summary(2).ReportStage_Swimming:Report Stage Swimming.including parameters:SwimmingMeasureDate(swimming Measure date)、SwimmingTimeNumber(swimming time number)、SwimmingTimes(swimming times)、Swimmingcalories(swimming calories)、SwimmingAct(swimming action)、SwimmingCircleCount(swimming circle count)、SwimmingPoollength(swimming pool length)、EnterSwimmingTime(enter swimming time)、OutSwimmingTime（out swimming time）、SwimmingProcessMark（swimming process mark）、SwimStartTimeStamp（swim start time stamp）、dataID(data ID).ReportStage_Work_out:Report Stage active,including parameters:Work_outCalories(Workout calories burned)、Work_outLengthNumber(Workout distance)、Work_outMeasureDate(Start time)、Work_outStepNumber(Workout number of steps)、Work_outTimeNumber(Length of workout)、dataID(data ID).ReportStage_Sleep_summary:Report Stage sleep,including parameters:Sleep_summaryMeasureDate（Sleep start time）、Sleep_summarySleepTime（Sleep duration）、Sleep_summarysleepAddMinute（Correct sleep duration length）、Sleep_summarysleepEfficiency（Sleep efficiency percentage, range is 0-100）
 * @param stageDataFinishTransmissionBlock YES: Success，NO: Failed.
 * @param errorBlock Communication error codes, see AM4 error descriptions.
 */
-(void)commandAM4StartSyncStageData:(DisposeAM4StageMeasureDataBlock)stageDataBlock withStageDataFinishTransmission:(DisposeAM4StageMeasureFinishBlock)stageDataFinishTransmissionBlock withErrorBlock:(DisposeAM4ErrorBlock)errorBlock;


/**
 * Get totoal alarm infomation
 * @param totoalAlarmInfoBlock Alarm array contains up to 3 alarms, each one needs the following parameters：AlarmId、Time、Week.AlarmId：1, 2, 3.Time：HH:mm.Week(Sun、Mon、Tue、Wed、Thu、Fri、Sat)True: On, False: Off
 * @param errorBlock Communication error codes, see AM4 error descriptions.
 */
-(void)commandAM4GetTotoalAlarmInfo:(DisposeAM4TotoalAlarmData)totoalAlarmInfoBlock withErrorBlock:(DisposeAM4ErrorBlock)errorBlock;

/**
 * Set alarm.
 * @param alarmDic Alarm information, include parameters：AlarmId(1、2、3)、Time、IsRepeat、Switch、Week（Sun、Mon、Tue、Wed、Thu、Fri、Sat)
 * @param finishResultBlock True: Alarm set successfully，False: Failed.
 * @param errorBlock Communication error codes, see AM4 error descriptions.
 */
-(void)commandAM4SetAlarmDictionary:(NSDictionary *)alarmDic withFinishResult:(DisposeAM4SetAlarmBlock)finishResultBlock withErrorBlock:(DisposeAM4ErrorBlock)errorBlock;


/**
 * Delete alarm.
 * @param alarmID alarmID：1, 2, 3.
 * @param finishResultBlock True: Delete successful，False: Failed
 * @param errorBlock Communication error codes, see AM4 error descriptions.
 */
-(void)commandAM4DeleteAlarmID:(NSNumber *)alarmID withFinishResult:(DisposeAM4DeleteAlarmBlock)finishResultBlock withErrorBlock:(DisposeAM4ErrorBlock)errorBlock;

/**
 * Get reminder.
 * @param remindInfoBlock Array containing following parameters：ReminderID、Time、Switch.ReminderID：Reminder ID.Time：format HH:mm, time between reminders (HH*60+mm) minutes.Switch：Reminder on/off，True: On， False: Off.
 * @param errorBlock Communication error codes, see AM4 error descriptions.
 */
-(void)commandAM4GetReminderInfo:(DisposeAM4RemindInfoBlock)remindInfoBlock withErrorBlock:(DisposeAM4ErrorBlock)errorBlock;

/**
 * Set reminders.
 * @param reminderDic Array containing collowing parameters：Time、Switch。
 * @param finishResultBlock YES: Successfully set, NO: Failed.
 * @param errorBlock Communication error codes, see AM4 error descriptions.
 */
-(void)commandAM4SetReminderDictionary:(NSDictionary *)reminderDic withFinishResult:(DisposeAM4SetReminderBlock)finishResultBlock withErrorBlock:(DisposeAM4ErrorBlock)errorBlock;



/**
 * Get device state infomation
 * @param deviceStateInfoBlock AM status，State_wrist  (AM4 being worn on the wrist)，State_waist (AM4 worn with belt clip).
 * @param batteryBlock AM battery percentage, from 0～100.
 * @param errorBlock Communication error codes, see AM4 error descriptions.
 */
-(void)commandAM4GetDeviceStateInfo:(DisposeAM4StateInfoBlock)deviceStateInfoBlock withBattery:(DisposeAM4BatteryBlock)batteryBlock withErrorBlock:(DisposeAM4ErrorBlock)errorBlock;

/**
 * Restore factory settings.
 * @param resetDeviceBlock True: Success， False: Failed.
 * @param errorBlock Communication error codes, see AM4 error descriptions.
 */
-(void)commandAM4ResetDevice:(DisposeAM4ResetDeviceBlock)resetDeviceBlock withErrorBlock:(DisposeAM4ErrorBlock)errorBlock;

/**
 * Disconnect AM4 connection.
 * @param disconnectBlock  True: Success，False: Failed.
 * @param errorBlock Communication error codes, see AM4 error descriptions.
 */
-(void)commandAM4Disconnect:(DisposeAM4DisconnectBlock)disconnectBlock withErrorBlock:(DisposeAM4ErrorBlock)errorBlock;


/**
 * Get time format and nation
 * @param timeAndNationBlock  (AM4TimeFormat_hh,AM4TimeFormat_HH,AM4TimeFormat_NoEuropeAndhh,AM4TimeFormat_EuropeAndhh,AM4TimeFormat_NoEuropeAndHH,AM4TimeFormat_EuropeAndHH)
 * @param errorBlock Communication error codes, see AM4 error descriptions.
 */
-(void)commandAM4GetTimeFormatAndNation:(DisposeAM4TimeFormatAndNationBlock)timeAndNationBlock withErrorBlock:(DisposeAM4ErrorBlock)errorBlock;




/**
 * Get user infomation
 * @param userInfoBlock including parameters:Age,Step,Height,Gender,Weight,Unit,goal(TotalStep1、TotalStep2、TotalStep3)
 * @param errorBlock Communication error codes, see AM4 error descriptions.
 */
-(void)commandAM4GetUserInfo:(DisposeAM4UserInfoBlock)userInfoBlock withErrorBlock:(DisposeAM4ErrorBlock)errorBlock;

/**
 * Get swimming infomation
 * @param swimmingInfoBlock including parameters:swimmingIsOpen,swimmingLaneLength,NOSwimmingTime,unit
 * @param errorBlock Communication error codes, see AM4 error descriptions.
 */
-(void)commandAM4GetSwimmingInfo:(DisposeAM4SwimmingBlock)swimmingInfoBlock withErrorBlock:(DisposeAM4ErrorBlock)errorBlock;

/**
 * Set BMR
 * @param bmr ranging from 0 – 5000.
 * @param finishResultBlock True: Delete successful，False: Failed
 * @param errorBlock Communication error codes, see AM4 error descriptions.
 */
-(void)commandAM4SetBMR:(NSNumber *)bmr withFinishResult:(DisposeAM4SetBMRBlock)finishResultBlock withErrorBlock:(DisposeAM4ErrorBlock)errorBlock;

@end
