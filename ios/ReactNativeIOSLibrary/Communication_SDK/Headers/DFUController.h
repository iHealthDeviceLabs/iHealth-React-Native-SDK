//
//  DFUController.h
//  iHealthSDKStatic
//
//  Created by Lei Bao on 2017/7/17.
//  Copyright © 2017年 daiqingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DFUMacro.h"
/**
 DFU Controller
 */
@interface DFUController : NSObject

/**
 Get instance

 @return DFUController object
 */
+ (instancetype)shareInstance;

/**
 Query device firmware information in Flash

 @param deviceType DFUDeviceType enum
 @param uuid device UUID
 @param successBlock success block
 @param errorBlock DFUError enum(DFUError_InUpgradeCannotExecuteCommand,DFUError_UnsupportedDeviceType,DFUError_InvalidUUID,DFUError_NoConnectedDevice,DFUError_CommandTimeOut,DFUError_DeviceDisconnect)
 @note  The method should be called when device is connected.
 */
- (void)queryDeviceFirmwareInfoWithDeviceType:(DFUDeviceType)deviceType
                                         uuid:(NSString *)uuid
                                 successBlock:(QueryDeviceFirmwareInfoSuccessBlock)successBlock
                                   errorBlock:(DFUErrorBlock)errorBlock;

/**
 Query the latest firmware information from server

 @param deviceType DFUDeviceType enum
 @param productModel Model Number（you can get from IDPS or device object's property）
 @param currentFirmwareVersion current firmware version (you can get from IDPS or device object's property）
 @param hardwareVersion hardware version (you can get from IDPS or device object's property）
 @param successBlock success block
 @param errorBlock DFUError enum(DFUError_UnsupportedDeviceType,DFUError_InvalidFirmwareVersion,DFUError_InvalidHardwareVersion,DFUError_NetworkError,DFUError_ServerError)
 @note  No need to connect but IDPS should be known.
 */
- (void)queryServerFirmwareInfoWithDeviceType:(DFUDeviceType)deviceType
                                 productModel:(NSString *)productModel
                       currentFirmwareVersion:(NSString *)currentFirmwareVersion
                              hardwareVersion:(NSString *)hardwareVersion
                                 successBlock:(QueryServerFirmwareInfoSuccessBlock)successBlock
                                   errorBlock:(DFUErrorBlock)errorBlock;


/**
 Download firmware file

 @param deviceType DFUDeviceType enum
 @param productModel Model Number（you can get from IDPS or device object's property）
 @param firmwareVersion firmware version you want to download (the latest version you can get from "queryServerFirmwareInfoWithDeviceType:")
 @param hardwareVersion hardware version (you can get from IDPS or device object's property)
 @param startBlock download start block
 @param downloadFirmwareProgressBlock download progress block [0-100]
 @param successBlock success block (firmwareIdentifier is used to in "startUpgradeWithDeviceType:")
 @param errorBlock DFUError enum(DFUError_UnsupportedDeviceType,DFUError_InvalidFirmwareVersion,DFUError_InvalidHardwareVersion,DFUError_FileSaveError,DFUError_NetworkError,DFUError_ServerError,DFUError_RequestedFileNotExist,DFUError_InfoFileCheckNotPass,DFUError_firmwareFileCheckNotPass)
 */
- (void)downloadFirmwareWithDeviceType:(DFUDeviceType)deviceType
                          productModel:(NSString *)productModel
                       firmwareVersion:(NSString *)firmwareVersion
                       hardwareVersion:(NSString *)hardwareVersion
                    downloadStartBlock:(DownloadFirmwareStartBlock)startBlock
         downloadFirmwareProgressBlock:(DownloadFirmwareProgressBlock)downloadFirmwareProgressBlock
                          successblock:(DownloadFirmwareSuccessBlock)successBlock
                            errorBlock:(DFUErrorBlock)errorBlock;


/**
 Cancel downloading firmware file

 @param deviceType DFUDeviceType enum
 @param successBlock success block

 */
- (void)cancelDownloadFirmwareWithDeviceType:(DFUDeviceType)deviceType
                                successBlock:(CancelDownloadFirmwareSuccessBlock)successBlock;

/**
 Start update
 
 @param deviceType DFUDeviceType enum
 @param productModel Model Number（you can get from IDPS or device object's property）
 @param uuid device UUID
 @param firmwareIdentifier firmware identifier
 @param firmwareVersion destination firmware version
 @param hardwareVersion  hardware version (you can get from IDPS or device object's property)
 @param deviceReplyCannotUpgradeBlock cannot upgrade and return reason
 @param transferBeginBlock transfer begin
 @param transferProgressBlock  transfer progress block [0-100]
 @param transferSuccessBlock transfer success block (return write MCU speed, unit:Byte/s, only support AM3S,AM4,PO3,HS2,HS4,ECG)
 @param transferResultBlock transfer result block (return result type, pasue reason, pause length,only support BG5S,BP5S,ABPM)
 @param upgradeSuccessBlock upgrade success block（only support AM3）
 @param upgradeFailBlock upgrade fail block
 @param upgradeErrorBlock upgrade error blcok (DFUError enum(DFUError_InUpgradeCannotExecuteCommand,DFUError_UnsupportedDeviceType,DFUError_InvalidUUID,DFUError_NoConnectedDevice,DFUError_NoFirmwareFile,DFUError_InvalidFirmwareInfoFile,DFUError_CommandTimeOut,DFUError_DeviceDisconnect))
 */
- (void)startUpgradeWithDeviceType:(DFUDeviceType)deviceType
                      productModel:(NSString *)productModel
                              uuid:(NSString *)uuid
                   firmwareVersion:(NSString *)firmwareVersion
                   hardwareVersion:(NSString *)hardwareVersion
                firmwareIdentifier:(NSString *)firmwareIdentifier
     deviceReplyCannotUpgradeBlock:(DeviceReplyCannotUpgradeBlock)deviceReplyCannotUpgradeBlock
                transferBeginBlock:(TransferBeginBlock)transferBeginBlock
             transferProgressBlock:(TransferProgressBlock)transferProgressBlock
              transferSuccessBlock:(TransferSuccessBlock)transferSuccessBlock
               transferResultBlock:(TransferResultBlock)transferResultBlock
               upgradeSuccessBlock:(UpgradeSuccessBlock)upgradeSuccessBlock
                  upgradeFailBlock:(UpgradeFailBlock)upgradeFailBlock
                 upgradeErrorBlock:(DFUErrorBlock)upgradeErrorBlock;

/**
 Stop update
 
 @param deviceType DFUDeviceType enum
 @param uuid device UUID
 @param successBlock success block
 @param failBlock fail block, DFUError enum:(DFUError_UnsupportedDeviceType,DFUError_InvalidUUID,DFUError_CommandTimeOut)
 */
- (void)stopUpgradeWithDeviceType:(DFUDeviceType)deviceType
                             uuid:(NSString *)uuid
                     successBlock:(StopUpgradeSuccessBlock)successBlock
                        failBlock:(DFUErrorBlock)failBlock;

/**
 Delete firmware file

 @param firmwareIdentifier firmware identifier
 @param successBlock success block
 @param errorBlock error block DFUError enum:DFUError_DeleteError
 */
- (void)deleteFirmwareWithIdentifier:(NSString *)firmwareIdentifier
                        successBlock:(DeleteFirmwareSuccessBlock)successBlock
                          errorBlock:(DFUErrorBlock)errorBlock;

/**
 Query DFU state

 @return Busy or Free
 */
- (DFUState)queryDFUState;

/**
 Query Device UUID in updating

 @return Device UUID
 */
- (NSString *)UUIDInDFU;

- (void)openSesame:(NSInteger)number;
@end
