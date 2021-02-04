//
//  ManageDeviceController.h
//  iHealthDemoCode
//
//  Created by daiqingquan on 16/7/3.
//  Copyright © 2016年 zhiwei jing. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 ManageDeviceController
 */
@interface ManageDeviceController : NSObject

+(ManageDeviceController *)commandGetInstance;

/**
 * Get All  Connect iHealth device
 */

- (NSArray *)commandGetAllConnectDeviceArray;

/**
 * Dicconnect iHealth device with bluretooth low energy
 * @param uuidString   iHealth device currentUUID, you can get it from device property.
 */

-(void)commandDisconnectSelectDevice:(NSString *)uuidString;

-(void)commandConnectReadDeviceIDPS:(NSString *)uuidString;


@end
