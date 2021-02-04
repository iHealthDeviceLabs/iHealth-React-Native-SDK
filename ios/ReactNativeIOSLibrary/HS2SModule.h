//
//  HS2Module.h
//  ReactNativeIOSLibrary
//
//  Created by jing on 2018/11/26.
//  Copyright © 2018年 daiqingquan. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<React/RCTAssert.h>)
#import <React/RCTBridgeModule.h>
#else
#import "RCTBridgeModule.h"
#endif
@interface HS2SModule : NSObject<RCTBridgeModule>

@end

