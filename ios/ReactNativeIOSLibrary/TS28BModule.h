//
//  TS28BModule.h
//  ReactNativeIOSLibrary
//
//  Created by user on 2019/11/12.
//  Copyright © 2019 daiqingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<React/RCTAssert.h>)
#import <React/RCTEventDispatcher.h>
#else
#import "RCTEventDispatcher.h"
#endif

#import "TS28BHeader.h"

@interface TS28BModule : NSObject<RCTBridgeModule>

@end

