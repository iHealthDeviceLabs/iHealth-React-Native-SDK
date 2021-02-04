//
//  ABPMController.h
//  iHealthSDKStatic
//
//  Created by Realank on 2017/9/26.
//  Copyright © 2017年 ihealthSDK. All rights reserved.
//

#import "BPController.h"

/**
 ABPM controller class
 */
@interface ABPMController : BPController
/**
 * Initialize ABPM controller class
 */
+ (ABPMController *)sharedController;

/**
 * Get all ABPM instance,Access control class instance after receiving BP3LConnectNoti then use instance to call ABPM related communication methods.
 */
- (NSArray *)allConnectedInstance;

@end
