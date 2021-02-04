//
//  HS2Controller.h
//  iHealthSDKStatic
//
//  Created by ihealth on 2017/6/6.
//  Copyright © 2017年 daiqingquan. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 HS2Controller
 */
@interface HS2Controller : NSObject
/**
 * Initialize HS2 controller class
 */
+(HS2Controller *)shareIHHs2Controller;

/**
 * Get all scale instance,use hsInstance to call HS related communication methods.
 */
-(NSArray *)getAllCurrentHS2Instace;

@end
