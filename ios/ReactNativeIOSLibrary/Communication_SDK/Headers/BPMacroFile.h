//
//  BPMacroFile.h
//  BP_SDKDemo
//
//  Created by zhiwei jing on 14-2-25.
//  Copyright (c) 2014年 zhiwei jing. All rights reserved.
//



#ifndef BP_SDKDemo_BPMacroFile_h
#define BP_SDKDemo_BPMacroFile_h

#import "HealthUser.h"
#import "BPController.h"

/**
 BP error code
 */
typedef NS_ENUM(NSUInteger, BPDeviceError) {
    /// Unable to take measurements due to arm/wrist movements.
    BPError0 = 0,
    /// Failed to detect systolic pressure
    BPError1,
    /// Failed to detect diastolic pressure
    BPError2,
    /// Pneumatic system blocked or cuff is too tight during inflation
    BPError3,
    /// Pneumatic system leakage or cuff is too loose during inflation
    BPError4,
    /// Cuff pressure reached over 300mmHg
    BPError5,
    /// Cuff pressure reached over 15 mmHg for more than 160 seconds
    BPError6,
    /// Data retrieving error
    BPError7,
    /// Data retrieving error
    BPError8,
    /// Data retrieving error
    BPError9,
    /// Data retrieving error
    BPError10,
    /// Communication Error
    BPError11,
    /// Communication Error
    BPError12,
    /// Low battery
    BPError13,
    /// Device bluetooth set failed
    BPError14,
    /// Systolic exceeds 260mmHg or diastolic exceeds 199mmHg
    BPError15,
    /// Systolic below 60mmHg or diastolic below 40mmHg
    BPError16,
    /// Arm/wrist movement beyond range
    BPError17,
    /// Heart rate in measure result exceeds max limit
    BPError18,
    /// Heart rate in measure result exceeds min limit
    BPError19,
    /// PP(Average BP) exceeds limit
    BPError20,
    /// User stop measure(for ABPM history measurement only)
    BPErrorUserStopMeasure,
    /// device error, error message displayed automatically
    BPNormalError = 30,
    /// Abnormal communication
    BPOverTimeError,
    /// Abnormal communication
    BPNoRespondError,
    /// device is out of communication range.
    BPBeyondRangeError,
    /// device is disconnected.
    BPDidDisconnect,
    /// measurement has been stopped.
    BPAskToStopMeasure,
    /// 36 device is busy doing other things
    BPDeviceBusy,
    /// Parameter input error.
    BPInputParameterError = 400,
    /// Parameter input error.
    BPInvalidOperation = 402,
};


typedef void(^BlockEnergyDetailValue)(NSNumber *energyValue,NSNumber *mVolt, NSNumber* measureTimesLeft);
typedef void(^BlockEnergyValue)(NSNumber *energyValue);
typedef void(^BlockEnergyState)(NSNumber *energyState);
typedef void(^BlockError)(BPDeviceError error);
typedef void(^BlockDeviceFunction)(NSDictionary *functionDict);
typedef void(^BlockBlueSet)(BOOL isOpen);
typedef void(^BlockAngle)(NSDictionary *angleDict);
typedef void(^BlockPressure)(NSArray *pressureArr);
typedef void(^BlockWavelet)(NSArray *waveletArr);
typedef void(^BlockZero)(BOOL isComplete);
typedef void(^BlockMeasureResult)(NSDictionary *resultDict);

typedef void(^BlockBachCount)(NSNumber *count);
typedef void(^BlockBachProgress)(NSNumber *progressValue);
typedef void(^BlockBachArray)(NSArray *bachArray);
typedef void(^BlockBachFinished)(BOOL finishFlag);

typedef void(^BlockAskMeasureTime)(NSDictionary *measureTimeDict);//Deprecated
typedef void(^BlockSetMeasureTime)(NSDictionary *setResult);//Deprecated

typedef void(^BlockSuccess)(void);

typedef void(^BlockUserAuthentication)(UserAuthenResult result);//the result of userID verification
typedef void(^BlockSetUserID)(BOOL finishFlag);

typedef void(^BlockResult)(BOOL result);

typedef void(^BlockRedWaveDic)(NSDictionary *redWaveDict);

typedef void(^BlockMeasureStatus)(NSDictionary *statusDict);

typedef void(^BlockDisplayStatus)(NSDictionary *statusDict);


#define BP3ConnectNoti      @"BP3ConnectNoti"
#define BP3DisConnectNoti   @"BP3DisConnectNoti"
#define BP5ConnectNoti      @"BP5ConnectNoti"
#define BP5DisConnectNoti   @"BP5DisConnectNoti"
#define BP7ConnectNoti      @"BP7ConnectNoti"
#define BP7DisConnectNoti   @"BP7DisConnectNoti"

#define BP3LDiscover        @"BP3LDiscover"
#define BP3LConnectFailed   @"BP3LConnectFailed"
#define BP3LConnectNoti     @"BP3LConnectNoti"
#define BP3LDisConnectNoti  @"BP3LDisConnectNoti"

#define BP5SDiscover        @"BP5SDiscover"
#define BP5SConnectFailed   @"BP5SConnectFailed"
#define BP5SConnectNoti     @"BP5SConnectNoti"
#define BP5SDisConnectNoti  @"BP5SDisConnectNoti"

#define BP5SRWDiscover        @"BP5SRWDiscover"
#define BP5SRWConnectFailed   @"BP5SRWConnectFailed"
#define BP5SRWConnectNoti     @"BP5SRWConnectNoti"
#define BP5SRWDisConnectNoti  @"BP5SRWDisConnectNoti"

#define BP7SDiscover        @"BP7SDiscover"
#define BP7SConnectFailed   @"BP7SConnectFailed"
#define BP7SConnectNoti     @"BP7SConnectNoti"
#define BP7SDisConnectNoti  @"BP7SDisConnectNoti"

#define KN550BTDiscover     @"KN550BTDiscover"
#define KN550BTConnectFailed   @"KN550BTConnectFailed"
#define KN550BTConnectNoti  @"KN550BTConnectNoti"
#define KN550BTDisConnectNoti  @"KN550BTDisConnectNoti"

#define KD926Discover       @"KD926Discover"
#define KD926ConnectFailed  @"KD926ConnectFailed"
#define KD926ConnectNoti    @"KD926ConnectNoti"
#define KD926DisConnectNoti @"KD926DisConnectNoti"

#define KD723Discover       @"KD723Discover"
#define KD723ConnectFailed  @"KD723ConnectFailed"
#define KD723ConnectNoti    @"KD723ConnectNoti"
#define KD723DisConnectNoti @"KD723DisConnectNoti"

#define ABPMDiscover        @"ABPMDiscover"
#define ABPMConnectFailed   @"ABPMConnectFailed"
#define ABPMConnectNoti     @"ABPMConnectNoti"
#define ABPMDisConnectNoti  @"ABPMDisConnectNoti"

#define BP5CDiscover        @"BP5CDiscover"
#define BP5CConnectFailed   @"BP5CConnectFailed"
#define BP5CConnectNoti     @"BP5CConnectNoti"
#define BP5CDisConnectNoti  @"BP5CDisConnectNoti"

#define ContinuaBPDiscover        @"ContinuaBPDiscover"
#define ContinuaBPConnectFailed   @"ContinuaBPConnectFailed"
#define ContinuaBPConnectNoti     @"ContinuaBPConnectNoti"
#define ContinuaBPDisConnectNoti  @"ContinuaBPDisConnectNoti"

#define ABIConnectNoti      @"ABIConnectNoti"
#define ABIDisConnectNoti   @"ABIDisConnectNoti"
#define ArmKey    @"ABI-ARM"
#define LegKey    @"ABI-Leg"
#define ArmConnectNoti      @"ArmConnectNoti"
#define ArmDisConnectNoti   @"ArmDisConnectNoti"

//#define BPDeviceID      @"ID"
//#define BPSDKRightApi   @"OpenApiBP"

//result
#define kResultBPSYS @"sys"
#define kResultBPDIA @"dia"
#define kResultBPPulse @"heartRate"
#define kResultBPIHB @"irregular"
#define kResultBPHSD @"hsdValue"
#define kResultBPChooseHand @"chooseHand"
#define kResultBPBodyMove @"bodyMovement"
#define kResultBPStartAngle @"startAngle"
#define kResultBPAngleChange @"measureAngleChange"
#define kResultBPDataID @"dataID"
#define kResultBPMeasureDate @"time"
#define kResultBPMeasureDateTimeZoneInMin @"timeZoneInMin"
#define kResultBPSchemeID @"schemeID"
#define kResultBPHistoryIndex @"historyIndex"
#define kResultBPUnit @"unit"

#define kResultBPIsAutoMeasure @"isAutoMeasure"
#define kResultBPRemeasureMode @"remeasureMode"
#define kResultBPHasRawPressure @"hasRawPressure"
#define kResultBPStartMeasureAngle @"startMeasureAngle"
#define kResultBPMeasureAngleDelta @"measureAngleDelta"
#define kResultBPIsMeasureResultFailed @"isMeasureResultFailed"
#define kResultBPMeasureResultErrorCode @"measureResultErrorCode"
#define kResultBPMeasureResultRawPressure @"measureResultRawPressure"
#define kResultBPActivityStrengthList @"activityStrengthList"
#define kResultBPActivityStrengthLevel @"level"
#define kResultBPActivityStrengthAngle @"angle"
#define kResultBPActivityStrengthIsSleeping @"isSleeping"

//function
#define kFunctionBPUpAirMeasure @"upAirMeasureFlg"
#define kFunctionBPArmMeasure @"armMeasureFlg"
#define kFunctionBPHaveAngleSensor @"haveAngleSensor"
#define kFunctionBPSupportPowerOff @"havePowerOff"
#define kFunctionBPSupportOffline @"haveOffline"
#define kFunctionBPSupportClearMemory @"haveClearMemory"
#define kFunctionBPSupportBTConnectBack @"haveBlue"
#define kFunctionBPBTConnectBackOpen @"blueOpen"
#define kFunctionBPOfflineOpen @"offlineOpen"
#define kFunctionBPHaveHSD @"haveHSD"
#define kFunctionBPHaveAngleSet @"haveAngleSet"
#define kFunctionBPAutoLoopMeasureModel @"autoLoopMeasureModel"
#define kFunctionBPAutoConnect @"autoConnect"
#define kFunctionBPReConnectSwitch @"reConnectSwitch"
#define kFunctionBPhasOfflineSetingFlg @"offlineSetingFlg"
#define kFunctionBPofflineMeasureFlg @"offlineMeasureFlg"
#define kFunctionBPbtfunctionFlg @"btfunctionFlg"

#define kFunctionBPSupportUnitSetting @"hasUnitSetting"
#define kFunctionBPCurrentUnitIsKPa @"unitKPa"
#define kFunctionBPMutableUpload @"mutableUpload"
#define kFunctionBPDFU @"selfUpdate"
#define kFunctionBPSupportMoveDetect @"hasMoveDetect"
#define kFunctionBPSupportAlertSetting @"hasAlertSetting"
#define kFunctionBPSupportRawPressure @"hasRawPressure"
#define kFunctionBPRawPressureFormat @"rowPressureFormat"
#define kFunctionBPBackLightControl @"haveBackLightSetting"
#define kFunctionBPClockDisplayControl @"haveClockShowSetting"
#define kFunctionBPMaxHistoryCount @"maxHistoryCount"
#endif
