//
//  PO3.h
//  testShareCommunication
//
//  Created by daiqingquan on 13-11-29.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "POMacroFile.h"


/**
 PO3
 */
@interface PO3 : NSObject

@property (strong, nonatomic) NSString *currentUUID;
@property (strong, nonatomic) NSString *serialNumber;
@property (strong, nonatomic) NSString *firmwareVersion;



/**
 * Restore Sync time
 * @param syncTimeBlock Sync completed. Yes = Success, No = Fail.
 * @param errorBlock Communication error codes
 */
-(void)commandPO3SyncTime:(DisposePO3SyncTimeBlock)syncTimeBlock withErrorBlock:(DisposePO3ErrorBlock)errorBlock;




/**
 * Restore Real-time measurements
 * @param startMeasure  Start measurement, Return no for fail, return yes for success.
 * @param measureData  SpO2 values, including SpO2, pulse rate, pulse intensity. Corresponding keys are spo2, bpm, wave, and pi.
 * @param finishMeasure  Finish measurement. No for fail, yes for success.
 * @param errorBlock Communication error codes
 */

-(void)commandPO3StartMeasure:(DisposePO3StartMeasure)startMeasure withMeasureData:(DisposePO3MeasureData)measureData  withFinishMeasure:(DisposePO3FinishMeasure)finishMeasure  withErrorBlock:(DisposePO3ErrorBlock)errorBlock;




/**
 * Restore Historical data
 * @param offlineDataCount Number of historical offline data measurements.
 * @param offlineData date, spo2, bpm, and wave.
 * @param offlineWaveData Pulse intensity, corresponding key: wave
 * @param finishUpload End transmission of data, yes for success, no for fail.
 * @param errorBlock Communication error codes
 */
-(void)commandPO3OfflineDataCount:(DisposePO3OfflineDataCount)offlineDataCount withOfflineData:(DisposePO3OfflineData)offlineData withOfflineWaveData:(DisposePO3OfflineWaveData)offlineWaveData withFinishMeasure:(DisposePO3FinishUpload)finishUpload  withErrorBlock:(DisposePO3ErrorBlock)errorBlock;




/**
 * Query power status
 * @param batteryBlock Battery，from 0～100
 * @param errorBlock Communication error codes
 */
-(void)commandPO3GetDeviceBattery:(DisposePO3BatteryBlock)batteryBlock withErrorBlock:(DisposePO3ErrorBlock)errorBlock;



/**
 * Disconnect connection
 * @param disconnectBlock  yes = success, no = fail.
 * @param errorBlock Communication error codes
 */
-(void)commandPO3Disconnect:(DisposePO3DisconnectBlock)disconnectBlock withErrorBlock:(DisposePO3ErrorBlock)errorBlock;
@end


