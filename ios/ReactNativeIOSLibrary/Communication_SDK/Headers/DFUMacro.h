//
//  DFUMacro.h
//  iHealthSDKStatic
//
//  Created by Lei Bao on 2017/7/18.
//  Copyright © 2017年 daiqingquan. All rights reserved.
//

#ifndef DFUMacro_h
#define DFUMacro_h

@class DFUDeviceFirmwareInfo;
@class DFUServerFirmwareInfo;

/**
 DFU error code
 */
typedef NS_ENUM(NSInteger, DFUError) {
    /// Device type does not support.
    DFUError_UnsupportedDeviceType = 100,
    /// UUID is invalid.
    DFUError_InvalidUUID = 101,
    /// Command timeout.
    DFUError_CommandTimeOut = 102,
    /// Device is not connected.
    DFUError_NoConnectedDevice = 104,
    /// During DFU, other commands cannot be executed.
    DFUError_InUpgradeCannotExecuteCommand = 105,
    /// Firmware version is invalid.
    DFUError_InvalidFirmwareVersion = 106,
    /// Hardware version is invalid.
    DFUError_InvalidHardwareVersion = 107,
    /// The firmware info file is wrong.
    DFUError_InvalidFirmwareInfoFile = 108,
    /// The firmware file is wrong.
    DFUError_InvalidFirmwareFile = 109,
    /// It indicates network error.
    DFUError_NetworkError = 200,
    /// Server error
    DFUError_ServerError = 202,
    /// Requested file does not exist.
    DFUError_RequestedFileNotExist = 203,
    /// File save error
    DFUError_FileSaveError = 204,
    /// Info file does not pass check.
    DFUError_InfoFileCheckNotPass = 205,
    /// Firmware file does not pass check.
    DFUError_firmwareFileCheckNotPass = 206,
    /// Device disconnects before command finish.
    DFUError_DeviceDisconnect = 300,
    /// Device stops update.
    DFUError_DeviceStopUpdate = 301,
    /// The firmware file does not exist.
    DFUError_NoFirmwareFile = 402,
    /// Delete error
    DFUError_DeleteError = 407,
    /// Delete file , but file does not exist
    DFUError_DeleteWhileFileNotExist = 408,
    /// Device flash error (only support in ECG3 DFU)
    DFUError_DeviceFlashError = 408,
    
};

/**
 DFU device type
 */
typedef NS_ENUM(NSInteger, DFUDeviceType) {
    /// Unknown
    DFUDeviceType_Unknown = -1,
    /// AM3
    DFUDeviceType_AM3,
    /// AM3S
    DFUDeviceType_AM3S,
    /// AM4
    DFUDeviceType_AM4,
    /// PO3
    DFUDeviceType_PO3,
    /// HS2
    DFUDeviceType_HS2,
    /// HS4
    DFUDeviceType_HS4,
    /// ECG
    DFUDeviceType_ECG,
    /// BP5S
    DFUDeviceType_BP5S,
    /// ABPM
    DFUDeviceType_ABPM,
    /// BG5S
    DFUDeviceType_BG5S,
    /// HS2S
    DFUDeviceType_HS2S,
    /// placeholder
    DFUDeviceType_MAX,
};

/**
 Cannot upgrade reason
 */
typedef NS_ENUM(NSInteger, DFUDeviceReplyCannotUpgradeReason){
    /// Unknown
    DFUDeviceReplyCannotUpgradeReason_Unknown = 1,
    /// battery is low
    DFUDeviceReplyCannotUpgradeReason_Battery,
    /// cannot upgrade when measuring
    DFUDeviceReplyCannotUpgradeReason_InMeasuring,
};

/**
 Upgrade fail reason
 */
typedef NS_ENUM(NSInteger, DFUUpgradeFailReason) {
    /// Unknown
    DFUUpgradeFailReason_Unknown = -1,
    /// Device recieve wrong data or no data
    DFUUpgradeFailReason_DeviceRecieveWrongDataOrNotRecieve,
    /// Write MCU error
    DFUUpgradeFailReason_WriteMCUError,
    /// Device stop upgrade
    DFUUpgradeFailReason_DeviceStopUpgrade,
    /// Delete firmware error (only support in ECG3 DFU)
    DFUUpgradeFailReason_DeleteFirmwareError,
    /// Device flash error (only support in ECG3 DFU)
    DFUUpgradeFailReason_DeviceFlashError,
};

/**
 Transmission result type
 */
typedef NS_ENUM(NSInteger, DFUTransmissionResultType) {
    /// Unknown
    DFUTransmissionResultType_Unknown = -1,
    /// All firmware transfer finish
    DFUTransmissionResultType_Finish,
    /// Pasuse because device needs write MCU
    DFUTransmissionResultType_Pause,
};

/**
 Pause reason
 */
typedef NS_ENUM(NSInteger, DFUPauseReason) {
    /// Unkonw reason
    DFUPauseReason_Unknown = 0,
    /// Need write MCU, if finished, device can be connected.
    DFUPauseReason_RebootAndNeedReconnect,
};


/**
 DFU state
 */
typedef NS_ENUM(NSInteger, DFUState) {
    /// Unknown
    DFUState_Unknown = -1,
    /// Busy
    DFUState_Busy,
    /// Free
    DFUState_Free,
};


/**
 DFU error block

 @param error DFUError enum
 */
typedef void (^DFUErrorBlock)(DFUError error);

/**
 Device firmware information block

 @param deviceFirmwareInfo DFUDeviceFirmwareInfo object
 */
typedef void (^QueryDeviceFirmwareInfoSuccessBlock)(DFUDeviceFirmwareInfo *deviceFirmwareInfo);

/**
 Server firmware information block

 @param serverFirmwareInfo DFUServerFirmwareInfo object
 */
typedef void (^QueryServerFirmwareInfoSuccessBlock)(DFUServerFirmwareInfo *serverFirmwareInfo);

/**
 Download firmware file success block

 @param firmwareIdentifier firmware ID
 */
typedef void (^DownloadFirmwareSuccessBlock)(NSString *firmwareIdentifier);

/**
 Download firmware file start block
 */
typedef void (^DownloadFirmwareStartBlock)(void);

/**
 Download firmware file progress block

 @param progress 0-100
 */
typedef void (^DownloadFirmwareProgressBlock)(NSInteger progress);

/**
 CancelDownloadFirmwareSuccessBlock
 */
typedef void (^CancelDownloadFirmwareSuccessBlock)(void);

/**
 DeviceReplyCannotUpgradeBlock

 @param reason DFUDeviceReplyCannotUpgradeReason enum
 */
typedef void(^DeviceReplyCannotUpgradeBlock)(DFUDeviceReplyCannotUpgradeReason reason);

/**
 TransferBeginBlock
 */
typedef void(^TransferBeginBlock)(void);

/**
 TransferProgressBlock

 @param progress 0-100
 */
typedef void(^TransferProgressBlock)(NSInteger progress);

/**
 TransferSuccessBlock

 @param writeMCUSpeed unit:bytes/second
 */
typedef void(^TransferSuccessBlock)(NSUInteger writeMCUSpeed);

/**
 TransferResultBlock

 @param type DFUTransmissionResultType enum
 @param reason DFUPauseReason enum, -1 if type is DFUTransmissionResultType_Finish;
 @param pauseLength 0-255s,-1 if type is DFUTransmissionResultType_Finish;
 */
typedef void(^TransferResultBlock)(DFUTransmissionResultType type,DFUPauseReason reason,NSInteger pauseLength);

/**
 UpgradeSuccessBlock
 */
typedef void(^UpgradeSuccessBlock)(void);

/**
 UpgradeFailBlock

 @param reason DFUUpgradeFailReason enum
 */
typedef void(^UpgradeFailBlock)(DFUUpgradeFailReason reason);

/**
 StopUpgradeSuccessBlock
 */
typedef void(^StopUpgradeSuccessBlock)(void);

/**
 DeleteFirmwareSuccessBlock
 */
typedef void(^DeleteFirmwareSuccessBlock)(void);

#endif /* DFUMacro_h */
