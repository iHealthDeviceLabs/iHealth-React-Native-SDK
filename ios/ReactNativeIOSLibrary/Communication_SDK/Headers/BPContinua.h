//
//  BPContinua.h
//  testShareCommunication
//
//  Created by zhiwei jing on 13-10-22.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "BPDevice.h"

 /**
 
  BPContinua device class
 
 */
@interface BPContinua : BPDevice


/**
 * Upload offline data.
 * @param  uploadDataArray	offline data set, including MAP, dataID, dia, heartRate, irregular, measureState, sys, time, unit, userId.
 * @param completeBlock transfer memory complete
 * @param error   error codes.
 * Specification:
 */
-(void)commandTransferMemoryDataWithDataArray:(BlockBachArray)uploadDataArray complete:(BlockSuccess)completeBlock errorBlock:(BlockError)error;


/**
 * Set the userID of memery data that need to upload
 * @param userID  The userID of memery data that want to upload.The userID is @1 or @2.
 * @param setResult  The result of setting userID,'YES'means success.
 * @param error   Error codes.
 */
-(void)commandSetUploadUserID:(NSNumber *)userID setUserIDBlock:(BlockSetUserID)setResult errorBlock:(BlockError)error;

/**
 * Synchronize time
 */
-(void)commandSynchronizeTime;

/**
 *  Get  Battery
 * @param energyValue  0-100
 * @param error   Error codes.
 */
-(void)commandGetBattery:(BlockEnergyValue)energyValue errorBlock:(BlockError)error;

/**
 * Disconnect current device
 */
-(void)commandDisconnectDevice;

@end
