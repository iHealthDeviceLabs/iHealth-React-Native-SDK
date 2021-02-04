//
//  NT13BController.h
//  iHealthSDKStatic
//
//  Created by user on 2019/9/20.
//  Copyright © 2019 ihealthSDK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NT13BController : NSObject

/**
 * Initialize NT13B controller class
 */
+(NT13BController *)shareIHNT13BController;


/**
 * Access control class instance after receiving NT13BConnectNoti, then use instance to call NT13B related communication methods
 */
-(NSArray *)getAllCurrentNT13BInstace;

@end

NS_ASSUME_NONNULL_END
