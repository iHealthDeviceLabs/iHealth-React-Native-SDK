//
//  BP3Controller.h
//  testShareCommunication
//
//  Created by zhiwei jing on 13-10-22.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPMacroFile.h"


/**
 BP3 controller class
 */
@interface BP3Controller : NSObject
/**
 * Initialize BP3 controller class
 */
+(BP3Controller *)shareBP3Controller;

/**
 * Get all BP3 instance,Access control class instance after receiving BP3ConnectNoti, then use instance to call BP3 related communication methods.
 */
-(NSArray *)getAllCurrentBP3Instace;

@end
