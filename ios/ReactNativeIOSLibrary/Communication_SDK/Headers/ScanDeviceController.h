//
//  ScanDeviceController.h
//  iHealthDemoCode
//
//  Created by zhiwei jing on 1/24/16.
//  Copyright © 2016 zhiwei jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HealthHeader.h"

/**
 ScanDeviceController
 */
@interface ScanDeviceController : NSObject

+(ScanDeviceController *)commandGetInstance;

/**
 Start scan iHealth device with bluetooth low energy (scan maintains 12s, then auto stop scan)

 @param tempDeviceType HealthDeviceType enum
 @note Before call the Api, should register discover Notification. such as :[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(devicePO3Discover:) name:PO3Discover object:nil];
 You will get two type result:
 {
 DeviceName = PO3;
 ID = 60EC1538-46B7-3830-DDE2-0642AC9649F3;
 }
 or
 {
 DeviceName = PO3;
 SerialNumber = 883314776729;
 }
 Then call [ConnectDeviceController :commandContectDeviceWithDeviceType:andSerialNub] to connect.
 Attentation: Stop scan befroe connect device, otherwise connect may fail.
 @return 0
 */
-(int)commandScanDeviceType:(HealthDeviceType)tempDeviceType;


/**
 * Stop scan iHealth device with bluretooth low energy
 * @param tempDeviceType  iHealth DeviceType
 */
-(int)commandStopScanDeviceType:(HealthDeviceType)tempDeviceType;

@end
