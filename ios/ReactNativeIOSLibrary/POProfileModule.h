//
//  POProfileModule.h
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2016/12/4.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<React/RCTAssert.h>)
#import <React/RCTBridgeModule.h>
#else
#import "RCTBridgeModule.h"
#endif
@interface POProfileModule : NSObject<RCTBridgeModule>



#define POACTION @"action"
#define PO_BATTERY @"BATTERY_PO"
#define kMAC @"mac"

@end
