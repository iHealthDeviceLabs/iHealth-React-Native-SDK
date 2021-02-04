//
//  BP3LModule.h
//  ReactNativeIOSLibrary
//
//  Created by Liu Yanbo on 2016/12/05.
//  Copyright © 2016年 Liu Yanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<React/RCTAssert.h>)
#import <React/RCTBridgeModule.h>
#else
#import "RCTBridgeModule.h"
#endif

@interface BP3LModule : NSObject<RCTBridgeModule>

@end
