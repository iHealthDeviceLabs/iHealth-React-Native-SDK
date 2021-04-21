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

#define BG1S_EVENT_NOTIFY @"event_notify_bg1s"

#define BG1S_ACTION @"action"

#define BG1S_TYPE @"type"

#define BG1S_DEVICE @"devices"

#define BG1S_KEY_MAC @"mac"

#define OPERATION_DESCRIBE @"describe"

#define STRIP_INSERTION_STATUS @"insertion_status"

#define kACTION_GET_ALL_CONNECTED_DEVICES   @"ACTION_GET_ALL_CONNECTED_DEVICES"

#define MEASURE_RESULT @"measure_result"

#define MEASURE_MODE @"measure_mode"

#define ACTION_CODE_ANALYSIS                @"action_get_device_info"

#define INFO_BATTERY_BG1S                   @"battery"

#define INFO_VERSION_CODE_BLOOD_BG1S                   @"info_version_code_blood_bg1s"

#define INFO_VERSION_CODE_CTL_BG1S                   @"info_version_code_ctl_bg1s"

#define ACTION_ERROR_BG1S                   @"action_error"

#define ERROR_NUM_BG1S                   @"error_num"

#define ERROR_DESCRIPTION_BG1S                   @"error_description"

#define ACTION_STRIP_INSERTION_STATUS                 @"action_strip_insertion_status"

#define ACTION_GET_BLOOD                @"action_get_blood"

#define ACTION_MEASURE_RESULT         @"action_measure_result"


@end

