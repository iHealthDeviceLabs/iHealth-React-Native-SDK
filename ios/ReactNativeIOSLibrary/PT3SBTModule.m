//
//  PT3SBTModule.m
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2016/12/4.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import "PT3SBTModule.h"
#import "PT3SBT.h"
#import "PT3SBTController.h"
#import "PT3SBTProfileModule.h"

@implementation PT3SBTModule{


    NSMutableDictionary*resultDic;

}

#define EVENT_NOTIFY @"event_notify_pt3sbt"
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
       
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(devicePT3SBTMeasure:) name:@"PT3SBTNotificationGetResult" object:nil];
        
    }
    
   
    return self;
}

//Content of measurement results：
//{
//    Distance = 1663;
//    Tamb = 275;
//    Tbody = 3521;
//    Tex = 269;
//    Tobj = 274;
//    Vbat = 281;
//}


-(void)devicePT3SBTMeasure:(NSNotification *)tempNoti{
 
    NSDictionary*measureDataDic= [tempNoti userInfo];
    
    NSLog(@"devicePT3SBTMeasure:%@",measureDataDic);
    
    NSDictionary* deviceInfo = @{
        kACTION_KEY:kACTION_TEMPERATURE_MEASUREMENT,TEMPERATURE:[measureDataDic valueForKey:@"Tbody"]};
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(PT3SBT*)getPT3SBTWithMac:(NSString*)mac{
    
    PT3SBTController *controller = [PT3SBTController shareIHPT3SBTController];
    NSArray *poDeviceArray = [controller getAllCurrentPT3SBTInstace];
    
    for(PT3SBT *tempPT3SBT in poDeviceArray){
        if([mac isEqualToString:tempPT3SBT.serialNumber]){
            
            return tempPT3SBT;
            break;
        }
    }
    
    return nil;
}

#pragma mark
#pragma mark - Method

RCT_EXPORT_METHOD(getAllConnectedDevices){
    
    
    NSArray*PT3SBTarray= [[PT3SBTController shareIHPT3SBTController] getAllCurrentPT3SBTInstace];
    
    NSMutableArray*deviceMacArray=[NSMutableArray array];
    
    for (int i=0; i<[PT3SBTarray count]; i++) {
        
        PT3SBT*PT3SBT=[PT3SBTarray objectAtIndex:i];
        
        [deviceMacArray addObject:PT3SBT.serialNumber];
        
    }
    
    NSDictionary* deviceInfo = @{kACTION_KEY:kACTION_GET_ALL_CONNECTED_DEVICES,@"devices":deviceMacArray};
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
    
    
}

#pragma mark 设置时间
RCT_EXPORT_METHOD(setTime:(nonnull NSString *)mac){
    
    
    if ([self getPT3SBTWithMac:mac]) {
        __weak typeof(self) weakSelf = self;
        
        [[self getPT3SBTWithMac:mac] commandFunction:^(NSDictionary *functionDict) {
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                            kMAC_KEY:mac,
                                                            kACTION_KEY:kACTION_SET_TIME,
                                                            }];
            
        } DisposeErrorBlock:^(PT3SBTDeviceError error) {
            
        }];
       
}

}

#pragma mark 设置单位
RCT_EXPORT_METHOD(setUnit:(nonnull NSString *)mac :(nonnull NSNumber *)unit){

    if ([self getPT3SBTWithMac:mac]) {
        
        PT3SBTTemperatureUnit tempUnit = PT3SBTTemperatureUnit_C;
        if ([unit isEqual:@(PT3SBTTemperatureUnit_C)]) {
            tempUnit = PT3SBTTemperatureUnit_C;
        } else if([unit isEqual:@(PT3SBTTemperatureUnit_F)]) {
            tempUnit = PT3SBTTemperatureUnit_F;
        } else {
            tempUnit = PT3SBTTemperatureUnit_C;
            return;
        }
        __weak typeof(self) weakSelf = self;
        
        [[self getPT3SBTWithMac:mac] commandPT3SBTSetUnit:tempUnit DisposeSetUnitResult:^(BOOL setResult) {
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                        kMAC_KEY:mac,
                                                        kACTION_KEY:kACTION_SET_UNIT,
                                                        }];
            
        } DisposeErrorBlock:^(PT3SBTDeviceError error) {
            
        }];
        
    
    }
}

#pragma mark 获取单位
RCT_EXPORT_METHOD(getUnit:(nonnull NSString *)mac){

    if ([self getPT3SBTWithMac:mac]) {
        
        [[self getPT3SBTWithMac:mac] commandPT3SBTGetUnit:^(PT3SBTTemperatureUnit unit) {
            
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                        kMAC_KEY:mac,
                                                        UNIT:[NSNumber numberWithInt:unit],
                                                        kACTION_KEY:kACTION_GET_UNIT,
                                                        }];
            
        } DisposeErrorBlock:^(PT3SBTDeviceError error) {
            
        }];
    
    }
}

#pragma mark 获取数据条数
RCT_EXPORT_METHOD(getHistoryCount:(nonnull NSString *)mac){

    if ([self getPT3SBTWithMac:mac]) {
        
        [[self getPT3SBTWithMac:mac] commandPT3SBTGetMemoryCount:^(NSNumber *count) {
            
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                        kMAC_KEY:mac,
                                                        COUNT:count,
                                                        kACTION_KEY:kACTION_GET_HISTORY_COUNT,
                                                        }];
            
        } DisposeErrorBlock:^(PT3SBTDeviceError error) {
            
        }];
    
    }
}

#pragma mark 获取数据
RCT_EXPORT_METHOD(getHistoryData:(nonnull NSString *)mac){

    if ([self getPT3SBTWithMac:mac]) {
        
        [[self getPT3SBTWithMac:mac] commandGetMemorryData:^(NSMutableArray *memoryDataArray) {
            
            
            if(memoryDataArray != nil){
                
                if(memoryDataArray.count){
                    
                    NSMutableArray*dataArray=[NSMutableArray array];
                    
                    for (int i=0; i<memoryDataArray.count; i++) {
                        
                        NSNumber*ts=[[memoryDataArray objectAtIndex:i] objectForKey:@"TS"];
                        
                        NSDate *tempDate = [NSDate dateWithTimeIntervalSince1970:[ts intValue]];
                        
                        
                        NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
                        [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        NSString *dateStr = [mydateFormatter stringFromDate:tempDate];
                        
                        
                        NSDictionary*dic=@{TS:dateStr,TEMPERATURE:[[memoryDataArray objectAtIndex:i] objectForKey:@"Tbody"]};
                        
                        [dataArray addObject:dic];
                    }
                    
                    
                    NSDictionary *deviceInfo = @{kMAC_KEY:mac,kACTION_KEY:kACTION_GET_HISTORY_DATA,HISTORY:dataArray};
                    
                    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
                    NSLog(@"historyDataArray:%@",memoryDataArray);
                    
                }else{
                    
                    NSDictionary *deviceInfo = @{kMAC_KEY:mac,kACTION_KEY:kACTION_GET_HISTORY_DATA,HISTORY:[NSArray array]};
                    
                    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
                    
                }
                
            }
            
            
            
        } DisposeErrorBlock:^(PT3SBTDeviceError error) {
            
        }];
    
    }
}

#pragma mark 删除数据
RCT_EXPORT_METHOD(deleteHistory:(nonnull NSString *)mac){

    if ([self getPT3SBTWithMac:mac]) {
        
        [[self getPT3SBTWithMac:mac] commandDeleteMemorryData:^(BOOL deleteResult) {
            
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                        kMAC_KEY:mac,
                                                        kACTION_KEY:kACTION_DELETE_HISTORY_DATA,
                                                        }];
            
        } DisposeErrorBlock:^(PT3SBTDeviceError error) {
            
        }];
    
    }
}


RCT_EXPORT_METHOD(getBattery:(nonnull NSString *)mac){
    
    if ([self getPT3SBTWithMac:mac]!=nil) {
        
        
        [[self getPT3SBTWithMac:mac] commandGetPT3SBTBattery:^(NSNumber *battary) {
            
            NSDictionary* deviceInfo = @{kACTION_KEY:kACTION_GET_BATTERY,BATTERY:battary};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } DiaposeErrorBlock:^(PT3SBTDeviceError error) {
            
        }];
        
    
    }else{
        
        NSDictionary* deviceInfo = @{kACTION_KEY:@"ACTION_ERROR_PO",@"error_po":@"disconnect"};
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        
    }
    
    
}

RCT_EXPORT_METHOD(disconnect:(nonnull NSString *)mac){
    
    
    if ([self getPT3SBTWithMac:mac]!=nil) {
        
        [[self getPT3SBTWithMac:mac] commandDisconnectDevice];
        
    }else{
        
        
        
    }
    
    
    
}





@end
