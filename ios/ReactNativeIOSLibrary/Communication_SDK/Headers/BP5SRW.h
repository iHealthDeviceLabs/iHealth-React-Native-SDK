//
//  BP5SRW.h
//  testShareCommunication
//
//  Created by my on 14/10/13.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPDevice.h"
#import <UIKit/UIKit.h>


/**
 BP5SRW device class
 */
@interface BP5SRW : BPDevice



/**
 * Establish measurement connection and start BP measurement.
 *  @Notice   By the first time of new user register via SDK, ‘iHealth disclaimer’ will pop up automatically, and require the user agrees to continue. SDK application requires Internet connection; there is 10-day tryout if SDK cannot connect Internet, SDK is fully functional during tryout period, but will be terminated without verification through Internet after 10 days.
 * @param blockZeroState Zeroing state
 * @param pressure  Pressure value in the process of measurement, the unit is ‘mmHg’.
 * @param blockWaveletWithHeartbeat   Wavelet data set with heart beat.
 * @param blockWaveletWithoutHeartbeat   Wavelet data set without heart beat.
 * @param result   result of the measurement, including systolic pressure, diastolic pressure, pulse rate and irregular judgment. Relevant key: time, sys, dia, heartRate, irregular.
 * @param redWave A block to return wave information,include the packets order number(0~255),the current measure status(@1 means measuring，@2 means constant Pressure measuring，@3 means completed),the pressure data type(@1 means pressure data ,@2 means wave data) ,the pressure or wave count ,the pressure or wave data array.The corresponding keys are @"packetOrderID",@"measureStatusID",@"pressureDataType",@"pressureCount",@"pressureArray".
 * @param error   Return error codes.
 * Specification:
 *   1.  BPError0 = 0: Unable to take measurements due to arm/wrist movements.
 *   2.  BPError1:  Failed to detect systolic pressure.
 *   3.  BPError2:  Failed to detect diastolic pressure.
 *   4.  BPError3:  Pneumatic system blocked or cuff is too tight during inflation.
 *   5.  BPError4:  Pneumatic system leakage or cuff is too loose during inflation.
 *   6.  BPError5:  Cuff pressure reached over 300mmHg.
 *   7.  BPError6:  Cuff pressure reached over 15 mmHg for more than 160 seconds.
 *   8.  BPError7:  Data retrieving error.
 *   9.  BPError8:  Data retrieving error.
 *   10.  BPError9:  Data retrieving error.
 *   11.  BPError10:  Data retrieving error.
 *   12.  BPError11:  Communication Error.
 *   13.  BPError12:  Communication Error.
 *   14.  BPError13:  Low battery.
 *   15.  BPError14:  Device bluetooth set failed.
 *   16.  BPError15:  Systolic exceeds 260mmHg or diastolic exceeds 199mmHg.
 *   17.  BPError16:  Systolic below 60mmHg or diastolic below 40mmHg.
 *   18.  BPError17:  Arm/wrist movement beyond range.
 *   19.  BPError18:  Bleed to specified pressure over time
 *   20.  BPError19: Constant pressure acquisition process changes over the specified range of pressure.
 *   21.  BPNormalError=30:  device error, error message displayed automatically.
 *   22.  BPOverTimeError:  Abnormal communication.
 *   23.  BPNoRespondError:  Abnormal communication.
 *   24.  BPBeyondRangeError:  device is out of communication range.
 *   25.  BPDidDisconnect:  device is disconnected.
 *   26.  BPAskToStopMeasure:  measurement has been stopped.
 *   27.  BPInputParameterError=400:  Parameter input error.
 */

-(void)commandStartMeasureWithZeroingState:(BlockZero)blockZeroState pressure:(BlockPressure)pressure waveletWithHeartbeat:(BlockWavelet)blockWaveletWithHeartbeat waveletWithoutHeartbeat:(BlockWavelet)blockWaveletWithoutHeartbeat  result:(BlockMeasureResult)result redWave:(BlockRedWaveDic)redWave errorBlock:(BlockError)error;

/**
 * Measurement termination and stop BP5SRW measurement
 * @param success  The block return means measurement has been terminated.
 * @param error  A block to return the error in ‘Establish measurement connection’ in BP5SRW.
 */
-(void)stopBPMeassureSuccessBlock:(BlockSuccess)success errorBlock:(BlockError)error;

/**
 * Synchronize time and judge if the device supports BT auto-connection, offline detection, and if the function on or off, corresponding KEY as haveBlue, haveOffline, blueOpen, offlineOpen. ‘True’ means yes or on, ‘False’ means no or off
 * @param function  A block to return the function and states that the device supports.
 * @param error  A block to refer ‘error’ in ‘Establish measurement connection’ in BP5SRW.
 */
-(void)commandFunction:(BlockDeviceFunction)function errorBlock:(BlockError)error;

/**
 * Query battery remaining energy
 * @param energyValue  A block to return the device battery remaining energy percentage, ‘80’ stands for 80%.
 * @param error  A block to return the error in ‘Establish measurement connection’.
 */
-(void)commandEnergy:(BlockEnergyValue)energyValue errorBlock:(BlockError)error;


/**
 Set the target measure configure

 @param targetPressure Set the target constant pressure in measuring.
 @param fluctuationPressure Set the allowed range of pressure fluctuations.
 @param sampleTime Set the pressure sample time.
 @param setResult Success callback
 @param error A block to return the error in ‘Establish measurement connection’.
 */
-(void)CommandSetPressureSamplewithTargetPressure:(NSNumber *)targetPressure fluctuationRange:(NSNumber *)fluctuationPressure sampleTime:(NSNumber *)sampleTime disposeSetPresureTargetSuccess:(BlockSuccess)setResult errorBlock:(BlockError)error;

/**
 * Disconnect current device
 */
-(void)commandDisconnectDevice;

@end
