//
//  BG5Controller.h
//  testShareCommunication
//
//  Created by daiqingquan on 14-1-16.
//  Copyright (c) 2014年 my. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BGMacroFile.h"

/**
 BG5Controller
 */
@interface BG5Controller : BGController

/**
 *Initialization for BG5 (wireless BG via Bluetooth)
 */
+(BG5Controller *)shareIHBg5Controller;

/**
 * Get all BG5 Instance
 * The methold needs to be called when the BG5 has been triggered. When the app detected the glucose meter, the notification with the name of BG5ConnectNoti will be sent. After the device disconnected, the notification with the name of  BG5DisConnectNoti will be received.
 */
-(NSArray *)getAllCurrentBG5Instace;

@end
