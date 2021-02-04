//
//  BP5C.h
//  iHealthSDKStatic
//
//  Created by Realank on 2017/9/26.
//  Copyright © 2017年 ihealthSDK. All rights reserved.
//

#import "BPBV10Device.h"
@interface BP5C : BPBV10Device<BPBasicBTLEProtocol,BPRealtimeMeasureProtocol,BPOfflineDataTransferProtocol>


/**
 * Synchronize time and return functions this device supports.
 * @param function  A block to return the functions and states that the device supports.
 * @param error  Operation failed, and returns the error codes.
 */
-(void)commandFunction:(BlockDeviceFunction)function errorBlock:(BlockError)error;

/**
 * Get battery remaining energy by percent
 * @param energyValue  A block to return the device battery remaining energy percentage, ‘80’ stands for 80%.
 * @param error  Operation failed, and returns the error codes.
 */
-(void)commandEnergy:(BlockEnergyValue)energyValue errorBlock:(BlockError)error;

/**
 * Set units for the Device
 * @param UnitName   The unit name of the result, must be @"mmHg" or @"kPa".
 * @param setResult  This block return means set success.
 * @param error  Operation failed, and returns the error codes.
 */
-(void)commandSetUnit:(NSString *)UnitName disposeSetReslut:(BlockSuccess)setResult errorBlock:(BlockError)error;


/**
 Set auto loop measure scheme
 
 @param scheme scheme content
 @param successBlock A block refer to success.
 @param errorBlock Operation failed, and returns the error codes.
 */
- (void)commandSetLoopMeasureScheme:(BPLoopMeasureSettingModel*)scheme successBlock:(BlockSuccess)successBlock errorBlock:(BlockError)errorBlock;

/**
 Get auto loop measure scheme
 
 @param loopMeasureSchemeBlock return auto loop measure scheme content
 @param errorBlock Operation failed, and returns the error codes.
 */
- (void)commandAskLoopMeasureScheme:(BlockAskLoopMeasureScheme)loopMeasureSchemeBlock errorBlock:(BlockError)errorBlock;

/**
 * Start BP measurement.
 * @param blockZeroState Zeroing state
 * @param pressure  Pressure value in the process of measurement, the unit is ‘mmHg’.
 * @param blockWaveletWithHeartbeat  Wavelet data set including pulse rate
 * @param blockWaveletWithoutHeartbeat   Wavelet data set without pulse rate
 * @param result   result of the measurement, including systolic pressure, diastolic pressure, pulse rate and irregular judgment. Relevant keys: time, sys, dia, heartRate, irregular. irregular will be 0 or 1.
 * @param error   Operation failed, and returns the error codes.
 */
-(void)commandStartMeasureWithZeroingState:(BlockZero)blockZeroState pressure:(BlockPressure)pressure waveletWithHeartbeat:(BlockWavelet)blockWaveletWithHeartbeat waveletWithoutHeartbeat:(BlockWavelet)blockWaveletWithoutHeartbeat  result:(BlockMeasureResult)result errorBlock:(BlockError)error;

/**
 * Stop measurement
 * @param success  The block return means measurement has been terminated.
 * @param error  Operation failed, and returns the error codes.
 */
-(void)stopBPMeassureSuccessBlock:(BlockSuccess)success errorBlock:(BlockError)error;


/**
 * Upload history data.
 * @param  totalCount history data total Count.
 * @param  progress upload completion ratio , from 0.0 to 1.0.
 * @param  uploadDataArray    offline data set, including measurement time, systolic pressure, diastolic pressure, pulse rate, irregular judgment,scheme ID,body movement flag. corresponding KEYs are time, sys, dia, heartRate, irregular,schemeID,bodyMovementFlg.
 * @param error   Operation failed, and returns the error codes.
 */
-(void)commandTransferMemoryDataWithTotalCount:(BlockBachCount)totalCount progress:(BlockBachProgress)progress dataArray:(BlockBachArray)uploadDataArray errorBlock:(BlockError)error;

-(void)commandTransferMemoryDataAndRawPressureWithTotalCount:(BlockBachCount)totalCount progress:(BlockBachProgress)progress dataArray:(BlockBachArray)uploadDataArray  errorBlock:(BlockError)error;

/**
 * Upload history data total Count.
 * @param  totalCount item quantity of total data.
 * @param error  Operation failed, and returns the error codes.
 */
-(void)commandTransferMemoryTotalCount:(BlockBachCount)totalCount errorBlock:(BlockError)error;


/**
 Delete all the history memory stored in device
 
 @param successBlock A block refer to delete complete.
 @param errorBlock Operation failed, and returns the error codes.
 */
- (void)commandDeleteAllMemoryWithSuccessBlock:(BlockSuccess)successBlock errorBlock:(BlockError)errorBlock;


/**
 Set ID String (eg.patientID, schemeID), length 100 max
 
 @param idString the content of id
 @param successBlock A block refer to success.
 @param errorBlock Operation failed, and returns the error codes.
 */
- (void)commandSetIDString:(NSString*)idString successBlock:(BlockSuccess)successBlock errorBlock:(BlockError)errorBlock;


/**
 Ask ID String
 
 @param idStringResultBlock return ID String
 @param errorBlock Operation failed, and returns the error codes.
 */
- (void)commandAskIDStringWithResult:(BlockAskIDString)idStringResultBlock errorBlock:(BlockError)errorBlock;

/**
 Change loop measure scheme status
 
 @param start YES to start, NO to pause
 @param successBlock A block refer to success.
 @param errorBlock Operation failed, and returns the error codes.
 */
- (void)commandChangeLoopMeasureStatusToStart:(BOOL)start successBlock:(BlockSuccess)successBlock errorBlock:(BlockError)errorBlock;

/**
 * Disconnect current device
 */
-(void)commandDisconnectDevice;
@end
