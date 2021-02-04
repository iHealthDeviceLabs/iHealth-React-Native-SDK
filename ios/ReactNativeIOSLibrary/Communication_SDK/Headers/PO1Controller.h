//
//  PO1Controller.h
//  testShareCommunication
//
//  Created by daiqingquan on 13-11-29.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 PO1Controller
 */
@interface PO1Controller : NSObject
/**
 * Initialize PO1 controller class
 */
+(PO1Controller *)shareIHPO1Controller;


/**
 * Access control class instance after receiving PO1ConnectNoti, then use instance to call PO1 related communication methods
 */
-(NSArray *)getAllCurrentPO1Instace;




@end
