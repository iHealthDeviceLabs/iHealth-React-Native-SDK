//
//  ECG3Controller.h
//  CES2014ECG
//
//  Created by 小翼 on 15/8/27.
//  Copyright (c) 2015年 leed. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 ECG3Controller
 */
@interface ECG3Controller : NSObject



/**
 * Initialize ECG3 controller class
 */
+(ECG3Controller *)shareECG3Controller;

/**
 * Access control class instance after receiving ECG3ConnectNoti, then use instance to call ECG3 related communication methods
 */
-(NSArray *)getAllCurrentECG3Instace;



@end
