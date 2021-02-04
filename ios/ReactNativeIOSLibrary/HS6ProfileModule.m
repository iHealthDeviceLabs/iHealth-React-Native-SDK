//
//  HS6ProfileModule.m
//  ReactNativeIOSLibrary
//
//  Created by ihealth on 16/12/20.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import "HS6ProfileModule.h"

@implementation HS6ProfileModule
RCT_EXPORT_MODULE()

#pragma mark
#pragma mark - constantsToExport
@synthesize bridge = _bridge;

-(NSDictionary *)constantsToExport{
    
    
    return @{
             
             @"ACTION_HS6_SETWIFI":ACTION_HS6_SETWIFI,
             
             @"SETWIFI_RESULT":SETWIFI_RESULT,
             
             @"ACTION_HS6_BIND":ACTION_HS6_BIND,
             
             @"HS6_BIND_EXTRA":HS6_BIND_EXTRA,
             
             @"BIND_HS6_RESULT":BIND_HS6_RESULT,
             
             @"HS6_MODEL":HS6_MODEL,
             
             @"HS6_POSITION":HS6_POSITION,
             
             @"HS6_SETTED_WIFI":HS6_SETTED_WIFI,
             
             @"ACTION_HS6_UNBIND":ACTION_HS6_UNBIND,
             
             @"HS6_UNBIND_RESULT":HS6_UNBIND_RESULT,
             
             @"ACTION_HS6_GET_TOKEN":ACTION_HS6_GET_TOKEN,
             
             @"GET_TOKEN_RESULT":GET_TOKEN_RESULT,
             
             @"ACTION_HS6_SET_UNIT":ACTION_HS6_SET_UNIT,
             
             @"SET_UNIT_RESULT":SET_UNIT_RESULT,
             
             @"ACTION_HS6_GET_CLOUDDATA":ACTION_HS6_GET_CLOUDDATA,
             
             @"HS6_CLOUDDATA":HS6_CLOUDDATA,
             
             @"ACTION_HS6_GET_CLOUDDATA_LASTTS":ACTION_HS6_GET_CLOUDDATA_LASTTS,
             
             @"HS6_CLOUDDATA_LASTTS":HS6_CLOUDDATA_LASTTS,
             
             @"ACTION_HS6_GET_CLOUDDATA_LEFTNUM":ACTION_HS6_GET_CLOUDDATA_LEFTNUM,
             
             @"HS6_CLOUDDATA_LEFTNUM":HS6_CLOUDDATA_LEFTNUM,
             
             @"ACTION_HS6_ERROR":ACTION_HS6_ERROR,
             
             @"HS6_ERROR":HS6_ERROR,
             };


}
@end
