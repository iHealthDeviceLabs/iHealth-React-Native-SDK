//
//  HS4.h
//  testShareCommunication
//
//  Created by daiqingquan on 13-12-2.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSMacroFile.h"


/**
 HS4
 */
@interface HS4 : NSObject
@property (strong, nonatomic) NSString *currentUUID;
@property (strong, nonatomic) NSString *deviceID;
@property (strong, nonatomic) NSNumber *daiModel;
@property (retain, nonatomic) NSString *firmwareVersion;


/**
 Establish memory and measurement connection
Import parameter:
 @param tempUnit Unit displayed on HS4: HSUnit_Kg、HSUnit_LB、HSUnit_ST。
 Return parameters:
 The measurement via SDK will be operated in the case of 1-4, and will be terminated if any of 5-8 occurs. The interface needs to be re-called after analyzing the return parameters.
 @param unStableWeight Current weight, (Kg) [Value Range:0~180]
 @param stableWeight Stable weight, (Kg) [Value Range:0~180]
 @param disposeErrorBlock  error code
 */
-(void)commandMeasureWithUint:(HSUnit)tempUnit Weight:(UnStableWeight)unStableWeight StableWeight:(StableWeight)stableWeight DisposeErrorBlock:(DisposeHS4ErrorBlock)disposeErrorBlock;



/**
 Upload memory data
 
 Return parameters:
 @param startTransmission Start Memory transmission.
 @param progress Memory transmission progress，[Range:0.0～1.0].
 @param memorryData Record data including weight (kg), measurement time，coordinated key：weight，date.[Range of weight 0.0~180.0(kg)]
 @param finishTransmission Finish memory transmission.
 @param disposeErrorBlock Record the error code in uploading process.
 */
-(void)commandTransferMemorryData:(StartHS4Transmission)startTransmission DisposeProgress:(DisposeProgress)progress MemorryData:(MemorryData)memorryData FinishTransmission:(FinishHS4Transmission)finishTransmission DisposeErrorBlock:(DisposeHS4ErrorBlock)disposeErrorBlock;

/**
  * End Current Measure Connection
  * @param result  - the result of end current action
  * @param disposeErrorBlock  - error code
  * Error code definition ---refer to “error” : HS4 error instruction.
*/

-(void)commandEndCurrentConnection:(DisposeResult)result DisposeErrorBlock:(DisposeHS4ErrorBlock)disposeErrorBlock;

/**
 Disconnect current device
 */

-(void)commandDisconnectDevice;

@end
