//
//  ECGModule.h
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2018/1/5.
//  Copyright © 2018年 daiqingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<React/RCTAssert.h>)
#import <React/RCTEventDispatcher.h>
#else
#import "RCTEventDispatcher.h"
#endif
@interface ECGModule : NSObject<RCTBridgeModule>

@end
