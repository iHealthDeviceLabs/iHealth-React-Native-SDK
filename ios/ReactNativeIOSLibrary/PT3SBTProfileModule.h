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
@interface PT3SBTProfileModule : NSObject<RCTBridgeModule>


#define kACTION_SET_TIME              @"ACTION_SET_TIME"

#define kACTION_GET_BATTERY              @"ACTION_GET_BATTERY"

#define kACTION_SET_UNIT              @"ACTION_SET_UNIT"

#define kACTION_GET_UNIT              @"ACTION_GET_UNIT"

#define kACTION_GET_HISTORY_COUNT              @"ACTION_GET_HISTORY_COUNT"

#define kACTION_GET_HISTORY_DATA              @"ACTION_GET_HISTORY_DATA"

#define kACTION_DELETE_HISTORY_DATA              @"ACTION_DELETE_HISTORY_DATA"

#define kACTION_TEMPERATURE_MEASUREMENT              @"ACTION_TEMPERATURE_MEASUREMENT"

#define kACTION_PUB_UNIT              @"ACTION_PUB_UNIT"

#define kACTION_GET_ALL_CONNECTED_DEVICES              @"ACTION_GET_ALL_CONNECTED_DEVICES"

#define STATUS   @"STATUS"

#define BATTERY   @"BATTERY"

#define UNIT   @"UNIT"

#define TS   @"TS"

#define COUNT   @"COUNT"

#define TEMPERATURE   @"TEMPERATURE"

#define HISTORY   @"HISTORY"

@end
