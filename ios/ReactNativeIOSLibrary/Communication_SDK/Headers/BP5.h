//
//  BP5.h
//  testShareCommunication
//
//  Created by my on 14/10/13.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import "BP7.h"


/**
 BP5 device class
 */
@interface BP5 : BP7

/**
 * Establish measurement connection and start BP measurement（Only for BP5）.
 * @param blockZeroState Zeroing state
 * @param pressure  Pressure value in the process of measurement, the unit is ‘mmHg’.
 * @param blockWaveletWithHeartbeat   Wavelet data set with heart beat.
 * @param blockWaveletWithoutHeartbeat   Wavelet data set without heart beat.
 * @param result   result of the measurement, including systolic pressure, diastolic pressure, pulse rate and irregular judgment. Relevant key: time, sys, dia, heartRate, irregular. irregular will be 0 or 1.
 * @param error   Return error codes.
 */

-(void)commandStartMeasureWithZeroingState:(BlockZero)blockZeroState pressure:(BlockPressure)pressure waveletWithHeartbeat:(BlockWavelet)blockWaveletWithHeartbeat waveletWithoutHeartbeat:(BlockWavelet)blockWaveletWithoutHeartbeat result:(BlockMeasureResult)result errorBlock:(BlockError)error;




@end
