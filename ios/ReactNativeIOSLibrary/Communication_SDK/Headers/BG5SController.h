//
//  BG5SController.h
//  iHealthSDKStatic
//
//  Created by Lei Bao on 2017/6/30.
//  Copyright © 2017年 daiqingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BGMacroFile.h"

/**
 BG5SController
 */
@interface BG5SController : BGController
/**
 Initialization method

 @return BG5SController singleton
 */
+(BG5SController *)sharedController;
/**
 Get all BG5S Instance
 @note The method should be called when the BG5S has been connected.
 @return BG5S object array
 */
-(NSArray *)getAllCurrentInstace;

@end
