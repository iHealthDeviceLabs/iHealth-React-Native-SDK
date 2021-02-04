//
//  ConnectDeviceController.h
//  iHealthDemoCode
//
//  Created by zhiwei jing on 1/24/16.
//  Copyright © 2016 zhiwei jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HealthHeader.h"

/**
 ConnectDeviceController
 */
@interface ConnectDeviceController : NSObject

+(ConnectDeviceController *)commandGetInstance;


/**
 * Connect iHealth device with bluretooth low energy
 * @param tempDeviceType  iHealth DeviceType
 * @param tempSerialNub   iHealth device serialNub or deviceID, you can get it from [ScanDeviceController commandScanDeviceType]. 
 */
-(int)commandContectDeviceWithDeviceType:(HealthDeviceType)tempDeviceType  andSerialNub:(NSString *)tempSerialNub;

@end
