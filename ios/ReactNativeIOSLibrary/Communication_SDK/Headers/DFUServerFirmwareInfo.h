//
//  DFUServerFirmwareInfo.h
//  iHealthSDKStatic
//
//  Created by Lei Bao on 2017/7/17.
//  Copyright © 2017年 daiqingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DFUMacro.h"

/**
 Firmware information from server
 */
@interface DFUServerFirmwareInfo : NSObject

/**
 DFUDeviceType
 */
@property (assign, nonatomic, readonly) DFUDeviceType deviceType;

/**
 The latest firmware version (0.0.0 or 0.0.0.0 means no firmware in server, you should check your query input parameters)
 */
@property (copy, nonatomic, readonly) NSString *latestFirmwareVersion;

/**
 YES means mandtory
 */
@property (assign, nonatomic, readonly) BOOL isMandtoryUpgrade;

/**
 Description
 */
@property (copy, nonatomic, readonly) NSString *updateDescription;

/**
 Images before updating
 */
@property (copy, nonatomic, readonly) NSArray *beforeImages;

/**
 Image after updating
 */
@property (copy, nonatomic, readonly) NSArray *afterImages;

+ (instancetype)infoWithDeviceType:(DFUDeviceType)deviceType dic:(NSDictionary *)dic;
@end
