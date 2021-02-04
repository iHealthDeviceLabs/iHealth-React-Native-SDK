//
//  BGMacroFile.h
//  BGDemoCode
//
//  Created by zhiwei jing on 14-6-29.
//  Copyright (c) 2014年 zhiwei jing. All rights reserved.
//

#import "HealthUser.h"
#import "BGDevice.h"
#import "BGController.h"
@class BG5SStateInfo;
@class BG5SRecordModel;

#ifndef BGDemoCode_BGMacroFile_h
#define BGDemoCode_BGMacroFile_h

/**
 BG5 open mode
 */
typedef NS_ENUM(NSUInteger, BGOpenMode) {
    /// BGOpenMode_Strip means booting the meter by insert the strip
    BGOpenMode_Strip = 1,
    /// BGOpenMode_Hand means booting the meter by pressing the on/off button.
    BGOpenMode_Hand = 2,
};

/**
 BG5\BG5S measure mode
 */
typedef NS_ENUM(NSUInteger, BGMeasureMode) {
    /// BGMeasureMode_Blood means blood measurement mode
    BGMeasureMode_Blood = 1,
    /// BGMeasureMode_NoBlood means control solution measurement mode.
    BGMeasureMode_NoBlood = 2,

};

/**
 BG code mode
 */
typedef NS_ENUM(NSUInteger, BGCodeMode) {
    /// BGCodeMode_GOD means GOD blood test strip.
    BGCodeMode_GOD = 1,
    /// BGCodeMode_GDH means GDH Blood test strip.
    BGCodeMode_GDH = 2,
};

/**
 BG unit
 */
typedef NS_ENUM(NSUInteger, BGUnit) {
    /// Unknown
    BGUnit_Unknown = 0,
    /// mmol/L
    BGUnit_mmolPL = 1,
    /// mg/dL
    BGUnit_mgPmL = 2,
};

/**
 BG1 error code
 */
typedef NS_ENUM(NSInteger,BG1Error){
    /// Battery is low.
    BG1Error_LowBattery = 0,
    /// Glucose test result is out of the measurement range.
    BG1Error_ResultOutOfMeasurementRage = 1,
    /// 2.5V reference voltage error, not normal measurement, please repeat the test.
    BG1Error_UnvalidReferenceVoltage = 2,
    /// Strip is used or unknown moisture detected, discard the test strip and repeat the test with a new strip.
    BG1Error_StripUsed = 3,
    /// CODE value check error. This error need let user scan code and call the send code function again,no alert need to show.
    BG1Error_CodeError = 4,
    /// The environmental temperature is beyond normal range, place the meter at room temperature for at least 30 minutes, then repeat the test.
    BG1Error_RoomTemperatureOutOfRange1 = 5,
    /// The environmental temperature is beyond normal range, place the meter at room temperature for at least 30 minutes, then repeat the test.
    BG1Error_RoomTemperatureOutOfRange2 = 6,
    /// Authentication failed more than 10 times.
    BG1Error_AuthenticationFailed = 7,
    /// Packet loss in the process of sending CODE.
    BG1Error_CodeSendLost = 8,
    /// Tooling inspection process is not completed.
    BG1Error_ToolingTestFailed = 9,
    /// Encryption burn write bit is empty.
    BG1Error_EncryptionFailed = 10,
    /// Compulsory Authentication is not passed.
    BG1Error_CompulsoryAuthenticationFaild = 11,
    /// Glucose test result is low.
    BG1Error_ResultLow = 12,
    /// Glucose test result is high.
    BG1Error_ResultHigh = 13,
    /// BG unknown.
    BG1Error_Unknown = 300,
    /// BG time out.
    BG1Error_TimeOut = 301,
    /// BG disConnented.
    BG1Error_DisConnented = 303,
    /// BG sleeping mode.
    BG1Error_SleepingMode =330,
    /// Hand shake failed.
    BG1Error_HandShakeFailed = 331,
    /// Parameter input error.
    BG1Error_ParameterError = 400,
};


//UI
#define kNotificationNameNeedAudioPermission @"LetkNotificationNameNeedAudioPermission"
#define kNotificationNameAudioDeviceInsert @"kNotificationNameAudioDeviceInsert"
#define kNotificationNameBG1DidDisConnect @"kNotificationNameBG1DidDisConnect"


/**
 Discover BG1
 */
typedef void (^DisposeBG1DiscoverBlock)(void);

/**
 BG1 IDPS

 @param idpsDic IDPS dictionary
 */
typedef void (^DisposeBG1IDPSBlock)(NSDictionary* idpsDic);

/**
 Connect BG1 successfully
 */
typedef void (^DisposeBG1ConnectBlock)(void);

/**
 BG1 error block

 @param errorID BG1Error enum
 */
typedef void (^DisposeBG1ErrorBlock)(BG1Error errorID);

/**
 BG1 send code result
 */
typedef void (^DisposeBG1SendCodeResultBlock)(void);

/**
 Strip is insered
 */
typedef void (^DisposeBGStripInBlock)(void);
//
/**
 Strip is pulled off
 */
typedef void (^DisposeBGStripOutBlock)(void);

/**
 Blood is droped
 */
typedef void (^DisposeBGBloodBlock)(void);

/**
 Measurement result block

 @param result dictionary
 */
typedef void (^DisposeBGResultBlock)(NSDictionary* result);

/**
 BG send code result block

 @param sendOk YES: success NO:fail
 */
typedef void (^DisposeBGSendCodeBlock)(BOOL sendOk);

/**
 BG error block

 @param errorID BG error code
 */
typedef void (^DisposeBGErrorBlock)(NSNumber* errorID);

/**
 BG5 keep connection result

 @param sendOk YES:success NO:fail
 */
typedef void (^DisposeBG5KeepConnectBlock)(BOOL sendOk);

/**
 BG5 set time result

 @param setResult YES:success NO:fail
 */
typedef void (^DisposeBGSetTime)(BOOL setResult);

/**
 BG5 set unit result

 @param setResult YES:success NO:fail
 */
typedef void (^DisposeBGSetUnit)(BOOL setResult);

/**
 BG5 get bottleID result

 @param bottleID bottleID
 */
typedef void (^DisposeBGBottleID)(NSNumber *bottleID);

/**
 BG5 offline measurement data quantity block

 @param dataCount quantity
 */
typedef void (^DisposeBGDataCount)(NSNumber* dataCount);

/**
 BG5 offline measurement data block

 @param historyDataDic data
 */
typedef void (^DisposeBGHistoryData)(NSDictionary *historyDataDic);

/**
 BG5 delete offline measurement data result block

 @param deleteOk YES:success NO:fail
 */
typedef void (^DisposeBGDeleteData)(BOOL deleteOk);

/**
 BG5 send bottle ID result block

 @param sendOk YES:success NO:fail
 */
typedef void(^DisposeBGSendBottleIDBlock)(BOOL sendOk);

/**
 BG5 get code information

 @param codeDic dictionary
 */
typedef void (^DisposeBGCodeDic)(NSDictionary *codeDic);

/**
 BG5 send code result block

 @param sendOk YES:success NO:fail
 */
typedef void (^DisposeBGSendCodeBlock)(BOOL sendOk);

/**
 BG5 open mode block

 @param mode BGOpenMode enum
 */
typedef void (^DisposeBGStartModel)(BGOpenMode mode);

/**
 BG device battery block

 @param energy normal range:0-100;255 means in charging
 */
typedef void (^DisposeBGBatteryBlock)(NSNumber* energy);


#define kNotificationNameBG3ConnectSuccess @"kNotificationNameBG3ConnectSuccess"
#define kNotificationNameBG3DidDisConnect @"kNotificationNameBG3DidDisConnect"


// ------ BG5 Baolei ------
#define BG5ConnectNoti @"BG5ConnectNoti"
#define BG5DisConnectNoti @"BG5DisConnectNoti"

/**
 BG5 error code
 */
typedef NS_ENUM(NSInteger, BG5Error) {
    /// BG5Error_Unknown: Unknown error
    BG5Error_Unknown = -1,
    /// BG5Error_LowBattery: Battery is low.
    BG5Error_LowBattery = 0,
    /// BG5Error_ResultOutOfMeasurementRage: Glucose test result is out of the measurement range.
    BG5Error_ResultOutOfMeasurementRage = 1,
    /// BG5Error_UnvalidReferenceVoltage: Reference voltage error, not normal measurement, please repeat the
    BG5Error_UnvalidReferenceVoltage = 2,
    /// BG5Error_StripUsed: Strip is used or unknown moisture detected, discard the test strip and repeat the
    BG5Error_StripUsed = 3,
    /// BG5Error_ErrorOccurInEEPROM: Reading transmission error. Repeat the test with a new test strip. If the
    BG5Error_ErrorOccurInEEPROM = 4,
    /// BG5Error_RoomTemperatureOutOfRange1: The environmental temperature is beyond normal range, place the
    BG5Error_RoomTemperatureOutOfRange1 = 5,
    /// BG5Error_RoomTemperatureOutOfRange2: The environmental temperature is beyond normal range, place the
    BG5Error_RoomTemperatureOutOfRange2 = 6,
    /// BG5Error_TestStripCodingError1: Test strip coding error.
    BG5Error_TestStripCodingError1 = 7,
    /// BG5Error_TestStripCodingError2: Test strip coding error.
    BG5Error_TestStripCodingError2 = 8,
    /// BG5Error_PullOffStripWhenMeasuring: Strip removed in the middle of reading, repeat the test with a new
    BG5Error_PullOffStripWhenMeasuring = 9,
    /// BG5Error_ShouldPullOffStripAfterReadingResult: Pull off strips after measuring
    BG5Error_ShouldPullOffStripAfterReadingResult = 10,
    /// BG5Error_CannotWriteSNOrKey: SN or KEY write error
    BG5Error_CannotWriteSNOrKey = 11,
    /// BG5Error_NeedSetTime: Please set time.
    BG5Error_NeedSetTime = 12,
    /// BG5Error_StripNumberIsZero: 0 test strips remaining.
    BG5Error_StripNumberIsZero = 13,
    /// BG5Error_StripExpired: Test strip expired.
    BG5Error_StripExpired = 14,
    /// BG5Error_CannotMeasureWhenCharging: Unplug the charging cable before testing.
    BG5Error_CannotMeasureWhenCharging = 15,
    /// BG5Error_InputParametersError: Parameter input error.
    BG5Error_InputParametersError = 400,
    /// BG5Error_FunctionCallOrderError: Fucntion call order error
    BG5Error_FunctionCallOrderError = 402,
    /// BG5Error_MeasureModeNotMatch: Measure mode is not match.
    BG5Error_MeasureModeNotMatch = 403,
    /// BG5Error_CommandTimeout: Command timeout
    BG5Error_CommandTimeout = 500,
    /// BG5Error_CommandNotSupport: Command is not supported for current device.
    BG5Error_CommandNotSupport = 501,
};

#define kNotificationNameBG5SDidDiscover        @"BG5SDiscover"
#define kNotificationNameBG5SConnectFail        @"BG5SConnectFailed"
#define kNotificationNameBG5SConnectSuccess     @"BG5SConnectNoti"
#define kNotificationNameBG5SDidDisConnect      @"BG5SDisConnectNoti"

/**
 BG5SCommandAction Enum
 */
typedef NS_ENUM(NSInteger, BG5SCommandAction) {
    /// placeholder
    BG5SCommandAction_Unknown = -1,
    /// Query device state information
    BG5SCommandAction_QueryBG5SStateInfo,
    /// Set device time
    BG5SCommandAction_SetBG5STime,
    /// Set device unit
    BG5SCommandAction_SetBG5SUnit,
    /// Send code
    BG5SCommandAction_SendBG5SCode,
    /// Delete Strip used information
    BG5SCommandAction_DeleteBG5SStripUsedInfo,
    /// Query device offline measurement data
    BG5SCommandAction_QueryBG5SRecord,
    /// Delete device offline measurement data
    BG5SCommandAction_DeleteBG5SRecord,
    /// Set measure mode
    BG5SCommandAction_StartBG5SMeasure,
    /// Device send error code
    BG5SCommandAction_ErrorCode,
    /// Strip is inserted
    BG5SCommandAction_StripInsert,
    /// Strip is pulled off
    BG5SCommandAction_StripPullOff,
    /// Blood is dropped
    BG5SCommandAction_DropBlood,
    /// Device send result
    BG5SCommandAction_Result,
    /// Device enters charging state
    BG5SCommandAction_EnterChagre,
    /// Device exits charging state
    BG5SCommandAction_ExitCharge,
    
};

/**
 BG5S error code
 */
typedef NS_ENUM(NSInteger, BG5SError) {
    /// Unknown error
    BG5SError_Unknown = -1,
    /// Only showed in BG5S's screen and need charging
    BG5SError_LowBattery = 0,
    /// Strip removed in the middle of reading, repeat the test with a new strip.
    BG5SError_PullOffStripWhenMeasuring = 1,
    /// Reference voltage error, not normal measurement, please repeat the test.
    BG5SError_UnvalidReferenceVoltage = 2,
    /// Strip is used or unknown moisture detected, discard the test strip and repeat the test with a new strip.
    BG5SError_StripUsed = 3,
    /// Reading transmission error. Repeat the test with a new test strip. If the problem persists, contact iHealth customer service for assistance.
    BG5SError_ErrorOccurInEEPROM = 4,
    /// The environmental temperature is beyond normal range, place the meter at room temperature for at least 30 minutes, then repeat the test.
    BG5SError_LowTemperature = 5,
    /// The environmental temperature is beyond normal range, place the meter at room temperature for at least 30 minutes, then repeat the test.
    BG5SError_HighTemperature = 6,
    /// Only showed in BG5S's screen.
    BG5SError_BluetoothError = 7,
    /// Glucose test result is low.
    BG5SError_ResultLow = 8,
    /// Glucose test result is high.
    BG5SError_ResultHigh = 9,
    /// Reset and if the problem persists, contact iHealth customer service for assistance.
    BG5SError_FactoryError = 10,
    ///  Parameter input error.
    BG5SError_InputParametersError = 400,
    ///  Quantity not match
    BG5SError_RecordTotalNumberNotMatchTransferTotalNumber = 401,
    ///  Single packet is not full.
    BG5SError_RecordPacketNotMatch = 402,
    ///  Packet index not match.
    BG5SError_RecordPackerIndexNotMatch = 403,
    ///  Command timeout
    BG5SError_CommandTimeout = 500,
    ///  Command is not supported for current device.
    BG5SError_CommandNotSupport = 501,
};


/**
 BG5S strip state
 */
typedef NS_ENUM(NSInteger, BG5SStripState) {
    /// Unknown state
    BG5SStripState_Unknown = -1,
    /// Insert
    BG5SStripState_Insert,
    /// Pull off
    BG5SStripState_PullOff,
};
/**
 BG5S charging state
 */
typedef NS_ENUM(NSInteger, BG5SChargeState) {
    /// Unknown state
    BG5SChargeState_Unknown = -1,
    /// In charging
    BG5SChargeState_Charging,
    /// Not in charging
    BG5SChargeState_ExitCharge,
};

/**
 BG5SStateInfoBlock

 @param stateInfo BG5SStateInfo object
 */
typedef void(^BG5SStateInfoBlock)(BG5SStateInfo *stateInfo);

/**
 BG5SRecordBlock

 @param array offline measurement data array
 */
typedef void(^BG5SRecordBlock)(NSArray *array);
/**
 Block without return parameters
 */
typedef void(^BG5SSuccessBlock)(void);

/**
 Block show the result of setting code
 
 @param success YES:success NO:fail
 */
typedef void(^BG5SSetCodeResultBlock)(BOOL success);


typedef void(^BG5SDeviceInfoBlock)(NSDictionary* deviceInfoDic);


//typedef void(^BG5SRecordBlock)(NSArray *array);

/**
 Error block with error type
 
 @param error error type
 */
typedef void(^BG5SSDKErrorBlock)(BG5SError error,NSString *detailInfo);


/*
   BG1S  code
 */

#define BG1SDiscover        @"BG1SDiscover"
#define BG1SConnectFailed   @"BG1SConnectFailed"
#define BG1SConnectNoti     @"BG1SConnectNoti"
#define BG1SDisConnectNoti  @"BG1SDisConnectNoti"

typedef NS_ENUM(NSUInteger, BG1SDeviceError) {
   
    BG1SDeviceError0=0,
    BG1SDeviceError1,
    BG1SDeviceError2,
    BG1SDeviceError3,
    
};
typedef void(^BlockBG1SDeviceFunction)(NSDictionary *functionDict);

typedef void(^BlockBG1SError)(BG1SDeviceError error);

/**
 Strip is insered
 */
typedef void (^DisposeBG1SStripInBlock)(BOOL inORout);

#endif
