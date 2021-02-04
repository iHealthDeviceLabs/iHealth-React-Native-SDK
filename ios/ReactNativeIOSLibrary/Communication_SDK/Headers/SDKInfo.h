//
//  SDKInfo.h
//  iHealthSDKStatic
//
//  Created by Lei Bao on 2017/10/19.
//  Copyright © 2017年 ihealthSDK. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 SDKInfo
 */
@interface SDKInfo : NSObject

/**
 Get sdk version

 @return sdk version
 */
+ (NSString *)version;

/**
 Get sdk uuid. It will change with every App's installation

 @return sdk uuid (128-bit)
 */
+ (NSString *)uuid;

@end
