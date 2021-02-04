//
//  BGDevice.h
//  iHealthDemoCode
//
//  Created by Realank on 2017/1/4.
//  Copyright © 2017年 zhiwei jing. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Base class of BG
 */
@interface BGDevice : NSObject

/**
 UUID
 */
@property (copy, nonatomic) NSString *currentUUID;
/**
 serial number or mac
 */
@property (copy, nonatomic) NSString *serialNumber;
/**
 firmware version
 */
@property (copy, nonatomic) NSString *firmwareVersion;
/**
 hardware version
 */
@property (copy, nonatomic) NSString *hardwareVersion;
/**
 model number
 */
@property (copy, nonatomic) NSString *modelNumber;

/**
 device type0:old device  1:new device
 */
@property (copy, nonatomic) NSNumber *deviceType;

@end
