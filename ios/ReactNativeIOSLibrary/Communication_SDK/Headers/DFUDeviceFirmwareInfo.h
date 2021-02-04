//
//  DFUDeviceFirmwareInfo.h
//  iHealthSDKStatic
//
//  Created by Lei Bao on 2017/7/17.
//  Copyright © 2017年 daiqingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DFUMacro.h"
/**
 Firmware information from device flash
 */
@interface DFUDeviceFirmwareInfo : NSObject
/**
 Device UUID
 */
@property (copy, nonatomic, readonly) NSString *UUID;
/**
 DFUDeviceType
 */
@property (assign, nonatomic, readonly) DFUDeviceType deviceType;

/**
 Model Number
 */
@property (copy, nonatomic, readonly) NSString *deviceModel;

/**
 Hardware version
 */
@property (copy, nonatomic, readonly) NSString *hardwareVersion;

/**
 Firmware version in Flash
 */
@property (copy, nonatomic, readonly) NSString *firmwareVersion;

/**
 YES：allow；NO：not allow
 */
@property (assign, nonatomic, readonly) BOOL canUpgrade;

/**
 Continue to transfer or not
 */
@property (assign, nonatomic, readonly) BOOL isContinue;

/**
 1:update no need to disconnect 2:update need to disconnect
 */
@property (assign, nonatomic, readonly) NSInteger upgradeMethod;

+ (instancetype)infoWithData:(uint8_t [])buf  deviceType:(DFUDeviceType)deviceType deviceUUID:(NSString *)uuid;

@end
