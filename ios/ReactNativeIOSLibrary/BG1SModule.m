//
//  BG1SModule.m
//  ReactNativeIOSLibrary
//
//  Created by user on 2019/11/12.
//  Copyright © 2019 daiqingquan. All rights reserved.
//

#import "BG1SModule.h"
#import "BG1S.h"
#import "BG1SController.h"
#import "BG1SProfileModule.h"

#import "BGHeader.h"

@implementation BG1SModule
@synthesize bridge = _bridge;
RCT_EXPORT_MODULE()

- (NSDictionary *)constantsToExport
{
    return @{ @"Event_Notify": BG1S_EVENT_NOTIFY ,
              
    };
}

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}


-(BG1S*)getDeviceWithMac:(NSString*)mac{
    
    BG1SController *controller = [BG1SController shareIHBG1SController];
    NSArray *BG1SDeviceArray = [controller getAllCurrentBG1SInstace];
    
    for(BG1S *tempDevice in BG1SDeviceArray){
        if([mac isEqualToString:tempDevice.serialNumber]){
            
            return tempDevice;
        }
    }
    return nil;
}

RCT_EXPORT_METHOD(getAllConnectedDevices){
    
    
    NSArray*BG1SDeviceArray= [[BG1SController shareIHBG1SController] getAllCurrentBG1SInstace];
    
    NSMutableArray*deviceMacArray=[NSMutableArray array];
    
    for (int i=0; i<[BG1SDeviceArray count]; i++) {
        
        BG1S *BG1S = [BG1SDeviceArray objectAtIndex:i];
        
        [deviceMacArray addObject:BG1S.serialNumber];
        
    }
    
    NSDictionary* deviceInfo = @{BG1S_ACTION:kACTION_GET_ALL_CONNECTED_DEVICES,BG1S_DEVICE:deviceMacArray};
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:BG1S_EVENT_NOTIFY body:deviceInfo];
}

RCT_EXPORT_METHOD(measure:(nonnull NSString *)mac measureMode:(nonnull NSNumber *)testType){
    
    
     if ([self getDeviceWithMac:mac] != nil) {
         
         BGMeasureMode models= BGMeasureMode_Blood;
         
         if ([testType intValue]==0) {
             
             models=BGMeasureMode_Blood;
             
         }else{
             
             models=BGMeasureMode_NoBlood;
         }
         
         [[self getDeviceWithMac:mac] commandCreateBG1STestModel:models DisposeBGStripInBlock:^(BOOL inORout) {
             
             if (inORout) {
                  [self.bridge.eventDispatcher sendDeviceEventWithName:BG1S_EVENT_NOTIFY body:@{
                             BG1S_KEY_MAC:mac,
                             BG1S_ACTION:kRN_ACTION_STRIP_IN,
                             }];
             }else{
                 
                 [self.bridge.eventDispatcher sendDeviceEventWithName:BG1S_EVENT_NOTIFY body:@{
                             BG1S_KEY_MAC:mac,
                             BG1S_ACTION:kRN_ACTION_STRIP_OUT,
                             }];
             }
             
         } DisposeBGBloodBlock:^{
             
             [self.bridge.eventDispatcher sendDeviceEventWithName:BG1S_EVENT_NOTIFY body:@{
                                         BG1S_KEY_MAC:mac,
                                         BG1S_ACTION:kRN_ACTION_GET_BLOOD,
                                         }];
             
         } DisposeBGResultBlock:^(NSDictionary *result) {
             
             
             [self.bridge.eventDispatcher sendDeviceEventWithName:BG1S_EVENT_NOTIFY body:@{
                                                                                         BG1S_KEY_MAC:mac,
                                                                        @"result":result,
                                                                                         BG1S_ACTION:kRN_ACTION_ONLINE_RESULT_BG,
                                                                                         }];
             
         } DisposeBGErrorBlock:^(BG1SDeviceError error) {
             
         }];
           
//         [[self getDeviceWithMac:mac] commandStartMeasure:^(NSDictionary *result) {
//
//             NSDictionary* deviceInfo = @{BG1S_ACTION:@"action_measurement_result",BG1S_THERMOMETER_TYPE:[result objectForKey:@"bodyFlag"],BG1S_UNIT_FLAG:[result objectForKey:@"unit"],BG1S_RESULT:[result objectForKey:@"result"]};
//
//                [self.bridge.eventDispatcher sendDeviceEventWithName:BG1S_EVENT_NOTIFY body:deviceInfo];
//
//
//
//         }];
           
       }
    
}

//getFunction
RCT_EXPORT_METHOD(getFunction:(nonnull NSString *)mac){
    if ([self getDeviceWithMac:mac]!=nil) {
        
        
        [[self getDeviceWithMac:mac] commandFunction:^(NSDictionary *functionDict) {
            
            
            [self.bridge.eventDispatcher sendDeviceEventWithName:BG1S_EVENT_NOTIFY body:@{
                                                                                                               BG1S_KEY_MAC:mac,
                                                                                       @"result":functionDict,
                                                                                                               BG1S_ACTION:kRN_ACTION_GET_FUNCTION,
                                                                                                               }];
            
        } DisposeBGErrorBlock:^(BG1SDeviceError error) {
            
        }];
        
       
    }else{
        
    }
}

//断开连接
RCT_EXPORT_METHOD(disconnect:(nonnull NSString *)mac){
    if ([self getDeviceWithMac:mac]!=nil) {
        
        [[self getDeviceWithMac:mac] commandDisconnectDevice];
    }else{
        
    }
}

@end
