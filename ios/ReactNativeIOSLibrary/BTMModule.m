//
//  BTMModule.m
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2016/12/4.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import "BTMModule.h"
#import "THV3.h"
#import "THV3Controller.h"
#import "BTMProfileModule.h"

@implementation BTMModule{


    NSMutableDictionary*resultDic;

}

#define EVENT_NOTIFY @"event_notify_po3"

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
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reciveDeviceData:) name:@"THV3NewDataCome" object:nil];
        
    }
    return self;
}

-(THV3*)getTHV3WithMac:(NSString*)mac{
    
    THV3Controller *controller = [THV3Controller sharedController];
    NSArray *thvDeviceArray = [controller allCurrentInstance];
    
    for(THV3 *tempTHV3 in thvDeviceArray){
        if([mac isEqualToString:tempTHV3.serialNumber]){
            
            return tempTHV3;
            break;
        }
    }
    
    return nil;
}

-(void)reciveDeviceData:(NSNotification *)tempNoti{
    
    NSDictionary *infoDic=[tempNoti object];
    
    THV3*myTHV3=[self getTHV3WithMac:[infoDic valueForKey:@"SerialNumber"]];
    
    THV3RcvDataType rtDataType=myTHV3.rtDataType;
    
    NSNumber*target;
    
    if (myTHV3.isTargetHuman) {
        
        target=@1;
        
    }else{
        
        target=@2;
    }
    
    if (myTHV3!=nil) {
        
        if (rtDataType==THV3RcvDataRT) {
            
            THV3HistoryData* rtTemperature=myTHV3.rtTemperature;
            
            NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
            [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            if (rtTemperature.measureDate!=nil) {
                
                NSDictionary* deviceInfo = @{BTM_ACTION:BTM_ACTION_MEASURE,BTM_TEMPERATURE:[NSNumber numberWithFloat:rtTemperature.temperature],BTM_MEASURE_TIME:[mydateFormatter stringFromDate:rtTemperature.measureDate],BTM_TEMPERATURE_TARGET:target};
                [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            }
            
            
            
            
        }else{
            
            
            
        }
    }else{
        
        
        NSDictionary* deviceInfo = @{BTM_ACTION:BTM_ACTION_ERROR,BTM_ERROR_DESCRIPTION:@"disconnect"};
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        
    }
    
    
    
}

#pragma mark
#pragma mark - Method

RCT_EXPORT_METHOD(getAllConnectedDevices){
    
    
    NSArray*thv3array= [[THV3Controller sharedController] allCurrentInstance];
    
    NSMutableArray*deviceMacArray=[NSMutableArray array];
    
    for (int i=0; i<[thv3array count]; i++) {
        
        THV3*thv3=[thv3array objectAtIndex:i];
        
        [deviceMacArray addObject:thv3.serialNumber];
        
    }
    
    NSDictionary* deviceInfo = @{@"action":@"ACTION_GET_ALL_CONNECTED_DEVICES",BTM_DEVICE:deviceMacArray};
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
    
    
}



RCT_EXPORT_METHOD(getBattery:(nonnull NSString *)mac){
    
    BOOL voltIsNormal = [self getTHV3WithMac:mac].voltIsNormal;
    
    NSNumber*battNum;
    
    if (voltIsNormal) {
        battNum=@1;
    }else{
        
        battNum=@0;
    }
    
    NSDictionary* deviceInfo = @{BTM_ACTION:BTM_ACTION_BATTERY,BTM_BATTERY:battNum};
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
    
}

RCT_EXPORT_METHOD(getMemoryData:(nonnull NSString *)mac){
    
    
    if ([self getTHV3WithMac:mac]!=nil) {
      
        [[self getTHV3WithMac:mac] readHistoryDataWithResultBlock:^(NSArray<THV3HistoryData *> *dataArray) {
            
            NSMutableArray * tempArr = [[NSMutableArray alloc]init];

            for (int i=0; i<dataArray.count; i++) {
                //将时间格式转化成字符串，适配plugin和react native
                NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
                [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSString *dateStr = [mydateFormatter stringFromDate:[dataArray objectAtIndex:i].measureDate];
                
                NSNumber*target;
                
                if ([dataArray objectAtIndex:i].isHumanBody) {
                    
                    target=@1;
                }else{
                    
                    target=@2;
                }
                
                NSDictionary *dic = @{BTM_MEASURE_TIME:dateStr,BTM_TEMPERATURE:[NSNumber numberWithFloat:[dataArray objectAtIndex:i].temperature],BTM_TEMPERATURE_TARGET:target};
                
                [tempArr addObject:dic];
            }
            
            if (tempArr.count>0) {
                
                NSDictionary* deviceInfo = @{BTM_ACTION:BTM_ACTION_MEMORY,BTM_TEMPERATURE_ARRAY:tempArr,BTM_MEMORY_COUNT:[NSNumber numberWithInt:tempArr.count]};
                [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            }
            
            
        }];
        

    }else{

        NSDictionary* deviceInfo = @{BTM_ACTION:BTM_ACTION_ERROR,BTM_ERROR_DESCRIPTION:@"disconnect"};
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];

    }
    
}

RCT_EXPORT_METHOD(setStandbyTime:(nonnull NSString *)mac :(nonnull NSNumber *)hour:(nonnull NSNumber *)min:(nonnull NSNumber *)sec){
    
    if ([self getTHV3WithMac:mac]!=nil) {
        
        [[self getTHV3WithMac:mac] configIdleTime:[[NSDate date]timeIntervalSince1970] withResultBlock:^(BOOL success) {
            
            NSDictionary* deviceInfo = @{BTM_ACTION:BTM_ACTION_CALLBACK};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        }];
        
        
    }else{
        
        NSDictionary* deviceInfo = @{BTM_ACTION:BTM_ACTION_ERROR,BTM_ERROR_DESCRIPTION:@"disconnect"};
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        
    }
    
    

    
    
}
RCT_EXPORT_METHOD(setTemperatureUnit:(nonnull NSString *)mac:(nonnull NSNumber *)unit){
    
    if ([self getTHV3WithMac:mac]!=nil) {
        
        BOOL isUnitC=YES;
        
        if ([unit intValue]==1) {
            
            isUnitC=YES;
            
        }else{
            
            isUnitC=NO;
        }
        
        [[self getTHV3WithMac:mac] configTemperUnit:isUnitC withResultBlock:^(BOOL success) {
            
            NSDictionary* deviceInfo = @{BTM_ACTION:BTM_ACTION_CALLBACK};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        }];
        
        
    }else{
        
        NSDictionary* deviceInfo = @{BTM_ACTION:BTM_ACTION_ERROR,BTM_ERROR_DESCRIPTION:@"disconnect"};
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        
    }
    
    
    
}
RCT_EXPORT_METHOD(setMeasuringTarget:(nonnull NSString *)mac :(nonnull NSNumber *)target){
    
    if ([self getTHV3WithMac:mac]!=nil) {
        
        BOOL istarget=YES;
        
        if ([target intValue]==1) {
            
            istarget=YES;
            
        }else{
            
            istarget=NO;
        }
        
        [[self getTHV3WithMac:mac] configMeasureTarget:istarget withResultBlock:^(BOOL success) {
            NSDictionary* deviceInfo = @{BTM_ACTION:BTM_ACTION_CALLBACK};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        }];
        
        
    }else{
        
        NSDictionary* deviceInfo = @{BTM_ACTION:BTM_ACTION_ERROR,BTM_ERROR_DESCRIPTION:@"disconnect"};
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        
    }
    
    
}
RCT_EXPORT_METHOD(setOfflineTarget:(nonnull NSString *)mac:(nonnull NSNumber *)target){
    
    if ([self getTHV3WithMac:mac]!=nil) {
        
        BOOL istarget=YES;
        
        if ([target intValue]==1) {
            
            istarget=NO;
            
        }else{
            
            istarget=YES;
        }
        
        [[self getTHV3WithMac:mac] configOfflineMode:istarget withResultBlock:^(BOOL success) {
            
            NSDictionary* deviceInfo = @{BTM_ACTION:BTM_ACTION_CALLBACK};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        }];
        
        
    }else{
        
        NSDictionary* deviceInfo = @{BTM_ACTION:BTM_ACTION_ERROR,BTM_ERROR_DESCRIPTION:@"disconnect"};
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        
    }
    
}

RCT_EXPORT_METHOD(disconnect:(nonnull NSString *)mac){
    
    
    
    
    if ([self getTHV3WithMac:mac]!=nil) {
        
        [[self getTHV3WithMac:mac] commandDisconnectDevice];
        
//        NSDictionary* deviceInfo = @{BTM_ACTION:BTM_ACTION_CALLBACK};
//        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        
    }else{
        
        
        
    }
    
    
    
}





@end
