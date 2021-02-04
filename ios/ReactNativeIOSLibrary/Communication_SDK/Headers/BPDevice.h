//
//  BPDevice.h
//  iHealthDemoCode
//
//  Created by Realank on 2017/1/4.
//  Copyright © 2017年 ihealthSDK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPMacroFile.h"


/**
 a BP protocol related to realtime measure
 */
@protocol BPRealtimeMeasureProtocol <NSObject>

/**
 * Establish measurement connection and start BP measurement.
 * @param blockZeroState Zeroing state
 * @param pressure  Pressure value in the process of measurement, the unit is ‘mmHg’.
 * @param blockWaveletWithHeartbeat  Wavelet data set including pulse rate
 * @param blockWaveletWithoutHeartbeat   Wavelet data set without pulse rate
 * @param result   result of the measurement, including systolic pressure, diastolic pressure, pulse rate and irregular judgment. Relevant key: time, sys, dia, heartRate, irregular. irregular will be 0 or 1.
 * @param error   Return error codes.
 */
-(void)commandStartMeasureWithZeroingState:(BlockZero)blockZeroState pressure:(BlockPressure)pressure waveletWithHeartbeat:(BlockWavelet)blockWaveletWithHeartbeat waveletWithoutHeartbeat:(BlockWavelet)blockWaveletWithoutHeartbeat  result:(BlockMeasureResult)result errorBlock:(BlockError)error;

/**
 * stop measuring state of BP
 * @param success  The block return means measurement has been successfully stoped.
 * @param error  Return error codes.
 */
-(void)stopBPMeassureSuccessBlock:(BlockSuccess)success errorBlock:(BlockError)error;

@end


/**
 a BP protocol related to offline data transfer
 */
@protocol BPOfflineDataTransferProtocol <NSObject>

/**
 *  Upload offline data.
 * @param  totalCount quantity of total history data
 * @param  progress upload completion ratio , from 0.0 to 1.0, 1.0 means upload completed.
 * @param  uploadDataArray	offline data set, may including measurement time, systolic pressure, diastolic pressure, pulse rate, irregular judgment,scheme ID, body movement flag. corresponding KEYs are time, sys, dia, heartRate, irregular,schemeID,bodyMovementFlg.
 * @param error   Return error codes.
 */
-(void)commandTransferMemoryDataWithTotalCount:(BlockBachCount)totalCount progress:(BlockBachProgress)progress dataArray:(BlockBachArray)uploadDataArray errorBlock:(BlockError)error;


/**
 * Upload offline data total Count.
 * @param  totalCount  quantity of total history data.
 * @param error  Return error codes.
 */
-(void)commandTransferMemoryTotalCount:(BlockBachCount)totalCount errorBlock:(BlockError)error;

-(void)commandDeleteDataSuccessBlock:(BlockSuccess)success errorBlock:(BlockError)error;

@end


/**
 a BP protocol related to basic function, such as get function, get energy
 */
@protocol BPBasicProtocol <NSObject>

/**
 * Synchronize time and judge if the device supports BT auto-connection, offline detection, and if the function on or off, corresponding KEY are haveBlue, haveOffline, blueOpen, offlineOpen. ‘True’ means yes or on, ‘False’ means no or off
 * @param function  A block to return the function and states that the device supports.
 * @param error  Return error codes.
 */
-(void)commandFunction:(BlockDeviceFunction)function errorBlock:(BlockError)error;

/**
 * Get battery remaining energy by percent
 * @param energyValue  A block to return the device battery remaining energy percentage, ‘80’ stands for 80%.
 * @param error  Return error codes.
 */
-(void)commandEnergy:(BlockEnergyValue)energyValue errorBlock:(BlockError)error;

@end


/**
 a BP protocol related to basic function and disconnect
 */
@protocol BPBasicBTLEProtocol <BPBasicProtocol>

/**
 * Disconnect current device
 */
-(void)commandDisconnectDevice;

@end


/**
 a BP protocol related to enable offline
 */
@protocol BPEnableOfflineProtocol <BPBasicProtocol>

/**
 * set up offline detection
 * @param open  True means on; False means off.
 * @param successBlock  A block to refer ‘set success’.
 * @param errorBlock  A block to refer ‘set failed’.
 */
-(void)commandSetOffline:(BOOL)open success:(BlockSuccess)successBlock error:(BlockError)errorBlock;

@end


/**
 BP device basic class
 */
@interface BPDevice : NSObject

@property (copy, nonatomic) NSString *currentUUID;
///‘serialNumber’ is for separating different device when multiple device have been connected.
@property (copy, nonatomic) NSString *serialNumber;
@property (copy, nonatomic) NSString *firmwareVersion;
@property (copy, nonatomic) NSString *hardwareVersion;
@property (copy, nonatomic) NSString *deviceName;
@property (copy, nonatomic) NSString *protocolString;
@property (copy, nonatomic) NSString *modelNumber;
@end
