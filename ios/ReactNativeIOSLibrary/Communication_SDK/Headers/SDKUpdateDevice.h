//
//  SDKUpdateDevice.h
//  iHealthDemoCode
//
//  Created by daiqingquan on 16/7/27.
//  Copyright © 2016年 zhiwei jing. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 UpdateDeviceError
 */
typedef NS_ENUM(NSUInteger, UpdateDeviceError) {
    /// UpdateNetworkError
    UpdateNetworkError=200,
    /// Before starting the upgrade must go to query version first
    UpdateOrderError=201,
    /// UpdateDeviceDisconnect
    UpdateDeviceDisconnect = 300,
    /// UpdateDeviceEnd
    UpdateDeviceEnd = 301,
    /// UpdateInputError
    UpdateInputError=302,
    /// cannot update
    NOUpdateUpgrade=400,
};

/**
 UpdateModelStatus
 */
typedef NS_ENUM(NSUInteger, UpdateModelStatus) {
    /// not busy
    UpdateModelStatusFree = 1,
    /// busy
    UpdateModelStatusBusy
};

/**
 UpdateDeviceType
 */
typedef NS_ENUM(NSUInteger, UpdateDeviceType) {
    /// AM3
    UpdateDeviceType_AM3 = 1,
    /// AM3S
    UpdateDeviceType_AM3S,
    /// AM4
    UpdateDeviceType_AM4,
    /// PO3
    UpdateDeviceType_PO3,
    /// HS4
    UpdateDeviceType_HS4,
    /// BP5S
    UpdateDeviceType_BP5S,
    /// ECG
    UpdateDeviceType_ECG,
    /// ABPM
    UpdateDeviceType_ABPM,
    /// HS2
    UpdateDeviceType_HS2,
};


/**
 DisposeUpdateVersionResult

 @param updateVersionDic information dictionary
 */
typedef void (^DisposeUpdateVersionResult)(NSDictionary * updateVersionDic);

/**
 DisposeUpdateErrorBlock

 @param errorID UpdateDeviceError enum
 */
typedef void (^DisposeUpdateErrorBlock)(UpdateDeviceError errorID);

/**
 UpdateModuleState

 @param updateModuleState UpdateModelStatus enum
 */
typedef void (^UpdateModuleState)(NSNumber*updateModuleState);

/**
 DisposeEndUpdateResult

 @param endUpdate <#endUpdate description#>
 */
typedef void (^DisposeEndUpdateResult)(NSNumber* endUpdate);

/**
 DisposeDownloadFirmwareStart
 */
typedef void (^DisposeDownloadFirmwareStart)(void);

/**
 DisposeDownloadFirmwareFinish
 */
typedef void (^DisposeDownloadFirmwareFinish)(void);

/**
 DisposeUpdateProgress

 @param progress 0-100
 */
typedef void (^DisposeUpdateProgress)(NSNumber *progress);

/**
 DisposeUpdateResult

 @param updateResult <#updateResult description#>
 */
typedef void (^DisposeUpdateResult)(NSNumber*updateResult);

/**
 TransferSuccess

 @param transferSuccess <#transferSuccess description#>
 */
typedef void (^TransferSuccess)(NSNumber*transferSuccess);

/**
 DisposeDownloadProgress

 @param progress 0-100
 */
typedef void (^DisposeDownloadProgress)(NSNumber *progress);


/**
 SDKUpdateDevice
 */
@interface SDKUpdateDevice : NSObject
    
@property(nonatomic,strong)NSString *currentDeviceUUID;
    
/**
 * Initialize SDKUpdateDevice controller class
 */
+(SDKUpdateDevice*)shareSDKUpdateDeviceInstance;

/**
 Get device Version and cloudDeviceVersion.

 @param uuidString device UUID
 @param updateVersionDic include:DeviceType、DeviceVersion、DeviceStatus(1：YES，0：NO)、CloudDeviceVersion、KeepUpdateFlag（flag，0：firstUpdate，1：go on update）、CloudUpdateServer（1:enforce update 0: optional update）、UpdateProtocolVersion(100:Equipment upgrades returned directly after the success or failure 101:Upgrade is complete only on behalf of the firmware successfully transferred, reconnect the device after the upgrade success or failure).
 @param disposeErrorBlock Update error codes, see UpdateDeviceError error descriptions.
 @note DeviceVerion means firmware version in Flash, may not match with the current running firmware version.
 */
-(void)commandGetUpdateVersionWithDeviceUUID:(NSString*)uuidString DisposeUpdateVersionResult:(DisposeUpdateVersionResult)updateVersionDic  DisposeErrorBlock:(DisposeUpdateErrorBlock)disposeErrorBlock;
/**
 * Get Update Module State.
 * @param updateModuleState  (0:free,1:uploading)
 */
-(void)commandGetUpdateModuleState:(UpdateModuleState)updateModuleState;
/**
 Stop Update.
 @param uuidString device UUID
 @param endUpdateResult （bool 1：sucess，0：fail）
 @param disposeErrorBlock Update error codes, see UpdateDeviceError error descriptions.
 */
-(void)commandEndUpdateWithDeviceUUID:(NSString*)uuidString DisposeEndUpdateResult:(DisposeEndUpdateResult)endUpdateResult  DisposeErrorBlock:(DisposeUpdateErrorBlock)disposeErrorBlock;

/**
 Update Device.
 @param uuidString device UUID
 @param disposeDownloadFirmwareStart  start update firmware from cloud.
 @param disposeDownloadFirmwareFinish finish update firmware from cloud.
 @param disposeUpdateProgress   Update Device progress（0-100）.
 @param disposeUpdateResult  Update Device result（bool 1：sucess，0：fail）Applicable to the protocol of 100.
 @param transferSuccess  TransferSuccess Applicable to the protocol of 101.
 @param disposeErrorBlock Update error codes, see UpdateDeviceError error descriptions.
 */

-(void)commandStartUpdateWithDeviceUUID:(NSString*)uuidString DownloadFirmwareStart:(DisposeDownloadFirmwareStart)disposeDownloadFirmwareStart DisposeDownloadFirmwareFinish:(DisposeDownloadFirmwareFinish)disposeDownloadFirmwareFinish DisposeUpdateProgress:(DisposeUpdateProgress)disposeUpdateProgress DisposeUpdateResult:(DisposeUpdateResult)disposeUpdateResult TransferSuccess:(TransferSuccess)transferSuccess  DisposeErrorBlock:(DisposeUpdateErrorBlock)disposeErrorBlock;

/**
 Update Device with local file

 @param uuidString device UUID
 @param deviceType UpdateDeviceType enum
 @param infoFilePath path of info file
 @param upadteFilePath path of update file
 @param fileCRC info file CRC
 @param disposeUpdateProgress Update Device progress（0-100）
 @param disposeUpdateResult Update Device result（bool 1：sucess，0：fail）Applicable to the protocol of 100.
 @param transferSuccess TransferSuccess Applicable to the protocol of 101.
 @param disposeErrorBlock Update error codes, see UpdateDeviceError error descriptions.
 */
-(void)commandStartUpdateWithDeviceUUID:(NSString*)uuidString DeviceType:(UpdateDeviceType)deviceType InfoFilePath:(NSString*)infoFilePath UpadteFilePath:(NSString*)upadteFilePath FileCRC:(NSNumber*)fileCRC DisposeUpdateProgress:(DisposeUpdateProgress)disposeUpdateProgress DisposeUpdateResult:(DisposeUpdateResult)disposeUpdateResult TransferSuccess:(TransferSuccess)transferSuccess  DisposeErrorBlock:(DisposeUpdateErrorBlock)disposeErrorBlock;

/**
 Update Device showing download progress

 @param uuidString device UUID
 @param disposeDownloadFirmwareStart start update firmware from cloud
 @param disposeDownloadFirmwareFinish finish update firmware from cloud
 @param disposeDownloadProgress Update Device progress（0-100）
 @param disposeUpdateProgress Download file progress（0-100）
 @param disposeUpdateResult Update Device result（bool 1：sucess，0：fail）Applicable to the protocol of 100.
 @param transferSuccess TransferSuccess Applicable to the protocol of 101.
 @param disposeErrorBlock Update error codes, see UpdateDeviceError error descriptions.
 */
-(void)commandStartUpdateWithDeviceUUID:(NSString*)uuidString DownloadFirmwareStart:(DisposeDownloadFirmwareStart)disposeDownloadFirmwareStart DisposeDownloadFirmwareFinish:(DisposeDownloadFirmwareFinish)disposeDownloadFirmwareFinish DisposeDownloadProgress:(DisposeDownloadProgress)disposeDownloadProgress DisposeUpdateProgress:(DisposeUpdateProgress)disposeUpdateProgress DisposeUpdateResult:(DisposeUpdateResult)disposeUpdateResult TransferSuccess:(TransferSuccess)transferSuccess  DisposeErrorBlock:(DisposeUpdateErrorBlock)disposeErrorBlock;


/**
 Update Device showing download progress

 @param uuidString device UUID
 @param disposeDownloadFirmwareStart start update firmware from cloud
 @param disposeDownloadFirmwareFinish finish update firmware from cloud
 @param disposeDownloadProgress Update Device progress（0-100）
 @param disposeErrorBlock Update error codes, see UpdateDeviceError error descriptions.
 */
-(void)commandStartDownloadWithDeviceUUID:(NSString*)uuidString DownloadFirmwareStart:(DisposeDownloadFirmwareStart)disposeDownloadFirmwareStart DisposeDownloadFirmwareFinish:(DisposeDownloadFirmwareFinish)disposeDownloadFirmwareFinish DisposeDownloadProgress:(DisposeDownloadProgress)disposeDownloadProgress  DisposeErrorBlock:(DisposeUpdateErrorBlock)disposeErrorBlock;


/**
 Update Device  （You must download the firmware before calling this interface）

 @param uuidString device UUID

 @param disposeUpdateProgress Download file progress（0-100）
 @param disposeUpdateResult Update Device result（bool 1：sucess，0：fail）Applicable to the protocol of 100.
 @param transferSuccess TransferSuccess Applicable to the protocol of 101.
 @param disposeErrorBlock Update error codes, see UpdateDeviceError error descriptions.
 */
-(void)commandStartUpdateWithDeviceUUID:(NSString*)uuidString  DisposeUpdateProgress:(DisposeUpdateProgress)disposeUpdateProgress DisposeUpdateResult:(DisposeUpdateResult)disposeUpdateResult TransferSuccess:(TransferSuccess)transferSuccess  DisposeErrorBlock:(DisposeUpdateErrorBlock)disposeErrorBlock;


-(void)commandsetCloudModel:(NSNumber*)cloudModel;

@end
