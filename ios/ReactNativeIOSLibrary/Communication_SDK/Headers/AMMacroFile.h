//
//  AMMacroFile.h
//  AMDemoCode
//
//  Created by zhiwei jing on 14-8-12.
//  Copyright (c) 2014年 zhiwei jing. All rights reserved.
//

#import "HealthUser.h"

#ifndef AMDemoCode_AMMacroFile_h
#define AMDemoCode_AMMacroFile_h


#define AM3Discover         @"AM3Discover"
#define AM3ConnectFailed    @"AM3ConnectFailed"
#define AM3ConnectNoti      @"AM3ConnectNoti"
#define AM3DisConnectNoti   @"AM3DisConnectNoti"

#define AM3SDiscover        @"AM3SDiscover"
#define AM3SConnectFailed   @"AM3SConnectFailed"
#define AM3SConnectNoti     @"AM3SConnectNoti"
#define AM3SDisConnectNoti  @"AM3SDisConnectNoti"

#define AM4Discover         @"AM4Discover"
#define AM4ConnectFailed    @"AM4ConnectFailed"
#define AM4ConnectNoti      @"AM4ConnectNoti"
#define AM4DisConnectNoti   @"AM4DisConnectNoti"

#define AMDeviceID @"ID"
#define AMSDKSportRightApi  @"OpenApiActivity"
#define AMSDKSleepRightApi  @"OpenApiSleep"

#define AM5Discover       @"AM5Discover"
#define AM5ConnectFailed  @"AM5ConnectFailed"
#define AM5ConnectNoti    @"AM5ConnectNoti"
#define AM5DisConnectNoti @"AM5DisConnectNoti"
#define AM5Device @"AM5Device"
#define AM5Distance @"AM5Distance"


//cloud
#define AMDate @"AMDate"
#define AMCalorie @"AMcalorie"
#define AMStepNum @"AMstepNum"
#define AMStepSize @"AMstepSize"
//cloud


///////////////////////////////////////////////////////////////

//AM3

///////////////////////////////////////////////////////////////


#define AM3TimeInterval @"TimeInterval"

#define AM3ActiveHistoryDateYear    @"ActiveHistoryDateYear"
#define AM3ActiveHistoryDateMonth   @"ActiveHistoryDateMonth"
#define AM3ActiveHistoryDateDay     @"ActiveHistoryDateDay"
#define AM3ActiveHistoryTotoalNum   @"ActiveHistoryTotoalNum"
#define AM3ActiveStepSize           @"ActiveStepSize"

#define AM3SleepHistoryDateYear    @"SleepHistoryDateYear"
#define AM3SleepHistoryDateMonth   @"SleepHistoryDateMonth"
#define AM3SleepHistoryDateDay     @"SleepHistoryDateDay"
#define AM3SleepHistoryDateHour    @"SleepHistoryDateHour"
#define AM3SleepHistoryDateMinute  @"SleepHistoryDateMinute"
#define AM3SleepHistoryDateSeconds @"SleepHistoryDateSeconds"
#define AM3SleepHistoryTotoalNum   @"SleepHistoryTotoalNum"


/**
 AM3 error code
 */
typedef NS_ENUM(NSUInteger, AM3ErrorID) {
    /// Communication error
    AM3Error_OverTime = 0,
    /// You did not receive a response within a certain period of time, usually clogged Bluetooth
    AM3Error_NoRespond,
    /// Reset failed
    AM3Error_ResetDeviceFaild,
    /// AM disconnect
    AM3Error_Disconnect,
    /// ParameterError
    AM3Error_ParameterError = 400,
    /// firmware version is not supported
    AM3Error_FirmwareVersionIsNotSupported
};


/**
 AM3 Time Format
 */
typedef NS_ENUM(NSUInteger, AM3TimeFormat) {
    /// 12
    AM3TimeFormat_hh,
    /// 24
    AM3TimeFormat_HH
};

/**
 AM3 State Unit
 */
typedef NS_ENUM(NSUInteger, AM3StateUnit){
    /// mile
    AM3StateUnit_mile,
    /// km
    AM3StateUnit_km
};


/**
 AM3 State Model
 */
typedef NS_ENUM(NSUInteger, AM3StateModel){
    /// sleep
    AM3StateModel_sleep,
    /// active
    AM3StateModel_active,
    /// fly
    AM3StateModel_fly,
    /// drive
    AM3StateModel_drive
};

/**
 AM3 State Info
 */
typedef NS_ENUM(NSUInteger, AM3StateInfo){
    /// waist
    AM3StateInfo_waist,
    /// wrist
    AM3StateInfo_wrist,
    /// sleep
    AM3StateInfo_sleep
};



/**
 Error Block
 
 @param errorID AM3ErrorID descriptions
 */
typedef void (^DisposeAM3ErrorBlock)(AM3ErrorID errorID);


/**
 get user ID
 
 @param userID userID
 */
typedef void (^DisposeAM3GetDeviceUserIDBlock)(unsigned int userID);


/**
 sync time
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM3SyncTimeBlock)(BOOL resetSuc);


/**
 get dateFormatter
 
 @param timeFormat AM3TimeFormat description
 */
typedef void (^DisposeAM3TimeFormatBlock)(AM3TimeFormat  timeFormat);



/**
 set timeFormat
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM3TimeFormatSettingBlock)(BOOL resetSuc);



/**
 set userID
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM3SetDeviceUserIDBlock)(BOOL resetSuc);


/**
 set user info
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM3SetUserInfoBlock)(BOOL resetSuc);


/**
 set BMR
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM3SetBMRBlock)(BOOL resetSuc);


/**
 active start transmission
 
 @param startDataDictionary  including parameters：Start date，yyyy-MM-dd(ActiveHistoryDateYear,ActiveHistoryDateMonth,ActiveHistoryDateDay)，ActiveStepSize：Length of each step，ActiveHistoryTotoalNum：Number of records.
 */
typedef void (^DisposeAM3ActiveStartTransmission)(NSDictionary *startDataDictionary);


/**
 active history data
 
 @param historyDataArray including the following parameters：AMDate、AMCalorie、AMstepNum、AMstepSize、dataID、Start. AMDate：Workout time,AMCalorie: Current time total calories,AMStepNum：Total number of steps,dataID：data ID,Start：represents the beginning of a movement.
 */
typedef void (^DisposeAM3ActiveHistoryData)(NSArray *historyDataArray);



/**
 active finish transmission
 */
typedef void (^DisposeAM3ActiveFinishTransmission)(void);




/**
 sleep start transmission
 
 @param startDataDictionary including parameters：SleepHistoryDate、AM3SleepHistoryTotoalNum.SleepHistoryDate：Sleep start time，yyyy-MM-dd HH:mm:ss(SleepHistoryDateYear,SleepHistoryDateMonth,SleepHistoryDateDay,SleepHistoryDateHour,SleepHistoryDateMinute,SleepHistoryDateSeconds).SleepHistoryTotoalNum: Number of records
 */
typedef void (^DisposeAM3SleepStartTransmission)(NSDictionary *startDataDictionary);


/**
 sleep history data
 
 @param historyDataArray including the following parameters:：AMDate、SleepData、dataID.AMDate：Sleep time, SleepData: Sleep grade, 0: awake, 1: light sleep, 2: deep sleep ,dataID: data ID
 */
typedef void (^DisposeAM3SleepHistoryData)(NSArray *historyDataArray);


/**
 sleep finish transmission
 */
typedef void (^DisposeAM3SleepFinishTransmission)(void);


/**
 get current active info
 
 @param activeDictionary Total calories and steps for today, including parameters：Step、Calories、TotalCalories.Step：Number of steps taken today.Calories：Number of calories burned today.TotalCalories：Sum calories burned and bmr today.
 */
typedef void (^DisposeAM3GetCurrentActiveInfo)(NSDictionary *activeDictionary);


/**
 totoal alarm array
 
 @param totoalAlarmArray  totoalAlarmArray contains up to 3 alarms, each one needs the following parameters：AlarmId、Time、IsRepeat、Switch、（Sun、Mon、Tue、Wed、Thu、Fri、Sat)
 */
typedef void (^DisposeAM3TotoalAlarmData)(NSMutableArray *totoalAlarmArray);


/**
 set alarm
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM3SetAlarmBlock)(BOOL resetSuc);


/**
 delete Alarm
 
 @param resetSuc yes:success no:fail
 
 */
typedef void (^DisposeAM3DeleteAlarmBlock)(BOOL resetSuc);


/**
 get remind info
 
 @param remindInfo array containing following parameters：ReminderID、Time、Switch.ReminderID：Reminder ID.Time：format HH:mm, time between reminders (HH*60+mm) minutes.Switch：Reminder on/off，True: On， False: Off.
 */
typedef void (^DisposeAM3RemindInfoBlock)(NSArray *remindInfo);



/**
 set reminder
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM3SetReminderBlock)(BOOL resetSuc);


/**
 get state info
 
 @param queryState AM3StateInfo description
 */
typedef void (^DisposeAM3StateInfoBlock)(AM3StateInfo queryState);


/**
 get battery
 
 @param battery 1~100
 */
typedef void (^DisposeAM3BatteryBlock)(NSNumber *battery);


/**
 reset device
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM3ResetDeviceBlock)(BOOL resetSuc);


/**
 disconnect
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM3DisconnectBlock)(BOOL resetSuc);


/**
 get user info
 
 @param userInfo including parameters:Age,Step,Height,Gender,Weight,Unit,goal(TotalStep1、TotalStep2、TotalStep3)
 */
typedef void (^DisposeAM3UserInfoBlock)(NSDictionary *userInfo);


/**
 set State
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM3SetStateBlock)(BOOL resetSuc);


/**
 set state model
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM3SetStateModelBlock)(BOOL resetSuc);
///////////////////////////////////////////////////////////////

//AM3S

///////////////////////////////////////////////////////////////

#define AM3STimeInterval @"TimeInterval"

#define AM3SActiveHistoryDateYear    @"ActiveHistoryDateYear"
#define AM3SActiveHistoryDateMonth   @"ActiveHistoryDateMonth"
#define AM3SActiveHistoryDateDay     @"ActiveHistoryDateDay"
#define AM3SActiveHistoryTotoalNum   @"ActiveHistoryTotoalNum"
#define AM3SActiveStepSize           @"ActiveStepSize"

#define AM3SSleepHistoryDateYear    @"SleepHistoryDateYear"
#define AM3SSleepHistoryDateMonth   @"SleepHistoryDateMonth"
#define AM3SSleepHistoryDateDay     @"SleepHistoryDateDay"
#define AM3SSleepHistoryDateHour    @"SleepHistoryDateHour"
#define AM3SSleepHistoryDateMinute  @"SleepHistoryDateMinute"
#define AM3SSleepHistoryDateSeconds @"SleepHistoryDateSeconds"
#define AM3SSleepHistoryTotoalNum   @"SleepHistoryTotoalNum"


#define ReportState @"ReportState"

#define Work_outMeasureDate @"Work_outMeasureDate"
#define Work_outTimeNumber @"Work_outTimeNumber"
#define Work_outStepNumber @"Work_outStepNumber"
#define Work_outLengthNumber @"Work_outLengthNumber"
#define Work_outCalories @"Work_outCalories"
#define Work_outTimeZone @"Work_outTimeZone"

#define Sleep_summaryMeasureDate @"Sleep_summaryMeasureDate"
#define Sleep_summarySleepTime @"Sleep_summarySleepTime"
#define Sleep_summarysleepEfficiency @"Sleep_summarysleepEfficiency"
#define Sleep_summarysleepAddMinute @"Sleep_summarysleepAddMinute"
#define Sleep_summaryTimeZone @"Sleep_summaryTimeZone"


/**
 AM3S error code
 */
typedef NS_ENUM(NSUInteger, AM3SErrorID) {
    /// Communication error
    AM3SError_OverTime = 0,
    /// You did not receive a response within a certain period of time, usually clogged Bluetooth
    AM3SError_NoRespond,
    /// Reset failed
    AM3SError_ResetDeviceFaild,
    /// AM disconnect
    AM3SError_Disconnect,
    /// ParameterError
    AM3SError_ParameterError = 400,
    /// firmware version is not supported
    AM3SError_FirmwareVersionIsNotSupported
};



/**
 AM3S Time Format
 */
typedef NS_ENUM(NSUInteger, AM3STimeFormatAndNation) {
    /// 12
    AM3STimeFormat_hh = 0,
    /// 24
    AM3STimeFormat_HH,
    /// No europe and hh
    AM3STimeFormat_NoEuropeAndhh,
    /// europe and hh
    AM3STimeFormat_EuropeAndhh,
    /// no europe and HH
    AM3STimeFormat_NoEuropeAndHH,
    /// europe and HH
    AM3STimeFormat_EuropeAndHH,
};


/**
 AM3S State Unit
 */
typedef NS_ENUM(NSUInteger, AM3SKmUnit){
    /// mile
    AM3SKmUnit_mile,
    /// km
    AM3SKmUnit_km
};


/**
 AM3S Query State
 */
typedef NS_ENUM(NSUInteger, AM3SQueryState){
    /// waist
    AM3SState_waist,
    /// wrist
    AM3SState_wrist,
    /// sleep
    AM3SState_sleep
};


/**
 AM3S Picture
 */
typedef NS_ENUM(NSUInteger, AM3SPicture){
    /// one
    AM3SPicture_one,
    /// two
    AM3SPicture_two,
};

/**
 AM3S ReportStage
 */
typedef NS_ENUM(NSUInteger, AM3SReportStage){
    /// Work_out
    AM3SReportStage_Work_out = 1,
    /// Sleep_summary
    AM3SReportStage_Sleep_summary,
};

/**
 AM3S ActiveState
 */
typedef NS_ENUM(NSUInteger, AM3SActiveState){
    /// Active
    AM3SActive_State = 0,
    /// sleep
    AM3SSleep_State = 1,
    /// flight
    AM3SFly_State = 2,
    /// workout
    AM3SWorkout_State = 4,
};


/**
 get user ID
 
 @param userID userID
 */
typedef void (^DisposeAM3SGetDeviceUserIDBlock)(unsigned int userID);

/**
 Error Block
 
 @param errorID AM3SErrorID descriptions
 */
typedef void (^DisposeAM3SErrorBlock)(AM3SErrorID errorID);


/**
 set random number
 
 @param randomNumString randomNumString
 */
typedef void (^DisposeAM3SSetRandomNumberBlock)(NSString *randomNumString);
/**
 sync time
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM3SSyncTimeBlock)(BOOL resetSuc);

/**
 set timeFormat and nation
 
 @param timeFormatAndNation AM3STimeFormatAndNation description
 */
typedef void (^DisposeAM3STimeFormatAndNationBlock)(AM3STimeFormatAndNation  timeFormatAndNation);

/**
 set date Formatter
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM3STimeFormatAndNationSettingBlock)(BOOL resetSuc);

/**
 set userID
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM3SSetDeviceUserIDBlock)(BOOL resetSuc);


/**
 set user info
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM3SSetUserInfoBlock)(BOOL resetSuc);

/**
 set BMR
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM3SSetBMRBlock)(BOOL resetSuc);

/**
 active start transmission
 
 @param startDataDictionary  including parameters：Start date，yyyy-MM-dd(ActiveHistoryDateYear,ActiveHistoryDateMonth,ActiveHistoryDateDay)，ActiveStepSize：Length of each step，ActiveHistoryTotoalNum：Number of records.
 */
typedef void (^DisposeAM3SActiveStartTransmission)(NSDictionary *startDataDictionary);


/**
 active history data
 
 @param historyDataArray including the following parameters：AMDate、AMCalorie、AMstepNum、AMstepSize、dataID、Start. AMDate：Workout time,AMCalorie: Current time total calories,AMStepNum：Total number of steps,dataID：data ID,Start：represents the beginning of a movement.
 */
typedef void (^DisposeAM3SActiveHistoryData)(NSArray *historyDataArray);

/**
 active finish transmission
 */
typedef void (^DisposeAM3SActiveFinishTransmission)(void);//


/**
 sleep start transmission
 
 @param startDataDictionary including parameters：SleepHistoryDate、AM3SleepHistoryTotoalNum.SleepHistoryDate：Sleep start time，yyyy-MM-dd HH:mm:ss(SleepHistoryDateYear,SleepHistoryDateMonth,SleepHistoryDateDay,SleepHistoryDateHour,SleepHistoryDateMinute,SleepHistoryDateSeconds).SleepHistoryTotoalNum: Number of records
 */
typedef void (^DisposeAM3SSleepStartTransmission)(NSDictionary *startDataDictionary);
/**
 sleep history data
 
 @param historyDataArray including the following parameters:：AMDate、SleepData、dataID.AMDate：Sleep time, SleepData: Sleep grade, 0: awake, 1: light sleep, 2: deep sleep ,dataID: data ID
 */
typedef void (^DisposeAM3SSleepHistoryData)(NSArray *historyDataArray);

/**
 sleep finish transmission
 */
typedef void (^DisposeAM3SSleepFinishTransmission)(void);

/**
 get current active info
 
 @param activeDictionary Total calories and steps for today, including parameters：Step、Calories、TotalCalories.Step：Number of steps taken today.Calories：Number of calories burned today.TotalCalories：Sum calories burned and bmr today.
 */
typedef void (^DisposeAM3SGetCurrentActiveInfo)(NSDictionary *activeDictionary);

/**
 reset device
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM3SResetDeviceBlock)(BOOL resetSuc);

/**
 totoal alarm array
 
 @param totoalAlarmArray  totoalAlarmArray contains up to 3 alarms, each one needs the following parameters：AlarmId、Time、IsRepeat、Switch、（Sun、Mon、Tue、Wed、Thu、Fri、Sat)
 */
typedef void (^DisposeAM3STotoalAlarmData)(NSMutableArray *totoalAlarmArray);


/**
 set alarm
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM3SSetAlarmBlock)(BOOL resetSuc);
/**
 delete Alarm
 
 @param resetSuc yes:success no:fail
 
 */
typedef void (^DisposeAM3SDeleteAlarmBlock)(BOOL resetSuc);

/**
 get remind info
 
 @param remindInfo array containing following parameters：ReminderID、Time、Switch.ReminderID：Reminder ID.Time：format HH:mm, time between reminders (HH*60+mm) minutes.Switch：Reminder on/off，True: On， False: Off.
 */
typedef void (^DisposeAM3SRemindInfoBlock)(NSArray *remindInfo);


/**
 set reminder
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM3SSetReminderBlock)(BOOL resetSuc);

/**
 get state info
 
 @param queryState AM3StateInfo description
 */
typedef void (^DisposeAM3SStateInfoBlock)(AM3SQueryState queryState);

/**
 get battery
 
 @param battery 1~100
 */
typedef void (^DisposeAM3SBatteryBlock)(NSNumber *battery);

/**
 disconnect
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM3SDisconnectBlock)(BOOL resetSuc);

/**
 stage measure data
 
 @param measureDataArray including workout and sleepSummary
 */
typedef void (^DisposeAM3SStageMeasureDataBlock)(NSArray *measureDataArray);


/**
 stage measure dinish
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM3SStageMeasureFinishBlock)(BOOL resetSuc);


/**
 get user info
 
 @param userInfo including parameters:Age,Step,Height,Gender,Weight,Unit,goal(TotalStep1、TotalStep2、TotalStep3)
 */
typedef void (^DisposeAM3SUserInfoBlock)(NSDictionary *userInfo);

/**
 query picture
 */
typedef void (^DisposeAM3SGetPictureBlock)(AM3SPicture picture);

/**
 set picture
 */
typedef void (^DisposeAM3SSetPictureBlock)(BOOL resetSuc);



///////////////////////////////////////////////////////////////


//AM4

///////////////////////////////////////////////////////////////


#define AM4TimeInterval @"TimeInterval"

#define AM4ActiveHistoryDateYear    @"ActiveHistoryDateYear"
#define AM4ActiveHistoryDateMonth   @"ActiveHistoryDateMonth"
#define AM4ActiveHistoryDateDay     @"ActiveHistoryDateDay"
#define AM4ActiveHistoryTotoalNum   @"ActiveHistoryTotoalNum"
#define AM4ActiveStepSize           @"ActiveStepSize"
#define AM4ActiveTimeZone           @"ActiveTimeZone"

#define AM4SleepHistoryDateYear    @"SleepHistoryDateYear"
#define AM4SleepHistoryDateMonth   @"SleepHistoryDateMonth"
#define AM4SleepHistoryDateDay     @"SleepHistoryDateDay"
#define AM4SleepHistoryDateHour    @"SleepHistoryDateHour"
#define AM4SleepHistoryDateMinute  @"SleepHistoryDateMinute"
#define AM4SleepHistoryDateSeconds @"SleepHistoryDateSeconds"
#define AM4SleepHistoryTotoalNum   @"SleepHistoryTotoalNum"
#define AM4SleepHistoryTimeZone   @"SleepHistoryTimeZone"



#define AM4SwimmingMeasureDate @"SwimmingMeasureDate"
#define AM4SwimmingTimeNumber @"SwimmingTimeNumber"
#define AM4SwimmingTimes @"SwimmingTimes"
#define AM4Swimmingcalories @"Swimmingcalories"
#define AM4SwimmingAct @"SwimmingAct"
#define AM4SwimmingPoollength @"SwimmingPoollength"
#define AM4SwimmingCircleCount @"SwimmingCircleCount"
#define AM4EnterSwimmingTime @"EnterSwimmingTime"
#define AM4OutSwimmingTime @"OutSwimmingTime"
#define AM4SwimmingProcessMark @"SwimmingProcessMark"
#define AM4SwimStartTimeStamp @"SwimStartTimeStamp"
#define AM4SwimmingTimeZone @"SwimmingTimeZone"


/**
 AM4 error code
 */
typedef NS_ENUM(NSUInteger, AM4ErrorID) {
    /// Communication error
    AM4Error_OverTime = 0,
    /// You did not receive a response within a certain period of time, usually clogged Bluetooth
    AM4Error_NoRespond,
    /// Reset failed
    AM4Error_ResetDeviceFaild,
    /// AM disconnect
    AM4Error_Disconnect,
    /// ParameterError
    AM4Error_ParameterError = 400,
    /// firmware version is not supported
    AM4Error_FirmwareVersionIsNotSupported
};



/**
 AM4 Time Format
 */
typedef NS_ENUM(NSUInteger, AM4TimeFormatAndNation) {
    /// 12
    AM4TimeFormat_hh = 0,
    /// 24
    AM4TimeFormat_HH,
    /// No europe and hh
    AM4TimeFormat_NoEuropeAndhh,
    /// europe and hh
    AM4TimeFormat_EuropeAndhh,
    /// no europe and HH
    AM4TimeFormat_NoEuropeAndHH,
    /// europe and HH
    AM4TimeFormat_EuropeAndHH,
};

/**
 AM4 State Unit
 */
typedef NS_ENUM(NSUInteger, AM4KmUnit){
    /// mile
    AM4KmUnit_mile,
    /// km
    AM4KmUnit_km
};


/**
 AM4 Swimming Unit
 */
typedef NS_ENUM(NSUInteger, AM4SwimmingUnit){
    /// m
    AM4SwimmingUnit_m,
    /// km
    AM4SwimmingUnit_km,
};

/**
 AM4 Query State
 */
typedef NS_ENUM(NSUInteger, AM4QueryState){
    /// waist
    AM4State_waist,
    /// waist
    AM4State_wrist,
    /// waist
    AM4State_sleep
};

/**
 AM4 Swimming Action
 */
typedef NS_ENUM(NSUInteger, AM4SwimmingAction){
    /// Crawl
    AM4SwimmingAction_Crawl,
    /// Breaststroke
    AM4SwimmingAction_Breaststroke,
    /// Backstroke
    AM4SwimmingAction_Backstroke,
    /// Butterfly
    AM4SwimmingAction_Butterfly,
    /// MixedSwimming
    AM4SwimmingAction_MixedSwimming,
    /// Unkonw
    AM4SwimmingAction_Unkonw
};

/**
 AM4 Report Stage
 */
typedef NS_ENUM(NSUInteger, AM4ReportStage){
    /// Swimming
    AM4ReportStage_Swimming,
    /// Work_out
    AM4ReportStage_Work_out,
    /// summary
    AM4ReportStage_Sleep_summary,
};

/**
 AM4 Active State
 */
typedef NS_ENUM(NSUInteger, AM4ActiveState){
    /// Active_State
    AM4Active_State =0,
    /// Sleep_State
    AM4Sleep_State =1,
    /// Fly_State
    AM4Fly_State =2,
    /// Workout_State
    AM4Workout_State=4,
    /// Swimming_State
    AM4Swimming_State=5,
};



/**
 get user ID
 
 @param userID userID
 */
typedef void (^DisposeAM4GetDeviceUserIDBlock)(unsigned int userID);

/**
 Error Block
 
 @param errorID AM4ErrorID descriptions
 */
typedef void (^DisposeAM4ErrorBlock)(AM4ErrorID errorID);

/**
 set random number
 
 @param randomNumString randomNumString
 */
typedef void (^DisposeAM4SetRandomNumberBlock)(NSString *randomNumString);

/**
 sync time
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM4SyncTimeBlock)(BOOL resetSuc);


/**
 set timeFormat and nation
 
 @param timeFormatAndNation AM4TimeFormatAndNation description
 */
typedef void (^DisposeAM4TimeFormatAndNationBlock)(AM4TimeFormatAndNation  timeFormatAndNation);


/**
 set date Formatter
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM4TimeFormatAndNationSettingBlock)(BOOL resetSuc);

/**
 set userID
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM4SetDeviceUserIDBlock)(BOOL resetSuc);

/**
 set user info
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM4SetUserInfoBlock)(BOOL resetSuc);

/**
 set BMR
 */
typedef void (^DisposeAM4SetBMRBlock)(BOOL resetSuc);

/**
 active start transmission
 
 @param startDataDictionary  including parameters：Start date，yyyy-MM-dd(ActiveHistoryDateYear,ActiveHistoryDateMonth,ActiveHistoryDateDay)，ActiveStepSize：Length of each step，ActiveHistoryTotoalNum：Number of records.
 */
typedef void (^DisposeAM4ActiveStartTransmission)(NSDictionary *startDataDictionary);

/**
 active history data
 
 @param historyDataArray including the following parameters：AMDate、AMCalorie、AMstepNum、AMstepSize、dataID、Start. AMDate：Workout time,AMCalorie: Current time total calories,AMStepNum：Total number of steps,dataID：data ID,Start：represents the beginning of a movement.
 */
typedef void (^DisposeAM4ActiveHistoryData)(NSArray *historyDataArray);

/**
 active finish transmission
 */
typedef void (^DisposeAM4ActiveFinishTransmission)(void);

/**
 sleep start transmission
 
 @param startDataDictionary including parameters：SleepHistoryDate、AM3SleepHistoryTotoalNum.SleepHistoryDate：Sleep start time，yyyy-MM-dd HH:mm:ss(SleepHistoryDateYear,SleepHistoryDateMonth,SleepHistoryDateDay,SleepHistoryDateHour,SleepHistoryDateMinute,SleepHistoryDateSeconds).SleepHistoryTotoalNum: Number of records
 */
typedef void (^DisposeAM4SleepStartTransmission)(NSDictionary *startDataDictionary);

/**
 sleep history data
 
 @param historyDataArray including the following parameters:：AMDate、SleepData、dataID.AMDate：Sleep time, SleepData: Sleep grade, 0: awake, 1: light sleep, 2: deep sleep ,dataID: data ID
 */
typedef void (^DisposeAM4SleepHistoryData)(NSArray *historyDataArray);

/**
 sleep finish transmission
 */
typedef void (^DisposeAM4SleepFinishTransmission)(void);

/**
 get current active info
 
 @param activeDictionary Total calories and steps for today, including parameters：Step、Calories、TotalCalories.Step：Number of steps taken today.Calories：Number of calories burned today.TotalCalories：Sum calories burned and bmr today.
 */
typedef void (^DisposeAM4GetCurrentActiveInfo)(NSDictionary *activeDictionary);

/**
 reset device
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM4ResetDeviceBlock)(BOOL resetSuc);

/**
 totoal alarm array
 
 @param totoalAlarmArray  totoalAlarmArray contains up to 3 alarms, each one needs the following parameters：AlarmId、Time、IsRepeat、Switch、（Sun、Mon、Tue、Wed、Thu、Fri、Sat)
 */
typedef void (^DisposeAM4TotoalAlarmData)(NSMutableArray *totoalAlarmArray);

/**
 set alarm
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM4SetAlarmBlock)(BOOL resetSuc);

/**
 delete Alarm
 
 @param resetSuc yes:success no:fail
 
 */
typedef void (^DisposeAM4DeleteAlarmBlock)(BOOL resetSuc);

/**
 get remind info
 
 @param remindInfo array containing following parameters：ReminderID、Time、Switch.ReminderID：Reminder ID.Time：format HH:mm, time between reminders (HH*60+mm) minutes.Switch：Reminder on/off，True: On， False: Off.
 */
typedef void (^DisposeAM4RemindInfoBlock)(NSArray *remindInfo);

/**
 set reminder
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM4SetReminderBlock)(BOOL resetSuc);

/**
 get state info
 
 @param queryState AM3StateInfo description
 */
typedef void (^DisposeAM4StateInfoBlock)(AM4QueryState queryState);

/**
 get battery
 
 @param battery 1~100
 */
typedef void (^DisposeAM4BatteryBlock)(NSNumber *battery);

/**
 disconnect
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM4DisconnectBlock)(BOOL resetSuc);


/**
 get Swimming info
 
 @param swimmingIsOpen yes open ,no close
 @param swimmingLaneLength lane length
 @param NOSwimmingTime no swimming time
 @param unit AM4SwimmingUnit description
 */
typedef void (^DisposeAM4SwimmingBlock)(BOOL swimmingIsOpen, NSNumber * swimmingLaneLength,NSNumber * NOSwimmingTime, AM4SwimmingUnit unit);


/**
 setting swimming
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM4SettingSwimmingBlock)(BOOL resetSuc);

/**
 stage measure data
 
 @param measureDataArray including workout、swimming and sleepSummary
 */
typedef void (^DisposeAM4StageMeasureDataBlock)(NSArray *measureDataArray);

/**
 stage measure dinish
 
 @param resetSuc yes:success no:fail
 */
typedef void (^DisposeAM4StageMeasureFinishBlock)(BOOL resetSuc);


/**
 get user info
 
 @param userInfo including parameters:Age,Step,Height,Gender,Weight,Unit,goal(TotalStep1、TotalStep2、TotalStep3)
 */
typedef void (^DisposeAM4UserInfoBlock)(NSDictionary *userInfo);



/**
 send AM3 data
 */
typedef void (^DisposeSendAM3DataBlock)(void);

/**
 send AM3S data
 */
typedef void (^DisposeSendAM3SDataBlock)(void);


/**
 send AM4 data
 
 */
typedef void (^DisposeSendAM4DataBlock)(void);




/************AM5**************/

typedef NS_ENUM(NSUInteger, AM5DeviceError) {
    AM5DeviceError_GetDataFailError = 0,
    AM5DeviceError_SetTimeFaild,
    AM5DeviceError_SetUnitFaild,
    AM5DeviceError_SetUserInfoFaild,
    AM5DeviceError_BindFaild,
    AM5DeviceError_SyncConfigComplete,
};




typedef void (^DisposeAM5ErrorBlock)(AM5DeviceError errorID);

typedef void (^DisposeBindingAM5Result)(BOOL result);

typedef void (^DisposeUnBindingAM5Result)(BOOL result);

typedef void (^DisposeGetAM5DeviceInfo)(NSMutableDictionary * DeviceInfo);

typedef void (^DisposeGetAM5FuncTable)(NSMutableDictionary * DeviceFuncTable);

typedef void (^DisposeGetAM5Mac)(NSString* deviceMac);

typedef void (^DisposeGetAM5LiveData)(NSMutableDictionary * liveDataDic);

typedef void (^DisposeGetAM5ActivityCount)(NSMutableDictionary * activityCountDic);

typedef void (^DisposeAM5SetCurrentTime)(BOOL result);

typedef void (^DisposeAM5SetAlarm)(BOOL result);

typedef void (^DisposeAM5SetUserTarget)(BOOL result);

typedef void (^DisposeAM5SetUserInfo)(BOOL result);

typedef void (^DisposeAM5SetUnit)(BOOL result);

typedef void (^DisposeAM5SetLongSit)(BOOL result);

typedef void (^DisposeAM5SetLeftRightHand)(BOOL result);

typedef void (^DisposeAM5SetHrInterval)(BOOL result);

typedef void (^DisposeAM5SetHrMode)(BOOL result);

typedef void (^DisposeAM5SetNoDisturbMode)(BOOL result);

typedef void (^DisposeAM5SetSportModeSelect)(BOOL result);

typedef void (^DisposeAM5SetSwitchNotice)(BOOL result);

typedef void (^DisposeGetAM5SyncConfigComplete)(BOOL result);

typedef void (^DisposeGetAM5SyncHeartRateData)(NSDictionary * syncDataDic);

typedef void (^DisposeGetAM5SyncSleepData)(NSDictionary * syncDataDic);

typedef void (^DisposeGetAM5SyncActivityData)(NSDictionary * syncDataDic);

typedef void (^DisposeAM5SyncDataProgress)(NSNumber * syncDataProgress);

typedef void (^DisposeAM5SyncDataSuccess)(void);

typedef void (^DisposeAM5SetAppReboot)(BOOL result);

typedef void (^DisposeAM5SetHandUp)(BOOL result);

#endif

