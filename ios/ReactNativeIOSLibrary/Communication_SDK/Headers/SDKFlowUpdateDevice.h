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
typedef NS_ENUM(NSUInteger, UpdateFlowDeviceError) {
    /// UpdateNetworkError
    UpdateFlowNetworkError=200,
    /// Before starting the upgrade must go to query version first
    UpdateFlowOrderError=201,
    /// UpdateDeviceDisconnect
    UpdateFlowDeviceDisconnect = 300,
    /// UpdateDeviceEnd
    UpdateFlowDeviceEnd = 301,
    /// UpdateInputError
    UpdateFlowInputError=302,
    /// UpdateErrorUnKnow
    UpdateFlowErrorUnKnow=303,
    /// UpdateErrorLowPower
    UpdateFlowErrorLowPower=304,
    /// UpdateErrorMeasuring
    UpdateFlowErrorMeasuring=305,
    /// cannot update
    UpdateFlowNOUpdateUpgrade=400,
};

/**
 UpdateModelStatus
 */
typedef NS_ENUM(NSUInteger, UpdateFlowModelStatus) {
    /// not busy
    UpdateFlowModelStatusFree = 1,
    /// busy
    UpdateFlowModelStatusBusy
};

/**
 UpdateDeviceType
 */
typedef NS_ENUM(NSUInteger, UpdateFlowDeviceType) {
    /// HS2S
    UpdateFlowDeviceType_HS2S,
    /// BG1S
    UpdateFlowDeviceType_BG1S,
    /// PT3SBT
    UpdateFlowDeviceType_PT3SBT,
    /// BG5S
    UpdateFlowDeviceType_BG5S,
};


/**
 DisposeUpdateVersionResult

 @param updateVersionDic information dictionary
 */
typedef void (^DisposeUpdateFlowVersionResult)(NSDictionary * updateVersionDic);

/**
 DisposeUpdateErrorBlock

 @param errorID UpdateDeviceError enum
 */
typedef void (^DisposeUpdateFlowErrorBlock)(UpdateFlowDeviceError errorID);

/**
 UpdateModuleState

 @param updateModuleState UpdateModelStatus enum
 */
typedef void (^UpdateFlowModuleState)(NSNumber*updateModuleState);

/**
 DisposeEndUpdateResult

 @param endUpdate <#endUpdate description#>
 */
typedef void (^DisposeEndUpdateFlowResult)(NSNumber* endUpdate);

/**
 DisposeDownloadFirmwareStart
 */
typedef void (^DisposeFlowDownloadFirmwareStart)(void);

/**
 DisposeDownloadFirmwareFinish
 */
typedef void (^DisposeFlowDownloadFirmwareFinish)(void);

/**
 DisposeUpdateProgress

 @param progress 0-100
 */
typedef void (^DisposeUpdateFlowProgress)(NSNumber *progress);

/**
 DisposeUpdateResult

 @param updateResult <#updateResult description#>
 */
typedef void (^DisposeUpdateFlowResult)(NSNumber*updateResult);

/**
 TransferSuccess

 @param transferSuccess <#transferSuccess description#>
 */
typedef void (^TransferFlowSuccess)(NSNumber*transferSuccess);

/**
 DisposeDownloadProgress

 @param progress 0-100
 */
typedef void (^DisposeFlowDownloadProgress)(NSNumber *progress);


/**
 SDKUpdateDevice
 */
@interface SDKFlowUpdateDevice : NSObject
    
@property(nonatomic,strong)NSString *currentDeviceUUID;
    
/**
 * Initialize SDKFlowUpdateDevice controller class
 */
+(SDKFlowUpdateDevice*)shareSDKUpdateDeviceInstance;

/**
 Get device Version and cloudDeviceVersion.

 @param uuidString device UUID
 @param deviceType UpdateFlowDeviceType enum
 @param updateVersionDic include:DeviceType、DeviceVersion、DeviceStatus(1：YES，0：NO)、CloudDeviceVersion、KeepUpdateFlag（flag，0：firstUpdate，1：go on update）、CloudUpdateServer（1:enforce update 0: optional update）.
 @param disposeErrorBlock Update error codes, see UpdateDeviceError error descriptions.
 @note DeviceVerion means firmware version in Flash, may not match with the current running firmware version.
 */
-(void)commandGetUpdateVersionWithDeviceUUID:(NSString*)uuidString DeviceType:(UpdateFlowDeviceType)deviceType DisposeUpdateVersionResult:(DisposeUpdateFlowVersionResult)updateVersionDic  DisposeErrorBlock:(DisposeUpdateFlowErrorBlock)disposeErrorBlock;
/**
 * Get Update Module State.
 * @param updateModuleState  (0:free,1:uploading)
 */
-(void)commandGetUpdateModuleState:(UpdateFlowModuleState)updateModuleState;
/**
 Stop Update.
 @param uuidString device UUID
 @param deviceType UpdateFlowDeviceType enum
 @param endUpdateResult （bool 1：sucess，0：fail）
 @param disposeErrorBlock Update error codes, see UpdateDeviceError error descriptions.
 */
-(void)commandEndUpdateWithDeviceUUID:(NSString*)uuidString DeviceType:(UpdateFlowDeviceType)deviceType DisposeEndUpdateResult:(DisposeEndUpdateFlowResult)endUpdateResult  DisposeErrorBlock:(DisposeUpdateFlowErrorBlock)disposeErrorBlock;

/**
 Update Device with local file

 @param uuidString device UUID
 @param deviceType UpdateFlowDeviceType enum
 @param infoFilePath path of info file
 @param upadteFilePath path of update file
 @param disposeUpdateProgress Update Device progress（0-100）
 @param disposeUpdateResult Update Device result（bool 1：sucess，0：fail）Applicable to the protocol of 100.
 @param transferSuccess TransferSuccess
 @param disposeErrorBlock Update error codes, see UpdateDeviceError error descriptions.
 */
-(void)commandStartUpdateWithDeviceUUID:(NSString*)uuidString DeviceType:(UpdateFlowDeviceType)deviceType InfoFilePath:(NSString*)infoFilePath UpadteFilePath:(NSString*)upadteFilePath DisposeUpdateProgress:(DisposeUpdateFlowProgress)disposeUpdateProgress DisposeUpdateResult:(DisposeUpdateFlowResult)disposeUpdateResult TransferSuccess:(TransferFlowSuccess)transferSuccess  DisposeErrorBlock:(DisposeUpdateFlowErrorBlock)disposeErrorBlock;

/**
 Update Device showing download progress

 @param uuidString device UUID
 @param deviceType UpdateFlowDeviceType enum
 @param disposeDownloadFirmwareStart start update firmware from cloud
 @param disposeDownloadFirmwareFinish finish update firmware from cloud
 @param disposeDownloadProgress Update Device progress（0-100）
 @param disposeUpdateProgress Download file progress（0-100）
 @param disposeUpdateResult Update Device result（bool 1：sucess，0：fail）.
 @param transferSuccess TransferSuccess .
 @param disposeErrorBlock Update error codes, see UpdateDeviceError error descriptions.
 */
-(void)commandStartUpdateWithDeviceUUID:(NSString*)uuidString DeviceType:(UpdateFlowDeviceType)deviceType DownloadFirmwareStart:(DisposeFlowDownloadFirmwareStart)disposeDownloadFirmwareStart DisposeDownloadFirmwareFinish:(DisposeFlowDownloadFirmwareFinish)disposeDownloadFirmwareFinish DisposeDownloadProgress:(DisposeFlowDownloadProgress)disposeDownloadProgress DisposeUpdateProgress:(DisposeUpdateFlowProgress)disposeUpdateProgress DisposeUpdateResult:(DisposeUpdateFlowResult)disposeUpdateResult TransferSuccess:(TransferFlowSuccess)transferSuccess  DisposeErrorBlock:(DisposeUpdateFlowErrorBlock)disposeErrorBlock;



-(void)commandsetCloudModel:(NSNumber*)cloudModel;

@end
