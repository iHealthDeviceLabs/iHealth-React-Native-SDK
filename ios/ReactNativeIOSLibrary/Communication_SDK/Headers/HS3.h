//
//  HS3.h
//  testShareCommunication
//
//  Created by daiqingquan on 13-10-10.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSMacroFile.h"


/**
 HS3
 */
@interface HS3 : NSObject
@property (retain, nonatomic) NSString *currentUUID;
@property (retain, nonatomic) NSString *deviceID;
@property (retain, nonatomic) NSString *modelNumber;
@property (retain, nonatomic) NSDictionary *commInfoDic;
@property (retain, nonatomic) NSString *firmwareVersion;



-(void)commandInitMeasureWeightID:(WeightID)weightID FinishInit:(FinishHS3Init)finishInit DisposeErrorBlock:(DisposeHS3ErrorBlock)disposeHS3ErrorBlock;


/**
 Establish memory and measurement connection
 The measurement via SDK will be operated in the case of 1-4, and will be terminated if any of 5-8 occurs. The interface needs to be re-called after analyzing the return parameters.
 
 @param startTransmission Start Memory transmission，Success: Yes，Fail: No.
 @param hs3UploadDataNum MemoryNumber，Range:0～200.
 @param progress Memory transmission progress，Range:0.0～1.0.
 @param memorryData Record data including weight(kg)[Range:0.0~150.0], measure time，coordinated key：weight、date.
 @param finishTransmission Finish memory transmission.
 @param stableWeight weight (Kg) [value range:0.0~150.0]
 @param disposeHS3ErrorBlock  Error code in measurement process
 */
-(void)commandInitWithUser:(StartHS3Transmission)startTransmission UploadDataNum:(DisposeHS3UploadDataNum)hs3UploadDataNum DisposeProgress:(DisposeHS3Progress)progress MemorryData:(HS3MemorryData)memorryData FinishTransmission:(FinishHS3Transmission)finishTransmission StableWeight:(StableHS3Weight)stableWeight DisposeErrorBlock:(DisposeHS3ErrorBlock)disposeHS3ErrorBlock;

/**
  Turn off Bluetooth Connection
  This method can be called only for hsInstance.HS3 with FirmwareVersion>=1.0.2
  Return parameters:
  @param disposeResult — ‘YES’ means measurement has been terminated, ‘NO’ means termination failed.
  @param disposeHS3ErrorBlock  - refer to “error” : HS3 error instruction.
*/
-(void)commandTurnOffBTConnectAutoResult:(DisposeResult)disposeResult DisposeErrorBlock:(DisposeHS3ErrorBlock)disposeHS3ErrorBlock;



/**
 Turn on Bluetooth Connection
 This method can be called only for hsInstance.HS3 with FirmwareVersion>=1.0.2
 Return parameters:
 @param disposeResult ‘YES’ means measurement has been terminated, ‘NO’ means termination failed.
 @param disposeHS3ErrorBlock   refer to “error” : HS3 error instruction.

 */
-(void)commandTurnOnBTConnectAutoResult:(DisposeResult)disposeResult DisposeErrorBlock:(DisposeHS3ErrorBlock)disposeHS3ErrorBlock;

@end
