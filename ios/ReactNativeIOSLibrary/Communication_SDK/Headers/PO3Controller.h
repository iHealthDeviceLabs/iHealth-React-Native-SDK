//
//  PO3Controller.h
//  testShareCommunication
//
//  Created by daiqingquan on 13-11-29.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 PO3Controller
 */
@interface PO3Controller : NSObject
/**
 * Initialize PO3 controller class
 */
+(PO3Controller *)shareIHPO3Controller;


/**
 * Access control class instance after receiving PO3ConnectNoti, then use instance to call PO3 related communication methods
 */
-(NSArray *)getAllCurrentPO3Instace;




@end
