//
//  TS28B.h
//  iHealthSDKStatic
//
//  Created by Lei Bao on 2017/6/13.
//  Copyright © 2017年 daiqingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CBPeripheral;

@interface TS28B : NSObject

@property (strong, nonatomic,readonly) CBPeripheral *peripheral;
@property (copy, nonatomic) NSString *systemID;
@property (copy, nonatomic) NSString *modelNumber;
@property (copy, nonatomic) NSString *serialNumber;
@property (copy, nonatomic) NSString *firmwareVersion;
@property (copy, nonatomic) NSString *hardwareVersion;
@property (copy, nonatomic) NSString *softwareVersion;
@property (copy, nonatomic) NSString *manufacturerName;
@property (copy, nonatomic) NSNumber *batteryValue;

+ (instancetype)modelWithPeripheral:(CBPeripheral *)peripheral;

@end
