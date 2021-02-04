//
//  ECGMacroFile.h
//  iHealthDemoCode
//
//  Created by zhiwei jing on 16/7/12.
//  Copyright © 2016年 zhiwei jing. All rights reserved.
//

#import "HealthUser.h"

#ifndef ECGMacroFile_h
#define ECGMacroFile_h


#define ECGUSBConnectNoti       @"ECGUSBConnect"
#define ECGUSBDisConnectNoti    @"ECGUSBDisConnectNoti"

#define ECG3Discover            @"ECG3Discover"
#define ECG3ConnectFailed       @"ECG3ConnectFailed"
#define ECG3ConnectNoti         @"ECG3ConnectNoti"
#define ECG3DisConnectNoti      @"ECG3DisConnectNoti"
#define ECG3DeviceID            @"ID"

/**
 ECG3ErrorID
 */
typedef NS_ENUM(NSUInteger, ECG3ErrorID) {
    /// Electrode Loss
    ECG3Error_ElectrodeLoss = 1,
    /// Electrode Loss Recovery
    ECG3Error_ElectrodeLossRecovery,
    /// Electrode Loss Timeout
    ECG3Error_ElectrodeLossTimeout,
    /// SDCard Communication Error
    ECG3Error_SDCardCommunicationError,
    /// Sample Module Error
    ECG3Error_SampleModuleError,
    /// Low Power
    ECG3Error_LowPower,
    /// Device Memory Full
    ECG3Error_DeviceMemoryFull,
    /// Disconnect
    ECG3Error_Disconnect,
    /// Parameter Error
    ECG3Error_ParameterError = 400,
    /// Command timeout
    ECG3Error_CommandTimeout = 500,
};

typedef NS_ENUM(NSUInteger, ECG3USBError) {
    /// Query command timeout
    ECG3USBError_QuerySDCardInfoTimeout,
    /// Received SD card info is wrong.
    ECG3USBError_SDCardInfoError,
    /// Receive devce's error log: SD card error.
    ECG3USBError_SDCardError,
    /// There is not enough space for ECG's offline data.
    ECG3USBError_iOSDeviceFlashNotEnough,
    /// Receive wrong data
    ECG3USBError_AFilePackageIndexNotMatch,
    /// Receive wrong data
    ECG3USBError_BFilePackageIndexNotMatch,
    /// Receive data timeout
    ECG3USBError_ReceiveDataTimeout,
    /// Save file error
    ECG3USBError_SaveFileError,
    /// Device is disconnected.
    ECG3USBError_DeviceDisconnect,
    /// Format fail.
    ECG3USBError_DeviceReplyFormatFail,
    /// Splice fail.
    ECG3USBError_SpliceFail,
    /// Get data cache fail.
    ECG3USBError_GetDataCacheFail,
    /// Filter fail.
    ECG3USBError_FilterFail,
    /// Format command timeout.
    ECG3USBError_DeviceFormatTimeout,
    /// Command timeout
    ECG3USBError_CommandTimeout = 500,
    
};

#endif /* ECGMacroFile_h */
