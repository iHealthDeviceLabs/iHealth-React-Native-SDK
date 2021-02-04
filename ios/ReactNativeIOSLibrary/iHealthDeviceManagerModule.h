//
//  iHealthDeviceManagerModule.h
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2016/11/23.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<React/RCTAssert.h>)
#import <React/RCTEventDispatcher.h>
#else
#import "RCTEventDispatcher.h"
#endif


@interface iHealthDeviceManagerModule : NSObject<RCTBridgeModule>
{
    NSDictionary *bg1IdpsDic;
}

+ (NSString*)autherizedUserID;
+ (NSString*)autherizedClientID;
+ (NSString*)autherizedClientSecret;

@end
