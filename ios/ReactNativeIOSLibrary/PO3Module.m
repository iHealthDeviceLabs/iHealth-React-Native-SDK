//
//  PO3Module.m
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2016/12/4.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import "PO3Module.h"
#import "PO3.h"
#import "PO3Controller.h"
#import "POProfileModule.h"
#import "ManageDeviceController.h"

@implementation PO3Module{


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
        
        
    }
    return self;
}

-(PO3*)getPO3WithMac:(NSString*)mac{
    
    PO3Controller *controller = [PO3Controller shareIHPO3Controller];
    NSArray *poDeviceArray = [controller getAllCurrentPO3Instace];
    
    for(PO3 *tempPO3 in poDeviceArray){
        if([mac isEqualToString:tempPO3.serialNumber]){
            
            return tempPO3;
            break;
        }
    }
    
    return nil;
}

#pragma mark
#pragma mark - Method

RCT_EXPORT_METHOD(getAllConnectedDevices){
    
    
    NSArray*po3array= [[PO3Controller shareIHPO3Controller] getAllCurrentPO3Instace];
    
    NSMutableArray*deviceMacArray=[NSMutableArray array];
    
    for (int i=0; i<[po3array count]; i++) {
        
        PO3*po3=[po3array objectAtIndex:i];
        
        [deviceMacArray addObject:po3.serialNumber];
        
    }
    
    NSDictionary* deviceInfo = @{@"action":@"ACTION_GET_ALL_CONNECTED_DEVICES",@"devices":deviceMacArray};
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
    
    
}



RCT_EXPORT_METHOD(getBattery:(nonnull NSString *)mac){
    
    if ([self getPO3WithMac:mac]!=nil) {
        
        [[self getPO3WithMac:mac] commandPO3SyncTime:^(BOOL resetSuc) {
            
        } withErrorBlock:^(PO3ErrorID errorID) {
            
        }];
        
        [[self getPO3WithMac:mac] commandPO3GetDeviceBattery:^(NSNumber *battery) {
            
            NSDictionary* deviceInfo = @{POACTION:@"ACTION_BATTERY_PO",PO_BATTERY:battery};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } withErrorBlock:^(PO3ErrorID errorID) {
            
        }];
    }else{
        
        NSDictionary* deviceInfo = @{POACTION:@"ACTION_ERROR_PO",@"error_po":@"disconnect"};
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        
    }
    
    
}


RCT_EXPORT_METHOD(startMeasure:(nonnull NSString *)mac){
    
    
    if ([self getPO3WithMac:mac]!=nil) {
        
        [[self getPO3WithMac:mac] commandPO3StartMeasure:^(BOOL resetSuc) {
            
        } withMeasureData:^(NSDictionary *measureDataDic) {
            
            NSDictionary* deviceInfo = @{@"action":@"ACTION_LIVEDA_PO",@"pulseWave":[measureDataDic valueForKey:@"wave"],@"dataID":[measureDataDic valueForKey:@"dataID"],@"pi":[measureDataDic valueForKey:@"PI"],@"pulsestrength":[measureDataDic valueForKey:@"height"],@"bloodoxygen":[measureDataDic valueForKey:@"spo2"],@"heartrate":[measureDataDic valueForKey:@"bpm"]};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
            resultDic=[[NSMutableDictionary alloc] initWithDictionary:deviceInfo];
            
        } withFinishMeasure:^(BOOL finishData) {
            
            [resultDic setValue:@"ACTION_RESULTDATA_PO" forKey:POACTION];
            
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:resultDic];
            
        } withErrorBlock:^(PO3ErrorID errorID) {
            
        }];
        
    }else{
        
        NSDictionary* deviceInfo = @{@"action":@"ACTION_ERROR_PO",@"error_po":@"disconnect"};
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        
    }
    
}

RCT_EXPORT_METHOD(getHistoryData:(nonnull NSString *)mac){
    
    
    
    if ([self getPO3WithMac:mac]!=nil) {
        
        
        [[self getPO3WithMac:mac] commandPO3SyncTime:^(BOOL resetSuc) {
            
        } withErrorBlock:^(PO3ErrorID errorID) {
            
        }];
        
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];

        [[self getPO3WithMac:mac] commandPO3OfflineDataCount:^(NSNumber *dataCount) {
            
            if(dataCount.intValue == 0){
                NSDictionary *dic = @{POACTION:@"ACTION_NO_OFFLINEDATA_PO"};
                [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:dic];
            }
            
        } withOfflineData:^(NSDictionary *OfflineData) {
            
         
            NSDateFormatter *dateFormat = nil;
            
            if (dateFormat == nil) {
                dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
            }
            
            NSString *locationString=[dateFormat stringFromDate:[OfflineData valueForKey:@"date"]];
            
            
            NSDictionary* deviceInfo = @{
                                         @"measureDate":locationString,
                                         @"dataID":[OfflineData valueForKey:@"dataID"],
                                         @"pulseWave":[OfflineData valueForKey:@"wave"],
                                         @"heartrate":[OfflineData valueForKey:@"bpm"],
                                         @"bloodoxygen":[OfflineData valueForKey:@"spo2"]};
            
           
            [resultArray addObject:deviceInfo];



        } withOfflineWaveData:^(NSDictionary *offlineWaveDataDic) {
            
        } withFinishMeasure:^(BOOL resetSuc) {
            
                NSDictionary *dic = @{kMAC:mac,POACTION:@"ACTION_OFFLINEDATA_PO",@"offlineData":resultArray};
//                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:resultArray,@"offLineData", nil];
                [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:dic];
           

        } withErrorBlock:^(PO3ErrorID errorID) {
            
        }];
        
    }else{
        
        
        
    }
    
    
    
    
}


RCT_EXPORT_METHOD(disconnect:(nonnull NSString *)mac){
    
    
    
    
    if ([self getPO3WithMac:mac]!=nil) {
        
        [[ManageDeviceController commandGetInstance] commandDisconnectSelectDevice:[self getPO3WithMac:mac].currentUUID];
        
    }else{
        
        
        
    }
    
    
    
}





@end
