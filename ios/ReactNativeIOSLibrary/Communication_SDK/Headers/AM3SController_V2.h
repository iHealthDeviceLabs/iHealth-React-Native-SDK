//
//  AM3SController_V2.h
//  iHealthDemoCode
//
//  Created by user on 16/8/12.
//  Copyright © 2016年 zhiwei jing. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 AM3SController_V2
 */
@interface AM3SController_V2 : NSObject

/**
 * Initialize AM3S controller class
 */
+(AM3SController_V2 *)shareIHAM3SController;


/**
 * Access control class instance after receiving AM3SConnectNoti, then use instance to call AM3S related communication methods
 */
-(NSArray *)getAllCurrentAM3SInstace;



@end
