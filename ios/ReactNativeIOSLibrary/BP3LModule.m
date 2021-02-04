//
//  BP3LModule.m
//  ReactNativeIOSLibrary
//
//  Created by Liu Yanbo on 2016/12/05.
//  Copyright © 2016年 Liu Yanbo. All rights reserved.
//

#import "BP3LModule.h"
#import "BPProfileModule.h"
#import "BPMacroFile.h"
#import "BP3LController.h"
#import "BP3L.h"
#import "iHealthDeviceManagerModule.h"

#import "ScanDeviceController.h"
#import "ConnectDeviceController.h"
#define EVENT_NOTIFY @"BP3L.MODULE.NOTIFY"

@interface BP3LModule ()
@property (nonatomic, assign) BOOL isMeasuring;

@end

@implementation BP3LModule
@synthesize bridge = _bridge;
RCT_EXPORT_MODULE()

- (NSDictionary *)constantsToExport
{
    return @{
             @"Event_Notify":EVENT_NOTIFY,
             
             };
}
+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

-(BP3L*)getDeviceWithMac:(NSString*)mac{
    
    BP3LController *controller = [BP3LController shareBP3LController];
    NSArray *bpDeviceArray = [controller getAllCurrentBP3LInstace];
    
    for(BP3L *tempDevice in bpDeviceArray){
        if([mac isEqualToString:tempDevice.serialNumber]){
            
            return tempDevice;
        }
    }
    
    return nil;
}


#pragma mark - Method


#pragma mark-获取连接设备
RCT_EXPORT_METHOD(getAllConnectedDevices){
    
    
    NSArray*bp3larray= [[BP3LController shareBP3LController] getAllCurrentBP3LInstace];
    
    NSMutableArray*deviceMacArray=[NSMutableArray array];
    
    for (int i=0; i<[bp3larray count]; i++) {
        
        BP3L*bp3l=[bp3larray objectAtIndex:i];
        
        [deviceMacArray addObject:bp3l.serialNumber];
        
    }
    
    NSDictionary* deviceInfo = @{@"action":@"ACTION_GET_ALL_CONNECTED_DEVICES",@"devices":deviceMacArray};
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
    
    
}




RCT_EXPORT_METHOD(startMeasure:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        __weak typeof(self) weakSelf = self;
        
        [[self getDeviceWithMac:mac] commandStartMeasureWithZeroingState:^(BOOL isComplete) {
            weakSelf.isMeasuring = YES;
            NSDictionary* response = @{
                                       kACTION:isComplete ? kACTION_ZOREING_BP : kACTION_ZOREOVER_BP,
                                       };
            [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
        } pressure:^(NSArray *pressureArr) {
            weakSelf.isMeasuring = YES;
            NSLog(@"pressure %@",pressureArr);
            NSDictionary* response = @{
                                       kACTION:kACTION_ONLINE_PRESSURE_BP,
                                       kBLOOD_PRESSURE_BP:pressureArr.firstObject,
                                       };
            [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
        } waveletWithHeartbeat:^(NSArray *waveletArr) {
            weakSelf.isMeasuring = YES;
            NSLog(@"xiaoboWithHeart %@",waveletArr);
            NSDictionary* response = @{
                                       kACTION:kACTION_ONLINE_PULSEWAVE_BP,
                                       kFLAG_HEARTBEAT_BP:@(1),
                                       kPULSEWAVE_BP:waveletArr
                                       };
            [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
        } waveletWithoutHeartbeat:^(NSArray *waveletArr) {
            weakSelf.isMeasuring = YES;
            NSLog(@"xiaoboNoHeart %@",waveletArr);
            NSDictionary* response = @{
                                       kACTION:kACTION_ONLINE_PULSEWAVE_BP,
                                       kFLAG_HEARTBEAT_BP:@(0),
                                       kPULSEWAVE_BP:waveletArr
                                       };
            [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
        } result:^(NSDictionary *resultDict) {
            weakSelf.isMeasuring = NO;
            NSLog(@"result %@",resultDict);
            NSDictionary* response = @{
                                       kACTION:kACTION_ONLINE_RESULT_BP,
                                       kHIGH_BLOOD_PRESSURE_BP:resultDict[@"sys"],
                                       kLOW_BLOOD_PRESSURE_BP:resultDict[@"dia"],
                                       kPULSE_BP:resultDict[@"heartRate"],
                                       kMEASUREMENT_AHR_BP:resultDict[@"irregular"],
                                       kDATAID:resultDict[@"dataID"],
                                       };
            [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
        } errorBlock:^(BPDeviceError error) {
            weakSelf.isMeasuring = NO;
            NSLog(@"error %d",error);
            [BPProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithCode:error];
        }];
            
    }else{
        self.isMeasuring = NO;
        NSLog(@"error %d",BPDidDisconnect);
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
    }
    
    
}


RCT_EXPORT_METHOD(stopMeasure:(nonnull NSString *)mac){
    if (!self.isMeasuring) {
        NSLog(@"error %d",401);
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:401];
        return;
    }
    __weak typeof(self) weakSelf = self;
    if ([self getDeviceWithMac:mac]!=nil) {
        [[self getDeviceWithMac:mac] stopBPMeassureSuccessBlock:^{
            
            weakSelf.isMeasuring = NO;
            NSDictionary* response = @{
                                       kACTION:kACTION_INTERRUPTED_BP,
                                       };
            [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
            
        } errorBlock:^(BPDeviceError error) {
            
            NSLog(@"error %d",error);
            weakSelf.isMeasuring = NO;
            [BPProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithCode:error];
        }];
        
       
    }else{
        weakSelf.isMeasuring = NO;
        NSLog(@"error %d",BPDidDisconnect);
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
    }
    
    
}

RCT_EXPORT_METHOD(getBattery:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        __weak typeof(self) weakSelf = self;
        [[self getDeviceWithMac:mac] commandEnergy:^(NSNumber *energyValue) {
            NSDictionary* response = @{
                                       kACTION:kACTION_BATTERY_BP,
                                       kBATTERY_BP:energyValue
                                       };
            [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
        } errorBlock:^(BPDeviceError error) {
            NSLog(@"error %d",error);
            [BPProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithCode:error];
        }];
    }else{
        NSLog(@"error %d",BPDidDisconnect);
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
    }
    
    
}

RCT_EXPORT_METHOD(disconnect:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        [[self getDeviceWithMac:mac] commandDisconnectDevice];
    }else{
        NSLog(@"error %d",BPDidDisconnect);
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
    }
    
    
}


@end
