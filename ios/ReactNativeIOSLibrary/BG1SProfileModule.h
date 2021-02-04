//
//  BG1SProfileModule.h
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


@interface BG1SProfileModule : NSObject<RCTBridgeModule>

#define BG1S_EVENT_NOTIFY @"event_notify_BG1S"

#define BG1S_ACTION @"action"

#define BG1S_DEVICE @"devices"

#define BG1S_KEY_MAC        @"mac"

#define kACTION_GET_ALL_CONNECTED_DEVICES   @"ACTION_GET_ALL_CONNECTED_DEVICES"

#define BG1S_RESULT @"result"

#define BG1S_UNIT_FLAG @"unit_flag"

#define BG1S_THERMOMETER_TYPE @"thermometer_type"


#define kRN_ACTION_STRIP_IN                 @"ACTION_STRIP_IN"
#define kRN_ACTION_STRIP_OUT                @"ACTION_STRIP_OUT"
#define kRN_ACTION_GET_BLOOD                @"ACTION_GET_BLOOD"
#define kRN_ACTION_ONLINE_RESULT_BG         @"ACTION_ONLINE_RESULT_BG"
#define kRN_ACTION_GET_FUNCTION             @"ACTION_GET_FUNCTION"

@end

