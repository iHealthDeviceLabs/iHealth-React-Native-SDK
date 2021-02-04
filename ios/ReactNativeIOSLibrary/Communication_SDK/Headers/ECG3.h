//
//  ECG3.h
//  iHealthDemoCode
//
//  Created by zhiwei jing on 16/7/12.
//  Copyright © 2016年 zhiwei jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECGMacroFile.h"

/**
 Sync Time Successfully
 */
typedef void (^DisposeECG3SyncTimeSuccessBlock)(void);

/**
 Error block

 @param errorId see ECG3ErrorID enum
 */
typedef void(^DisposeECG3ErrorBlock)(ECG3ErrorID errorId);
/**
 Start Measure
 */
typedef void (^DisposeECG3StartMeasureBlock)(void);
/**
 Finish Measure
 */
typedef void (^DisposeECG3FinishMeasureSuccessBlock)(void);

 /**
 ECG3 Wave Data
 */
typedef void (^DisposeECG3WaveDataBlock)(NSArray* waveDataArray);

/**
 ECG3 HR Data
 */
typedef void (^DisposeECG3PluseResultBlock)(BOOL hasHR,NSUInteger HR);
/**
 get Battery
 */
typedef void (^DisposeECG3GetBatteryBlock)(NSNumber *battery);
/**
 ECG3
 */
@interface ECG3 : NSObject

@property (strong, nonatomic) NSString *currentUUID;
@property (strong, nonatomic) NSString *serialNumber;
@property (strong, nonatomic) NSString *firmwareVersion;

/**
 * Sync time
 * @param syncTimeBlock Sync time successfully
 * @param errorBlock Communication error codes, see ECG3 error descriptions.
 */
-(void)commandECG3SyncTime:(DisposeECG3SyncTimeSuccessBlock)syncTimeBlock withErrorBlock:(DisposeECG3ErrorBlock)errorBlock;


/**
 * Start Measure
 * @param startMeasureBlock True: Success， False: Failed.
 * @param waveDataBlock waveData：ECGWaveData use for draw wave
 * @param pluseResultBlock hasHR: whether have heart; HR: heart rate (unit: bpm) only valid when isHaveHeart is true
 * @param errorBlock Communication error codes, see ECG3 error descriptions.
 */
-(void)commandECG3StartMeasure:(DisposeECG3StartMeasureBlock)startMeasureBlock withWaveData:(DisposeECG3WaveDataBlock)waveDataBlock withPulseResult:(DisposeECG3PluseResultBlock)pluseResultBlock withErrorBlock:(DisposeECG3ErrorBlock)errorBlock;



/**
 * Finish Measure
 * @param finishMeasureBlock finish successfully
 * @param errorBlock Communication error codes, see ECG3 error descriptions.
 */
-(void)commandECG3FinishMeasure:(DisposeECG3FinishMeasureSuccessBlock)finishMeasureBlock withErrorBlock:(DisposeECG3ErrorBlock)errorBlock;




/**
 * Get Battery
 * @param batteryBlock from 0～100.
 * @param errorBlock Communication error codes, see ECG3 error descriptions.
 */
-(void)commandECG3GetBatteryInfo:(DisposeECG3GetBatteryBlock)batteryBlock withErrorBlock:(DisposeECG3ErrorBlock)errorBlock;

/**
 Disconnect device
 */
- (void)disconnectDevice;
@end
