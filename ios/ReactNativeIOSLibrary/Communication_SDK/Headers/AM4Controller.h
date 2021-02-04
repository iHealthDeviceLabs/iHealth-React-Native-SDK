//
//  AM4Controller.h
//  iHealthApp3
//
//  Created by 小翼 on 15/5/22.
//  Copyright (c) 2015年 iHealth. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 AM4Controller
 */
@interface AM4Controller : NSObject



/**
 * Initialize AM4 controller class
 */
+(AM4Controller *)shareIHAM4Controller;


/**
 * Access control class instance after receiving AM4ConnectNoti, then use instance to call AM4 related communication methods
 */
-(NSArray *)getAllCurrentAM4Instace;



@end
