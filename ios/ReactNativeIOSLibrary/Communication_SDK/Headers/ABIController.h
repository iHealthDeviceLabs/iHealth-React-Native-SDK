//
//  ABIController.h
//  iHealthDemoCode
//
//  Created by zhiwei jing on 14-11-18.
//  Copyright (c) 2014年 zhiwei jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABI.h"

/**
 ABI controller class
 */
@interface ABIController : NSObject

/**
 * Initialize ABI controller class
 */
+(ABIController *)shareABIController;

/**
 * Get ABI instance,Access control class instance after receiving ABIConnectNoti/ArmConnectNoti, then use this instance to call ABI/ABI-Arm related communication methods.
 * You can use hasLegMonitor property to distinguish whether connecting both arm&leg or only arm
 */
-(ABI *)currentInstance;

@end
