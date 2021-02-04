//
//  ECG3Controller.h
//  iHealthDemoCode
//
//  Created by daiqingquan on 15/9/15.
//  Copyright (c) 2015年 zhiwei jing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ECG3USB;

/**
 ECG3USBController
 */
@interface ECG3USBController : NSObject

/**
 share ECG3 Controller

 @return ECG3USBController
 */
+(ECG3USBController *)shareECG3USBController;

/**
 get ECG3

 @return ECG3USB
 */
-(ECG3USB *)getCurrentECG3USBInstace;
@end
