//
//  AM5.h
//  iHealthSDKStatic
//
//  Created by user on 2019/7/2.
//  Copyright © 2019 ihealthSDK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AM5Header.h"
#import "AMMacroFile.h"

@interface AM5 : NSObject

@property (strong, nonatomic) NSString *currentUUID;
@property (strong, nonatomic) NSString *serialNumber;


/**
 *BindingDevice
 
 * @param bindingResult YES:success  NO:failed
 * @param disposeErrorBlock error code
 */
-(void)commandBindingDevice:(DisposeBindingAM5Result)bindingResult DiaposeErrorBlock:(DisposeAM5ErrorBlock)disposeErrorBlock;

/**
 *UnBindingDevice
 
 * @param unbindingResult YES:success  NO:failed
 * @param disposeErrorBlock error code
 */
-(void)commandUnBindingDevice:(DisposeUnBindingAM5Result)unbindingResult DiaposeErrorBlock:(DisposeAM5ErrorBlock)disposeErrorBlock;
/**
 * GetDeviceInfo
 
 * @param deviceInfo
 This dictionary includes key:
 Mode:Device mode    BatteryStatus:Battery status  BatteryLevel:Battery level RebootFlag:Whether to restart  BindTimeStr:Binding timestamp  BindState:Binding status
 * @param disposeErrorBlock error code
 */
-(void)commandGetDeviceInfo:(DisposeGetAM5DeviceInfo)deviceInfo DiaposeErrorBlock:(DisposeAM5ErrorBlock)disposeErrorBlock;
/**
 * Get functional information
 
 * @param deviceFunctionalInfo
 This dictionary includes key:
 Steps:Number of steps
 SleepDetection:Sleep detection
 SingleMovement:Single movement
 LiveData:Real-time data
 Update:Equipment Update
 HeartRate:Heart rate function
 Notification:Notification Center
 Timeline:Timeline
 * @param disposeErrorBlock error code
 */
-(void)commandGetFuncTable:(DisposeGetAM5FuncTable)deviceFunctionalInfo DiaposeErrorBlock:(DisposeAM5ErrorBlock)disposeErrorBlock;
/**
 * GetDeviceMac
 
 * @param deviceMac  This is the MAC for the device
 * @param disposeErrorBlock error code
 */
-(void)commandGetDeviceMac:(DisposeGetAM5Mac)deviceMac DiaposeErrorBlock:(DisposeAM5ErrorBlock)disposeErrorBlock;

/**
 * GetLiveData
 
 * @param liveData
 This dictionary includes key:
 Step:Step count Calorie:Calorie  Distances:distance ActiveTime:Duration of activity HeartRate:Heart rate
 * @param disposeErrorBlock error code
 */
-(void)commandGetLiveData:(DisposeGetAM5LiveData)liveData DiaposeErrorBlock:(DisposeAM5ErrorBlock)disposeErrorBlock;

/**
 * GetActivityCount
 
 * @param activityCount
 
 This dictionary includes key:
 
 ActivityCount:Number of activities   ActivityPacketCount:Number of active packages GpsCount:Number of GPS data GpsPacketCount:Number of GPS packets
 
 * @param disposeErrorBlock error code
 */
-(void)commandGetActivityCount:(DisposeGetAM5ActivityCount)activityCount DiaposeErrorBlock:(DisposeAM5ErrorBlock)disposeErrorBlock;

/**
 * setCurrentTime
 * @param setCurrentTime  Synchronizes the current time to the device  YES:success  NO:failed
 * @param disposeErrorBlock error code
 */
-(void)commandSetCurrentTime:(DisposeAM5SetCurrentTime)setCurrentTime DiaposeErrorBlock:(DisposeAM5ErrorBlock)disposeErrorBlock;

/**
 * setAlarm
 * @param alarm
 example code:
 IDOSetAlarmInfoBluetoothModel * alarmModel= [IDOSetAlarmInfoBluetoothModel currentModel];
 switch                                alarmModel.isOpen
 Whether the synchronization           alarmModel.isSync
 Whether or not to delete              alarmModel.isDelete
 Type                                  alarmModel.type
 Hour                                  alarmModel.hour
 Minute                                alarmModel.minute
 Repeat                                alarmModel.repeat
 TsnoozeDuration                       alarmModel.tsnoozeDuration
 AlarmId                               alarmModel.alarmId
 
 * @param setAlarmResult YES:success  NO:failed
 * @param disposeErrorBlock error code
 */
-(void)commandSetAlarm:(IDOSetAlarmInfoBluetoothModel*)alarm setResult:(DisposeAM5SetAlarm)setAlarmResult DiaposeErrorBlock:(DisposeAM5ErrorBlock)disposeErrorBlock;

/**
 * SetUserTarget
 * @param target
 example code:
 IDOSetUserInfoBuletoothModel * userModel= [IDOSetUserInfoBuletoothModel currentModel];
 Target sleep time(hour)      userModel.goalSleepDataHour
 Target sleep time(minutes)   userModel.goalSleepDataMinute
 Target steps                 userModel.goalStepData
 Target Calorie               userModel.goalCalorieData
 Target Distance              userModel.goalDistanceData
 Target Weight                userModel.goalWeightData
 Target type  userModel.goalType (type: 0: steps 1: calories 2: distance) setting a type of target requires executing a command once
 
 * @param setUserTargetResult YES:success  NO:failed
 * @param disposeErrorBlock error code
 */
-(void)commandSetUserTarget:(IDOSetUserInfoBuletoothModel*)target  setResult:(DisposeAM5SetUserTarget)setUserTargetResult DiaposeErrorBlock:(DisposeAM5ErrorBlock)disposeErrorBlock;

/**
 * SetUserInfo
 @param userInfo
 example code:
 IDOSetUserInfoBuletoothModel * userModel= [IDOSetUserInfoBuletoothModel currentModel];
 height     userModel.height
 weight     userModel.weight
 gender     userModel.gender   Gender 1: male 2: female
 year       userModel.year
 month      userModel.month
 day        userModel.day
 
 * @param setUserInfoResult YES:success  NO:failed
 * @param disposeErrorBlock error code
 */
-(void)commandSetUserInfo:(IDOSetUserInfoBuletoothModel*)userInfo  setResult:(DisposeAM5SetUserInfo)setUserInfoResult DiaposeErrorBlock:(DisposeAM5ErrorBlock)disposeErrorBlock;

/**
 * SetUnit
 @param unit
 example code:
 IDOSetUnitInfoBluetoothModel * unitInfo = [IDOSetUnitInfoBluetoothModel currentModel];
 From the unit        unitInfo.distanceUnit  0x00: invalid, 0x01:km, 0x02:mi
 Unit of weight       unitInfo.weightUnit    0x00: invalid, 0x01:kg, 0x02:lb, 0x03: st
 Temperature of the unit  unitInfo.tempUnit  0x00: invalid, 0 x01: ° C, 0 x02: ° F
 The language unit    unitInfo.languageUnit  (Invalid :0, Chinese :1, English :2, French :3, German :4, Italian :5, Spanish :6, Japanese :7,Polish :8, Czech :9, Romania :10, Lithuanian :11, Dutch :12, Slovenia :13,Hungarian :14, Russian :15, Ukrainian :16, slovak :17, Danish :18, Croatian :19)
 Walking pace        unitInfo.strideWalk  Convert to the default value of 90 for men (unit: cm)
 Running pace        unitInfo.strideRun  According to the default value of male conversion 72 (unit: cm)
 GPS calibration step size unitInfo.strideGps  0x00: invalid, 0x01: on, 0x02: off
 Unit of time        unitInfo.timeUnit  0x00: invalid, 0x01:24 hours, 0x02: 12 hours
 The beginning of the week  unitInfo.weekStart     (Sunday: 0, Monday: 1, Tuesday: 2, Wednesday: 3, Thursday: 4, Friday: 5, Saturday: 6)
 
 * @param setUnitResult YES:success  NO:failed
 * @param disposeErrorBlock error code
 */
-(void)commandSetUnit:(IDOSetUnitInfoBluetoothModel*)unit  setResult:(DisposeAM5SetUnit)setUnitResult DiaposeErrorBlock:(DisposeAM5ErrorBlock)disposeErrorBlock;

/**
 * SetLongSit
 @param longSit
 example code:
 IDOSetLongSitInfoBuletoothModel * SitInfo = [IDOSetLongSitInfoBuletoothModel currentModel];
 
 interval                  SitInfo.interval
 Start(Hour)               SitInfo.startHour
 Start(minutes)            SitInfo.startMinute
 End(Hour)                 SitInfo.endHour
 End(minutes)              SitInfo.endMinute
 Switch                    SitInfo.isOpen
 
 * @param setLongSitResult YES:success  NO:failed
 * @param disposeErrorBlock error code
 */
-(void)commandSetLongSit:(IDOSetLongSitInfoBuletoothModel*)longSit  setResult:(DisposeAM5SetLongSit)setLongSitResult DiaposeErrorBlock:(DisposeAM5ErrorBlock)disposeErrorBlock;


/**
 * SetLeftRightHand
 @param leftRightHand
 example code:
 IDOSetLeftOrRightInfoBuletoothModel * leftOrRightModel = [IDOSetLeftOrRightInfoBuletoothModel currentModel];
 
 Whether to wear right hand     leftOrRightModel.isRight  0:left 1:right
 
 * @param setLeftRightHandResult  YES:success  NO:failed
 * @param disposeErrorBlock error code
 */
-(void)commandSetLeftRightHand:(IDOSetLeftOrRightInfoBuletoothModel*)leftRightHand  setResult:(DisposeAM5SetLeftRightHand)setLeftRightHandResult DiaposeErrorBlock:(DisposeAM5ErrorBlock)disposeErrorBlock;

/**
 * SetHrInterval
 @param hrInterval
 example code:
 IDOSetHrIntervalInfoBluetoothModel * hrIntervalInfo = [IDOSetHrIntervalInfoBluetoothModel currentModel];
 
 Fat burning threshold   hrIntervalInfo.burnFat
 Aerobic threshold       hrIntervalInfo.aerobic
 Threshold limit         hrIntervalInfo.limitValue
 Maximum heart rate      hrIntervalInfo.userMaxHr
 
 * @param setHrIntervalResult YES:success  NO:failed
 * @param disposeErrorBlock error code
 */
-(void)commandSetHrInterval:(IDOSetHrIntervalInfoBluetoothModel*)hrInterval  setResult:(DisposeAM5SetHrInterval)setHrIntervalResult DiaposeErrorBlock:(DisposeAM5ErrorBlock)disposeErrorBlock;

/**
 * SetHrMode
 @param hrMode
 example code:
 IDOSetHrModeInfoBluetoothModel * hrModeInfo = [IDOSetHrModeInfoBluetoothModel currentModel];
 Heart rate pattern        hrModeInfo.modeType   0: turn off heart rate monitoring function 1: manual mode 2: automatic mode (default: automatic mode)
 Is there an interval      hrModeInfo.isHasTimeRange
 Start(Hour)               hrModeInfo.startHour
 Start(minutes)            hrModeInfo.startMinute
 End(Hour)                 hrModeInfo.endHour
 End(minutes)              hrModeInfo.endMinute
 
 * @param setHrModeResult YES:success  NO:failed
 * @param disposeErrorBlock error code
 */
-(void)commandSetHrMode:(IDOSetHrModeInfoBluetoothModel*)hrMode  setResult:(DisposeAM5SetHrMode)setHrModeResult DiaposeErrorBlock:(DisposeAM5ErrorBlock)disposeErrorBlock;

/**
 * SetNoDisturbMode
 @param noDisturbMode
 example code:
 IDOSetNoDisturbModeInfoBluetoothModel * noDisturbModeInfo = [IDOSetNoDisturbModeInfoBluetoothModel currentModel];
 
 Is there an interval      noDisturbModeInfo.isOpen
 Start(Hour)               noDisturbModeInfo.startHour
 Start(minutes)            noDisturbModeInfo.startMinute
 End(Hour)                 noDisturbModeInfo.endHour
 End(minutes)              noDisturbModeInfo.endMinute
 
 * @param setNoDisturbModeResult YES:success  NO:failed
 * @param disposeErrorBlock error code
 */
-(void)commandSetNoDisturbMode:(IDOSetNoDisturbModeInfoBluetoothModel*)noDisturbMode  setResult:(DisposeAM5SetNoDisturbMode)setNoDisturbModeResult DiaposeErrorBlock:(DisposeAM5ErrorBlock)disposeErrorBlock;
/**
 * SetSportModeSelect
 @param sportModeSelect
 example code:
 IDOSetSportShortcutInfoBluetoothModel * sportShortcutInfo = [IDOSetSportShortcutInfoBluetoothModel currentModel];
 sportShortcutInfo.isWalk
 sportShortcutInfo.isRun
 sportShortcutInfo.isByBike
 sportShortcutInfo.isOnFoot
 sportShortcutInfo.isMountainClimbing
 sportShortcutInfo.isBadminton
 sportShortcutInfo.isSpinning
 sportShortcutInfo.isTreadmill
 sportShortcutInfo.isFitness
 sportShortcutInfo.isYoga
 sportShortcutInfo.isBasketball
 sportShortcutInfo.isTennis
 sportShortcutInfo.isDance
 sportShortcutInfo.isFootball
 
 * @param setSportModeSelectResult YES:success  NO:failed
 * @param disposeErrorBlock error code
 */
-(void)commandSetSportModeSelect:(IDOSetSportShortcutInfoBluetoothModel*)sportModeSelect  setResult:(DisposeAM5SetSportModeSelect)setSportModeSelectResult DiaposeErrorBlock:(DisposeAM5ErrorBlock)disposeErrorBlock;

/**
 * SetSwitchNotice
 @param switchNotice
 example code:
 IDOSetNoticeInfoBuletoothModel* noticeInfo = [IDOSetNoticeInfoBuletoothModel currentModel];
 noticeInfo.isPairing
 noticeInfo.isOnChild
 * @param setSwitchNoticeResult  YES:success  NO:failed
 * @param disposeErrorBlock error code
 */
-(void)commandSetSwitchNotice:(IDOSetNoticeInfoBuletoothModel*)switchNotice  setResult:(DisposeAM5SetSwitchNotice)setSwitchNoticeResult DiaposeErrorBlock:(DisposeAM5ErrorBlock)disposeErrorBlock;

/**
 * syncConfigComplete
 
 * @param syncConfigCompleteResult YES:success  NO:failed
 * @param disposeErrorBlock error code
 */
-(void)commandSyncConfigComplete:(DisposeGetAM5SyncConfigComplete)syncConfigCompleteResult DiaposeErrorBlock:(DisposeAM5ErrorBlock)disposeErrorBlock;

/**
 * syncData
 
 * @param heartRateData  heartRateData
 * @param sleepData  sleepData
 * @param activityData  activityData
 * @param syncprogress  data progress
 * @param syncDataSuccess  sync finish
 * @param disposeErrorBlock error code
 */
-(void)commandSyncData:(DisposeGetAM5SyncHeartRateData)heartRateData syncSleepData:(DisposeGetAM5SyncSleepData)sleepData syncActivityData:(DisposeGetAM5SyncActivityData)activityData syncDataProgress:(DisposeAM5SyncDataProgress)syncprogress syncDataSuccess:(DisposeAM5SyncDataSuccess)syncDataSuccess DiaposeErrorBlock:(DisposeAM5ErrorBlock)disposeErrorBlock;

/**
 * setAppReboot
 
 * @param setAppRebootResult  YES:success  NO:failed
 * @param disposeErrorBlock error code
 */
-(void)commandSetAppReboot:(DisposeAM5SetAppReboot)setAppRebootResult DiaposeErrorBlock:(DisposeAM5ErrorBlock)disposeErrorBlock;

/**
 * SetHandUp
 @param setHandUp
 example code:
 IDOSetHandUpInfoBuletoothModel * handUpModel= [IDOSetHandUpInfoBuletoothModel currentModel];
 handUpModel.isOpen   YES:open  NO:close
 * @param setHandUpResult  YES:success  NO:failed
 * @param disposeErrorBlock error code
 */
-(void)commandSetHandUp:(IDOSetHandUpInfoBuletoothModel*)setHandUp setResult:(DisposeAM5SetHandUp)setHandUpResult DiaposeErrorBlock:(DisposeAM5ErrorBlock)disposeErrorBlock;

/**
 * Disconnect AM5 connection.
 */
-(void)commandAM5Disconnect;

@end

