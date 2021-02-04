//
//  HS6ProfileModule.h
//  ReactNativeIOSLibrary
//
//  Created by ihealth on 16/12/20.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<React/RCTAssert.h>)
#import <React/RCTBridgeModule.h>
#else
#import "RCTBridgeModule.h"
#endif

@interface HS6ProfileModule : NSObject<RCTBridgeModule>

//HS6
#define ACTION_HS6_SETWIFI  @"hs6_setwifi"
#define SETWIFI_RESULT   @"setWifiResult"

#define ACTION_HS6_BIND   @"hs6_bind"
#define HS6_BIND_EXTRA   @"bindData"
#define BIND_HS6_RESULT  @"bindResult"
#define HS6_MODEL  @"model"
#define HS6_POSITION  @"position"
#define HS6_SETTED_WIFI  @"settedWifi"

#define ACTION_HS6_UNBIND  @"hs6_unbind"
#define HS6_UNBIND_RESULT @"unBind"

#define ACTION_HS6_GET_TOKEN  @"hs6_get_token"
#define GET_TOKEN_RESULT  @"getTokenResult"

#define ACTION_HS6_SET_UNIT  @"hs6_set_unit"
#define SET_UNIT_RESULT  @"setUnitResult"

#define ACTION_HS6_ERROR  @"hs6_error"
#define HS6_ERROR  @"hs6_error"


#define ACTION_HS6_GET_CLOUDDATA @"hs6_get_clouddata"
#define HS6_CLOUDDATA @"HS6_CLOUDDATA"
#define ACTION_HS6_GET_CLOUDDATA_LASTTS @"hs6_get_clouddata_lastts"
#define HS6_CLOUDDATA_LASTTS @"HS6_CLOUDDATA_LASTTS"
#define ACTION_HS6_GET_CLOUDDATA_LEFTNUM @"hs6_get_clouddata_leftnum"
#define HS6_CLOUDDATA_LEFTNUM @"HS6_CLOUDDATA_LEFTNUM"



@end
