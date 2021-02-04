//
//  BP7SController.h
//  testShareCommunication
//
//  Created by my on 8/10/13.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPController.h"

/**
 BP7S device controller class
 */
@interface BP7SController : BPController{
    NSMutableArray *BP7SDeviceArray;
}

/**
 * Initialize BP7S controller class
 */
+(BP7SController *)shareBP7SController;

/**
 * Get all BP7S instance,Access control class instance after receiving BP7SConnectNoti, then use instance to call BP7S related communication methods.
 */
-(NSArray *)getAllCurrentBP7SInstace;




@end
