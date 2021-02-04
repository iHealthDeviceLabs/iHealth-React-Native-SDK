//
//  BP5SController.h
//  iHealthSDKStatic
//
//  Created by Realank on 2017/7/7.
//  Copyright © 2017年 daiqingquan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPMacroFile.h"

/**
 BP5S controller class
 */
@interface BP5SController : BPController

/**
 * Initialize controller class
 */
+(instancetype)sharedController;

/**
 * Get all BP5S instance,Access control class instance after receiving BP3LConnectNoti then use instance to call BP5S related communication methods.
 */
-(NSArray *)getAllCurrentInstance;

@end
