//
//  BP5SRWController.h
//  testShareCommunication
//
//  Created by my on 14/10/13.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPMacroFile.h"

/**
 BP5SRW contoller class
 */
@interface BP5SRWController : BPController
/**
 * Initialize BP5SRW controller class
 */
+(BP5SRWController *)shareBP5SRWController;

/**
 * Get all BP5SRW instance,Access control class instance after receiving BP5SRWConnectNoti then use instance to call BP5SRW related communication methods.
 */
-(NSArray *)getAllCurrentBP5SRWInstace;

@end
