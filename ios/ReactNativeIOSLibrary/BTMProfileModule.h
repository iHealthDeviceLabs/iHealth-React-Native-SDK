//
//  BTMProfileModule.h
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
@interface BTMProfileModule : NSObject<RCTBridgeModule>



#define BTMACTION @"event_notify_btm"
#define BTM_ACTION @"action"

#define BTM_BATTERY @"battery"

#define BTM_ACTION_BATTERY @"battery_btm"

#define BTM_ACTION_MEMORY @"memory_btm"

#define BTM_ACTION_MEASURE @"measure_btm"

#define BTM_ACTION_CALLBACK @"btm_callback"

#define BTM_ACTION_ERROR @"action_error_btm"

#define BTM_MEMORY_COUNT @"memory_count"

#define BTM_TEMPERATURE_ARRAY @"btm_temperature_array"

#define BTM_TEMPERATURE_TARGET @"btm_temperature_target"

#define BTM_TEMPERATURE @"btm_temperature"

#define BTM_MEASURE_TIME @"measure_time"

#define BTM_ERROR_DESCRIPTION @"description"

#define BTM_ERROR_NUM @"error_num"

#define BTM_DEVICE @"devices"

@end
