//
//  ABI.h
//  iHealthDemoCode
//
//  Created by zhiwei jing on 14-11-18.
//  Copyright (c) 2014年 zhiwei jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPMacroFile.h"

/**
 ABI device class
 */
@interface ABI : NSObject

@property (assign, nonatomic) BOOL hasLegMonitor;
@property (strong, nonatomic) NSString *currentArmUUID;
@property (strong, nonatomic) NSString *currentLegUUID;
//‘serialNumber’ is for separating different device when multiple device have been connected.
@property (strong, nonatomic) NSString *armSerialNumber;
@property (strong, nonatomic) NSString *legSerialNumber;

/**
 * Query battery remaining energy
 * @param armEnergy  A block to return battery ratio of upper-arm BPM, 80 means 80%.
 * @param legEnergy  A block to return battery ratio of ankle BPM, 80 means 80%.
 * @param error  When error occur, this block will be callback.
 */
-(void)commandQueryEnergy:(BlockEnergyValue)armEnergy leg:(BlockEnergyValue)legEnergy errorBlock:(BlockError)error;


/**
 * Establish measurement connection and start BP measurement
 * @Notice   By the first time of new user register via SDK, ‘iHealth disclaimer’ will pop up automatically, and require the user agrees to continue. SDK application requires Internet connection; there is 10-day tryout if SDK cannot connect Internet, SDK is fully functional during tryout period, but will be terminated without verification through Internet after 10 days.
 * @param blockZeroState Zeroing state
 * @param armPressure  Return Upper-arm blood pressure value during measurement, unit as mmHg
 * @param legPressure  Return Ankle blood pressure value during measurement, unit as mmHg.
 * @param blockArmWaveletWithHeartbeat  Return Wavelet value of upper-arm BPM, with heartbeats.
 * @param blockLegWaveletWithHeartbeat  Return Wavelet value of ankle BPM, with heartbeats.
 * @param blockArmWaveletWithoutHeartbeat  Return Wavelet value of upper-arm BPM, without heartbeats.
 * @param blockLegWaveletWithoutHeartbeat  Return Wavelet value of ankle BPM, without heartbeats.
 * @param armResult   Return BP value of upper-arm BPM, including time, sys, dia, heartRate, irregular heartbeat.
 * @param legResult  Return BP value of ankle BPM, including time, sys, dia, heartRate, irregular heartbeat.
 * @param error  When error occur, this block will be callback.
 */
-(void)commandStartMeasureWithZeroingState:(BlockZero)blockZeroState armPressure:(BlockPressure)armPressure legPressure:(BlockPressure)legPressure armWaveletWithHeartbeat:(BlockWavelet)blockArmWaveletWithHeartbeat legWaveletWithHeartbeat:(BlockWavelet)blockLegWaveletWithHeartbeat armWaveletWithoutHeartbeat:(BlockWavelet)blockArmWaveletWithoutHeartbeat legWaveletWithoutHeartbeat:(BlockWavelet)blockLegWaveletWithoutHeartbeat  armResult:(BlockMeasureResult)armResult legResult:(BlockMeasureResult)legResult errorBlock:(BlockError)error;


/**
 * Measurement termination and stop ABI measurement
 */
-(void)stopABIMeassure;



#pragma mark - Arm Measure Api
/**
 * Query battery remaining energy
 * @param armEnergy  A block to return battery ratio of upper-arm BPM, 80 means 80%.
 * @param error  When error occur, this block will be callback.
 */
-(void)commandQueryEnergy:(BlockEnergyValue)armEnergy errorBlock:(BlockError)error;


/**
 * Establish measurement connection and Start upper-arm BPM measurement.
 * @param blockZeroState Zeroing state
 * @param armPressure  Return Upper-arm blood pressure value during measurement, unit as mmHg.
 * @param blockArmWaveletWithHeartbeat  The Wavelet value of upper-arm BPM, with heartbeats.
 * @param blockArmWaveletWithoutHeartbeat  The Wavelet value of upper-arm BPM, without heartbeats.
 * @param armResult  The BP value of upper-arm BPM, including time, sys, dia, heartRate, irregular heartbeat. irregular will be 0 or 1.
 * @param error  When error occur, this block will be callback.
 */
-(void)commandStartArmMeasureWithZeroingState:(BlockZero)blockZeroState armPressure:(BlockPressure)armPressure armWaveletWithHeartbeat:(BlockWavelet)blockArmWaveletWithHeartbeat armWaveletWithoutHeartbeat:(BlockWavelet)blockArmWaveletWithoutHeartbeat armResult:(BlockMeasureResult)armResult errorBlock:(BlockError)error;

/**
 * Measurement termination and stop upper-arm BPM measurement
 */
-(void)stopABIArmMeassure;

@end
