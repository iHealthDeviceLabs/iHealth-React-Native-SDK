//
//  BG3Controller.h
//  iHealthBG
//
//  Created by daiqingquan on 14-2-20.
//  Copyright (c) 2014年 andon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BG3.h"

/**
 BG3Controller
 */
@interface BG3Controller : NSObject

/**
 *Initialization for BG3 (wireless BG via Bluetooth)
 */
+(BG3Controller *)shareIHBg3Controller;

/**
 * Get all BG3 Instance
 * The methold needs to be called when the BG3 has been triggered. When the app detected the glucose meter, the notification with the name of DeviceAuthenSuccess will be sent. After the device disconnected, the notification with the name of  DeviceAuthenSuccess will be received.
 */
-(BG3 *)getCurrentBG3Instace;

@end
