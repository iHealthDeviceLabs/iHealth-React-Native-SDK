//
//  BP5SModule.h
//  ReactNativeIOSLibrary
//
//  Created by soso on 2019/4/17.
//  Copyright © 2019 daiqingquan. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<React/RCTAssert.h>)
#import <React/RCTBridgeModule.h>
#else
#import "RCTBridgeModule.h"
#endif
@interface BP5SModule : NSObject<RCTBridgeModule>


@end
