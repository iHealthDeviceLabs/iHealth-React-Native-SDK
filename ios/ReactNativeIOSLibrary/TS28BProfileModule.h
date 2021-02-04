//
//  TS28BProfileModule.h
//  ReactNativeIOSLibrary
//
//  Created by user on 2019/11/14.
//  Copyright © 2019 daiqingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<React/RCTAssert.h>)
#import <React/RCTBridgeModule.h>
#else
#import "RCTBridgeModule.h"
#endif
NS_ASSUME_NONNULL_BEGIN

@interface TS28BProfileModule : NSObject<RCTBridgeModule>


#define TS28B_EVENT_NOTIFY @"event_notify_ts28b"

#define TS28B_ACTION @"action"

#define TS28B_DEVICE @"devices"

#define TS28B_KEY_MAC        @"mac"

#define kACTION_GET_ALL_CONNECTED_DEVICES   @"ACTION_GET_ALL_CONNECTED_DEVICES"

#define TS28B_RESULT @"result"

#define TS28B_UNIT_FLAG @"unit_flag"

#define TS28B_THERMOMETER_TYPE @"thermometer_type"

@end

NS_ASSUME_NONNULL_END
