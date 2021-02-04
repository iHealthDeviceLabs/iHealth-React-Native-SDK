//
//  PT3SBTMacroFile.h
//  iHealthSDKStatic
//
//  Created by user on 2020/9/7.
//  Copyright © 2020 ihealthSDK. All rights reserved.
//

#ifndef PT3SBTMacroFile_h
#define PT3SBTMacroFile_h


/**
 PT3SBT Device Error Code
 */
typedef NS_ENUM(int, PT3SBTDeviceError) {
    PT3SBTDeviceError_Unknown = -1,// device send wrong error code
    PT3SBTDeviceError_CommunicationTimeout = 0,
    PT3SBTDeviceError_ReceivedCommandError,
    PT3SBTDeviceError_InputParameterError,
    PT3SBTDeviceError_MoreThanMaxNumbersOfUser,
    PT3SBTDeviceError_WriteFlashError,
    PT3SBTDeviceError_Disconnect,
};

typedef void(^DisposePT3SBTDeviceFunctionBlock)(NSDictionary *functionDict);

typedef void(^DisposePT3SBTErrorBlock)(PT3SBTDeviceError error);

/**
  battery

 @param battary battery
 */
typedef void (^DisposePT3SBTBatteryBlock)(NSNumber *battary);

/**
 TemperatureUnit
 */
typedef NS_ENUM(NSInteger, PT3SBTTemperatureUnit) {
    /// Degrees Celsius
    PT3SBTTemperatureUnit_C=1,
    /// Fahrenheit
    PT3SBTTemperatureUnit_F,
};
/**
  set unit result

 @param setResult YES:success NO:fail
 */
typedef void (^DisposePT3SBTSetUnit)(BOOL setResult);
/**
  get unit

 @param unit PT3SBTTemperatureUnit
 */
typedef void (^DisposePT3SBTGetUnit)(PT3SBTTemperatureUnit unit);

/**
  get memory data count

 @param count  data
 */
typedef void (^DisposePT3SBTGetMemoryCount)(NSNumber* count);

/**
 get memory data

 @param memoryDataArray  data
 */
typedef void (^DisposePT3SBTMemoryData)(NSMutableArray *memoryDataArray);

/**
  delete offline measurement data result block

 @param deleteResult YES:success NO:fail
 */
typedef void (^DisposePT3SBTDeleteData)(BOOL deleteResult);

/**
 get device info

 @param deviceInfoDic data
 */
typedef void (^DisposePT3SBTDeviceInfo)(NSDictionary *deviceInfoDic);

#define PT3SBTDiscover         @"PT3SBTDiscover"
#define PT3SBTConnectFailed    @"PT3SBTConnectFailed"
#define PT3SBTConnectNoti      @"PT3SBTConnectNoti"
#define PT3SBTDisConnectNoti   @"PT3SBTDisConnectNoti"

#endif /* PT3SBTMacroFile_h */
