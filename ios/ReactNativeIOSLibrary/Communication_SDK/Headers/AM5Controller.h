//
//  AM5Controller.h
//  iHealthSDKStatic
//
//  Created by user on 2019/7/2.
//  Copyright © 2019 ihealthSDK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AM5Controller : NSObject

/**
 * Initialize AM5 controller class
 */
+(AM5Controller *)shareAM5Controller;


/**
 * Access control class instance after receiving AM5ConnectNoti, then use instance to call AM5 related communication methods
 */
-(NSArray *)getAllCurrentAM5Instace;

-(NSMutableDictionary *)getAllDiscoverAM5Instace;

@end

NS_ASSUME_NONNULL_END
