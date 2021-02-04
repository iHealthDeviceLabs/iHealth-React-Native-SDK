//
//  BPContinuaController.h
//  testShareCommunication
//
//  Created by zhiwei jing on 13-10-22.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPContinua.h"
#import "BPController.h"

/**
 BPContinua controller class
 */
@interface BPContinuaController : BPController{
    
}

/**
 * Initialize contina BP controller class
 */
+(BPContinuaController *)sharedController;

/**
 * Get all ContinuaBP instance,Access control class instance after receiving ContinuaBPConnectNoti, then use instance to call ContinuaBP related communication methods.
 */
- (NSArray *)allConnectedInstance;

@end
