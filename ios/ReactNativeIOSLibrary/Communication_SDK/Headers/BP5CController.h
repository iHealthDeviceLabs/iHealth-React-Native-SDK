//
//  ABPMController.h
//  iHealthSDKStatic
//
//  Created by Realank on 2017/9/26.
//  Copyright © 2017年 ihealthSDK. All rights reserved.
//

#import "BPController.h"

/**
 BP5C controller class
 */
@interface BP5CController : BPController
/**
 * Initialize BP5C controller class
 */
+ (BP5CController *)sharedController;

/**
 * Get all BP5C instance,Access control class instance after receiving BP3LConnectNoti then use instance to call BP5C related communication methods.
 */
- (NSArray *)allConnectedInstance;

@end
