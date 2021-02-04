//
//  HS2.h
//  iHealthSDKStatic
//
//  Created by ihealth on 2017/6/6.
//  Copyright © 2017年 daiqingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSMacroFile.h"

@interface HS2 : NSObject
@property (strong, nonatomic) NSString *currentUUID;
@property (strong, nonatomic) NSString *deviceID;
@property (strong, nonatomic) NSNumber *daiModel;
@property (retain, nonatomic) NSString *firmwareVersion;

/**
 
 * Establish memory and measurement connection
 
 * Import parameter:
 * @param tempUnit  -Unit displayed on HS2: HSUnit_Kg、HSUnit_LB、HSUnit_ST。
 
 * Return parameters:
 The measurement via SDK will be operated in the case of 1-4, and will be terminated if any of 5-8 occurs. The interface needs to be re-called after analyzing the return parameters.
 
 * @param unStableWeight     - Current weight, (Kg) [Value Range:0~180]
 * @param stableWeight       - Stable weight, (Kg) [Value Range:0~180]
 * @param disposeErrorBlock  - error code
 * Error code definition：
 *  refer to “error” : HS2 error instruction.
 */

-(void)commandHS2MeasureWithUint:(HSUnit)tempUnit Weight:(UnStableWeight)unStableWeight StableWeight:(StableWeight)stableWeight DisposeErrorBlock:(DisposeHS2ErrorBlock)disposeErrorBlock;

/**
 * Upload memory data
 
 * Return parameters:
 * @param  startTransmission -Start Memory transmission.
 * @param  progress         -Memory transmission progress，[Range:0.0～1.0].
 * @param  memorryData      -Record data including weight (kg), measurement time，coordinated key：weight，date.[Range of weight 0~180(kg)] （If it exceeds 180kg, it will display er1 error, but the SDK interface will also return data. More than 180kg of data is not recommended.）
 * @param  finishTransmission -Finish memory transmission.
 * @param  disposeErrorBlock  -Record the error code in uploading process.
 * Error code definition: refer to ”error” : HS2 error instruction.
 */

-(void)commandHS2TransferMemorryData:(StartHS2Transmission)startTransmission DisposeProgress:(DisposeProgress)progress MemorryData:(MemorryData)memorryData FinishTransmission:(FinishHS2Transmission)finishTransmission DisposeErrorBlock:(DisposeHS2ErrorBlock)disposeErrorBlock;

/**
 *Get HS2 Battery

 * @param HS2battery HS2battery [Range:0～100]%
 * @param disposeErrorBlock error code
 */
-(void)commandGetHS2Battery:(DisposeHS2BatteryBlock)HS2battery DiaposeErrorBlock:(DisposeHS2ErrorBlock)disposeErrorBlock;
/**
 Disconnect current device
 */

-(void)commandDisconnectDevice;

@end
