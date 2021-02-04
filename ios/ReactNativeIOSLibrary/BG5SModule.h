//
//  BG5SModule.h
//  ReactNativeIOSLibrary
//
//  Created by soso on 2019/4/24.
//  Copyright © 2019 daiqingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<React/RCTAssert.h>)
#import <React/RCTEventDispatcher.h>
#else
#import "RCTEventDispatcher.h"
#endif

@interface BG5SModule : NSObject<RCTBridgeModule>

@end

