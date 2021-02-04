//
//  NT13BModule.m
//  ReactNativeIOSLibrary
//
//  Created by user on 2019/11/12.
//  Copyright © 2019 daiqingquan. All rights reserved.
//

#import "NT13BModule.h"
#import "NT13BHeader.h"
#import "NT13BProfileModule.h"

@implementation NT13BModule
@synthesize bridge = _bridge;
RCT_EXPORT_MODULE()

- (NSDictionary *)constantsToExport
{
    return @{ @"Event_Notify": NT13B_EVENT_NOTIFY ,
              
    };
}

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}


-(NT13B*)getDeviceWithMac:(NSString*)mac{
    
    NT13BController *controller = [NT13BController shareIHNT13BController];
    NSArray *nt13bDeviceArray = [controller getAllCurrentNT13BInstace];
    
    for(NT13B *tempDevice in nt13bDeviceArray){
        if([mac isEqualToString:tempDevice.serialNumber]){
            
            return tempDevice;
        }
    }
    return nil;
}

RCT_EXPORT_METHOD(getAllConnectedDevices){
    
    
    NSArray*nt13bDeviceArray= [[NT13BController shareIHNT13BController] getAllCurrentNT13BInstace];
    
    NSMutableArray*deviceMacArray=[NSMutableArray array];
    
    for (int i=0; i<[nt13bDeviceArray count]; i++) {
        
        NT13B *nt13b = [nt13bDeviceArray objectAtIndex:i];
        
        [deviceMacArray addObject:nt13b.serialNumber];
        
    }
    
    NSDictionary* deviceInfo = @{NT13B_ACTION:kACTION_GET_ALL_CONNECTED_DEVICES,NT13B_DEVICE:deviceMacArray};
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:NT13B_EVENT_NOTIFY body:deviceInfo];
}

RCT_EXPORT_METHOD(measure:(nonnull NSString *)mac){
    
    
     if ([self getDeviceWithMac:mac] != nil) {
           
         [[self getDeviceWithMac:mac] commandStartMeasure:^(NSDictionary *result) {
             
             NSDictionary* deviceInfo = @{NT13B_ACTION:@"action_measurement_result",NT13B_THERMOMETER_TYPE:[result objectForKey:@"bodyFlag"],NT13B_UNIT_FLAG:[result objectForKey:@"unit"],NT13B_RESULT:[result objectForKey:@"result"]};
                
                [self.bridge.eventDispatcher sendDeviceEventWithName:NT13B_EVENT_NOTIFY body:deviceInfo];
             
             
             
         }];
           
       }
    
}

//断开连接
RCT_EXPORT_METHOD(disconnect:(nonnull NSString *)mac){
    if ([self getDeviceWithMac:mac]!=nil) {
        
        [[self getDeviceWithMac:mac] commandDisconnect:^(BOOL result) {
            
            
        }];
    }else{
        
    }
}

@end
