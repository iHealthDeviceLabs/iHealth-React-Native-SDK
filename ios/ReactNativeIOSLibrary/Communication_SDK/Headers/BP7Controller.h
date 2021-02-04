//
//  BP7Controller.h
//  testShareCommunication
//
//  Created by my on 8/10/13.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPMacroFile.h"

/**
 BP7 controller class
 */
@interface BP7Controller : BPController
/**
 * Initialize BP7 controller class
 */
+(BP7Controller *)shareBP7Controller;

/**
 * Get all BP7 instance,Access control class instance after receiving BP7ConnectNoti, then use instance to call BP7 related communication methods.
 */
-(NSArray *)getAllCurrentBP7Instace;
@end
