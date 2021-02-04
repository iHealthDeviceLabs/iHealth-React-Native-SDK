//
//  POMacroFile.h
//  POSDK
//
//  Created by 小翼 on 14-8-11.
//  Copyright (c) 2014年 hejiasu. All rights reserved.
//

#import "HealthUser.h"

#ifndef POSDK_POMacroFile_h
#define POSDK_POMacroFile_h

#define PO3DeviceID @"ID"
#define PO3SDKRightApi  @"OpenApiSpO2"

#define PO3Discover       @"PO3Discover"
#define PO3ConnectFailed   @"PO3ConnectFailed"
#define PO3ConnectNoti @"PO3ConnectNoti"
#define PO3DisConnectNoti @"PO3DisConnectNoti"

#define PO1Discover       @"PO1Discover"
#define PO1ConnectFailed   @"PO1ConnectFailed"
#define PO1ConnectNoti @"PO1ConnectNoti"
#define PO1DisConnectNoti @"PO1DisConnectNoti"
/**
 PO3 error code
 */
typedef NS_ENUM(NSUInteger, PO3ErrorID) {
    /// Bluetooth Communication Error
    PO3Error_OverTime  = 0,
    /// Send failed
    PO3Error_ResetDeviceFaild,
    /// Device is disconnected
    PO3Error_Disconnect,
    /// ParameterError
    PO3Error_ParameterError = 400,
    /// firmware version is not supported
    PO3Error_FirmwareVersionIsNotSupported
};

typedef NS_ENUM(NSUInteger, PO1ErrorID) {
    /// Bluetooth Communication Error
    PO1Error_OverTime  = 0,
    /// Send failed
    PO1Error_ResetDeviceFaild,
    /// Device is disconnected
    PO1Error_Disconnect,
    /// ParameterError
    PO1Error_ParameterError = 400,
    /// firmware version is not supported
    PO1Error_FirmwareVersionIsNotSupported
};


/**
 PO3ErrorID
 */
typedef void (^DisposePO3ErrorBlock)(PO3ErrorID errorID);
/**
 sync time
 */
typedef void (^DisposePO3SyncTimeBlock)(BOOL resetSuc);
/**
 start measure
 */
typedef void (^DisposePO3StartMeasure)(BOOL resetSuc);
/**
 measure data
 */
typedef void (^DisposePO3MeasureData)(NSDictionary *measureDataDic);
/**
 finish measure
 */
typedef void (^DisposePO3FinishMeasure)(BOOL finishData);

/**
 offline data count
 */
typedef void (^DisposePO3OfflineDataCount)(NSNumber* dataCount);
/**
 offline data
 */
typedef void (^DisposePO3OfflineData)(NSDictionary *OfflineData);
/**
 offline wave data
 */
typedef void (^DisposePO3OfflineWaveData)(NSDictionary *offlineWaveDataDic);
/**
 finish upload
 */
typedef void (^DisposePO3FinishUpload)(BOOL resetSuc);
/**
 reset device
 */
typedef void (^DisposePO3ResetDeviceBlock)(BOOL resetSuc);
/**
 battery
 */
typedef void (^DisposePO3BatteryBlock)(NSNumber *battery);
/**
 disconnect
 */
typedef void (^DisposePO3DisconnectBlock)(BOOL resetSuc);
/**
 send data
 */
typedef void (^DisposeSendPO3DataBlock)(void);


/**
 PO1ErrorID
 */
typedef void (^DisposePO1ErrorBlock)(PO1ErrorID errorID);
/**
 battery
 */
typedef void (^DisposePO1BatteryBlock)(NSNumber *battery);
/**
 disconnect
 */
typedef void (^DisposePO1DisconnectBlock)(BOOL resetSuc);

/**
 set beep
 */
typedef void (^DisposePO1SetDeviceBeep)(BOOL setResult);


typedef void(^DisposePO1DeviceFunctionBlock)(NSDictionary *functionDict);

#endif
