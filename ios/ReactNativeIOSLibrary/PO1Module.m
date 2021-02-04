//
//  PO1Module.m
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2016/12/4.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import "PO1Module.h"
#import "PO1.h"
#import "PO1Controller.h"
#import "PO1ProfileModule.h"

@implementation PO1Module{


    NSMutableDictionary*resultDic;

}

#define EVENT_NOTIFY @"event_notify_po1"
#define kMAC_KEY        @"mac"
#define kACTION_KEY     @"action"

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE()


#pragma mark
#pragma mark - constantsToExport
- (NSDictionary *)constantsToExport
{
    return @{ @"Event_Notify": EVENT_NOTIFY };
    
}

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}
#pragma mark
#pragma mark - Init
-(id)init
{
    if (self=[super init])
    {
       
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(devicePO1Measure:) name:@"PO1NotificationMeasureData" object:nil];
        
    }
    
   
    return self;
}


-(void)devicePO1Measure:(NSNotification *)tempNoti{
 
    NSDictionary*measureDataDic= [tempNoti userInfo];
    
    NSLog(@"devicePO1Measure:%@",measureDataDic);
    
    NSDictionary* deviceInfo = @{kACTION_KEY:@"ACTION_BO_MEASUREMENT",@"WAVE":[measureDataDic valueForKey:@"wave"],@"PI":[measureDataDic valueForKey:@"PI"],@"PULSE_FORCE":[measureDataDic valueForKey:@"height"],@"BLOOD_OXYGEN":[measureDataDic valueForKey:@"spo2"],@"PULSE":[measureDataDic valueForKey:@"bpm"]};
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(PO1*)getPO1WithMac:(NSString*)mac{
    
    PO1Controller *controller = [PO1Controller shareIHPO1Controller];
    NSArray *poDeviceArray = [controller getAllCurrentPO1Instace];
    
    for(PO1 *tempPO1 in poDeviceArray){
        if([mac isEqualToString:tempPO1.serialNumber]){
            
            return tempPO1;
            break;
        }
    }
    
    return nil;
}

#pragma mark
#pragma mark - Method

RCT_EXPORT_METHOD(getAllConnectedDevices){
    
    
    NSArray*po1array= [[PO1Controller shareIHPO1Controller] getAllCurrentPO1Instace];
    
    NSMutableArray*deviceMacArray=[NSMutableArray array];
    
    for (int i=0; i<[po1array count]; i++) {
        
        PO1*po1=[po1array objectAtIndex:i];
        
        [deviceMacArray addObject:po1.serialNumber];
        
    }
    
    NSDictionary* deviceInfo = @{kACTION_KEY:@"ACTION_GET_ALL_CONNECTED_DEVICES",@"devices":deviceMacArray};
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
    
    
}



RCT_EXPORT_METHOD(getBattery:(nonnull NSString *)mac){
    
    if ([self getPO1WithMac:mac]!=nil) {
        
        
        [[self getPO1WithMac:mac] commandPO1GetDeviceBattery:^(NSNumber *battery) {
            
            NSDictionary* deviceInfo = @{kACTION_KEY:@"ACTION_GET_BATTERY",@"BATTERY":battery};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } withErrorBlock:^(PO1ErrorID errorID) {
            
        }];
    }else{
        
        NSDictionary* deviceInfo = @{kACTION_KEY:@"ACTION_ERROR_PO1",@"ERROR_DESCRIPTION":@"disconnect"};
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        
    }
    
    
}

RCT_EXPORT_METHOD(disconnect:(nonnull NSString *)mac){
    
    
    if ([self getPO1WithMac:mac]!=nil) {
        
        [[self getPO1WithMac:mac] commandDisconnectDevice];
        
    }else{
        
        
        
    }
    
    
    
}





@end
