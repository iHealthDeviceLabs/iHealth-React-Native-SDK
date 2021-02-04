//
//  BP5Module.m
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2016/11/23.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import "BP5Module.h"
#import "BPProfileModule.h"
#import "BPMacroFile.h"
#import "BP5Controller.h"
#import "BP5.h"
#import "iHealthDeviceManagerModule.h"

@interface BP5Module()
@property (nonatomic, strong) NSNumber* previousPressure;
@property (nonatomic, assign) BOOL startSendWavelet;
@property (nonatomic, assign) BOOL isMeasuring;

@end
@implementation BP5Module
#define EVENT_NOTIFY @"BP5.MODULE.NOTIFY"
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

#pragma mark
#pragma mark - Init

-(BP5*)getBP5WithMac:(NSString*)mac{
    
    BP5Controller *controller = [BP5Controller shareBP5Controller];
    NSArray *bpDeviceArray = [controller getAllCurrentBP5Instace];
    
    for(BP5 *tempDevice in bpDeviceArray){
        if([mac isEqualToString:tempDevice.serialNumber]){
            
            return tempDevice;
        }
    }
    
    return nil;

//    static BP5* bp5Device = nil;
//    if (!bp5Device) {
//        BP5Controller *controller = [BP5Controller shareBP5Controller];
//        NSArray *bpDeviceArray = [controller getAllCurrentBP5Instace];
//        
//        for(BP5 *tempBP5 in bpDeviceArray){
//            if([mac isEqualToString:tempBP5.serialNumber]){
//                
//                bp5Device = tempBP5;
//                break;
//            }
//        }
//    }
//    
//
//    return bp5Device;
}

#pragma mark
#pragma mark - Notification
#pragma mark - BP5
//-(void)DeviceConnectForBP5:(NSNotification *)tempNoti{
//    BP5Controller *controller = [BP5Controller shareBP5Controller];
//    NSArray *bpDeviceArray = [controller getAllCurrentBP5Instace];
//   
//    BP5 *bpInstance = [bpDeviceArray objectAtIndex:0];
//      
//}
//
//- (void)DeviceDisConnectForBP5:(NSNotification*)tempNoti{
//    
//}




#pragma mark
#pragma mark - Method


#pragma mark-获取连接设备
RCT_EXPORT_METHOD(getAllConnectedDevices){
    
    
    NSArray*bp5array= [[BP5Controller shareBP5Controller] getAllCurrentBP5Instace];
    
    NSMutableArray*deviceMacArray=[NSMutableArray array];
    
    for (int i=0; i<[bp5array count]; i++) {
        
        BP5*bp5=[bp5array objectAtIndex:i];
        
        [deviceMacArray addObject:bp5.serialNumber];
        
    }
    
    NSDictionary* deviceInfo = @{@"action":@"ACTION_GET_ALL_CONNECTED_DEVICES",@"devices":deviceMacArray};
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
    
    
}





RCT_EXPORT_METHOD(startMeasure:(nonnull NSString *)mac){
    
    _previousPressure = @(0);
    self.startSendWavelet = NO;
    if ([self getBP5WithMac:mac]!=nil) {
        __weak typeof(self) weakSelf = self;
        [[self getBP5WithMac:mac] commandStartMeasureWithZeroingState:^(BOOL isComplete) {
            weakSelf.isMeasuring = YES;
            NSDictionary* response = @{
                                       kACTION:isComplete ? kACTION_ZOREING_BP : kACTION_ZOREOVER_BP,
                                       };
            [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
        } pressure:^(NSArray *pressureArr) {
            NSLog(@"pressure %@",pressureArr);
            weakSelf.isMeasuring = YES;
            [weakSelf sendPresssre:pressureArr.firstObject wavelet:nil isHeartPulse:NO];
        } waveletWithHeartbeat:^(NSArray *waveletArr) {
            NSLog(@"xiaoboWithHeart %@",waveletArr);
            weakSelf.isMeasuring = YES;
            [weakSelf sendPresssre:nil wavelet:waveletArr isHeartPulse:YES];
        } waveletWithoutHeartbeat:^(NSArray *waveletArr) {
            weakSelf.isMeasuring = YES;
            NSLog(@"xiaoboNoHeart %@",waveletArr);
            [weakSelf sendPresssre:nil wavelet:waveletArr isHeartPulse:NO];
        } result:^(NSDictionary *resultDict) {
            NSLog(@"result %@",resultDict);
            weakSelf.startSendWavelet = NO;
            weakSelf.isMeasuring = NO;
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
            NSLog(@"error %lu",(unsigned long)error);
            weakSelf.startSendWavelet = NO;
            weakSelf.isMeasuring = NO;
            [BPProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithCode:error];
            
        }];
        
        
    }else{
    
        NSLog(@"error %d",BPDidDisconnect);
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
        self.isMeasuring = NO;
    }
    
    
}

- (void)sendPresssre:(NSNumber*)pressure wavelet:(NSArray*)waveletArray isHeartPulse:(BOOL)heartPulse{

    if (pressure) {
        self.previousPressure = pressure;
    }
    if (waveletArray.count > 0) {
        self.startSendWavelet = YES;
    }
    if (pressure && !self.startSendWavelet) {
        NSDictionary* response = @{
                                   kACTION:kACTION_ONLINE_PRESSURE_BP,
                                   kBLOOD_PRESSURE_BP:pressure,
                                   };
        [BPProfileModule sendEventToBridge:self.bridge eventNotify:EVENT_NOTIFY WithDict:response];
    }else if (waveletArray.count > 0 && self.startSendWavelet){
        NSDictionary* response = @{
                                   kACTION:kACTION_ONLINE_PULSEWAVE_BP,
                                   kBLOOD_PRESSURE_BP:self.previousPressure,
                                   kFLAG_HEARTBEAT_BP:@(heartPulse),
                                   kPULSEWAVE_BP:waveletArray
                                   };
        [BPProfileModule sendEventToBridge:self.bridge eventNotify:EVENT_NOTIFY WithDict:response];
    }
}


RCT_EXPORT_METHOD(stopMeasure:(nonnull NSString *)mac){
    
    if (!self.isMeasuring) {
        NSLog(@"error %d",401);
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:401];
        return;
    }
    if ([self getBP5WithMac:mac]!=nil) {
        __weak typeof(self) weakSelf = self;
        
        [[self getBP5WithMac:mac] stopBPMeassureSuccessBlock:^{
            
        } errorBlock:^(BPDeviceError error) {
            
            NSLog(@"error %lu",(unsigned long)error);
            [BPProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithCode:error];
            
        }];
       
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSDictionary* response = @{
                                       kACTION:kACTION_INTERRUPTED_BP,
                                       };
            [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
            weakSelf.isMeasuring = NO;
        });
    }else{
        
        NSLog(@"error %lu",(unsigned long)BPDidDisconnect);
        self.isMeasuring = NO;
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
        
    }

}

RCT_EXPORT_METHOD(getBattery:(nonnull NSString *)mac){
    
    
    if ([self getBP5WithMac:mac]!=nil) {
        __weak typeof(self) weakSelf = self;
        [[self getBP5WithMac:mac] commandEnergy:^(NSNumber *energyValue) {
            NSDictionary* response = @{
                                       kACTION:kACTION_BATTERY_BP,
                                       kBATTERY_BP:energyValue
                                       };
            [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
        } errorBlock:^(BPDeviceError error) {
            NSLog(@"error %lu",(unsigned long)error);
            [BPProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithCode:error];
        }];
        
    }else{
        
        NSLog(@"error %lu",(unsigned long)BPDidDisconnect);
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
        
    }

    
    
    
}


RCT_EXPORT_METHOD(enbleOffline:(nonnull NSString *)mac){
    
    
    if ([self getBP5WithMac:mac]!=nil) {
        __block BOOL success = YES;
        __weak typeof(self) weakSelf = self;
        [[self getBP5WithMac:mac] commandSetOffline:YES errorBlock:^(BPDeviceError error) {
            success = NO;
            [BPProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithCode:error];
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (success) {
                NSDictionary* response = @{
                                           kACTION:kACTION_ENABLE_OFFLINE_BP,
                                           };
                [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
            }
        });
        
    }else{
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
    }
    
}


RCT_EXPORT_METHOD(disableOffline:(nonnull NSString *)mac){
    
    
    if ([self getBP5WithMac:mac]!=nil) {
        __block BOOL success = YES;
        __weak typeof(self) weakSelf = self;
        [[self getBP5WithMac:mac] commandSetOffline:NO errorBlock:^(BPDeviceError error) {
            success = NO;
            [BPProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithCode:error];
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (success) {
                NSDictionary* response = @{
                                           kACTION:kACTION_DISENABLE_OFFLINE_BP,
                                           };
                [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
            }
        });
        
    }else{
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
    }


}


RCT_EXPORT_METHOD(isEnableOffline:(nonnull NSString *)mac){
    
    
    if ([self getBP5WithMac:mac]!=nil) {
        __weak typeof(self) weakSelf = self;
        [[self getBP5WithMac:mac] commandFunction:^(NSDictionary *dic) {
            NSDictionary* response = @{
                                       kACTION:kACTION_IS_ENABLE_OFFLINE,
                                       kIS_ENABLE_OFFLINE:dic[@"offlineOpen"]
                                       };
            [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
        } errorBlock:^(BPDeviceError error) {
            [BPProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithCode:error];
        }];
    }else{
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
    }

}



RCT_EXPORT_METHOD(getOfflineNum:(nonnull NSString *)mac){
    
    
    
    if ([self getBP5WithMac:mac]!=nil) {
        
        __weak typeof(self) weakSelf = self;
        
        [[self getBP5WithMac:mac] commandTransferMemoryTotalCount:^(NSNumber *count) {
            
            NSDictionary* response = @{
                                       kACTION:kACTION_HISTORICAL_NUM_BP,
                                       kHISTORICAL_NUM_BP:count
                                       };
            [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
            
        } errorBlock:^(BPDeviceError error) {
            
        }];
    }else{
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
    }
    
    

//    if ([self getBP5WithMac:mac]!=nil) {
//        __weak typeof(self) weakSelf = self;
//
//        [[self getBP5WithMac:mac] commandBatchUpload:^(NSNumber *count) {
//            NSDictionary* response = @{
//                                       kACTION:kACTION_HISTORICAL_NUM_BP,
//                                       kHISTORICAL_NUM_BP:count
//                                       };
//            [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
//
//        } progress:^(NSNumber *progressValue) {
//
//        } dataArray:^(NSArray *bachArray) {
//            NSMutableArray * historyDataArray = [NSMutableArray array];
//
//            for(NSDictionary *dataDict in bachArray)
//            {
//
//                NSDate *date = [dataDict objectForKey:@"time"];
//
//                //将时间格式转化成字符串，适配plugin和react native
//                NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
//                [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//                NSString *dateStr = [mydateFormatter stringFromDate:date];
//                NSDictionary* historyDataDict = @{
//                                                  kMEASUREMENT_DATE_BP:dateStr,
//                                                  kHIGH_BLOOD_PRESSURE_BP:dataDict[@"sys"],
//                                                  kLOW_BLOOD_PRESSURE_BP:dataDict[@"dia"],
//                                                  kPULSE_BP:dataDict[@"heartRate"],
//                                                  kMEASUREMENT_AHR_BP:dataDict[@"irregular"],
//                                                  //                                                  kMEASUREMENT_HSD_BP:dataDict[@"hsdValue"],
//                                                  kDATAID:dataDict[@"dataID"]
//                                                  };
//                [historyDataArray addObject:historyDataDict];
//
//
//            }
//
//            if (historyDataArray.count > 0) {
//                NSDictionary* deviceInfo = @{kACTION:kACTION_HISTORICAL_DATA_BP,kHISTORICAL_DATA_BP:[historyDataArray copy] };
//                [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:deviceInfo];
//            }
//
//        } errorBlock:^(BPDeviceError error) {
//             [BPProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithCode:error];
//
//        }];
//
//    }else{
//        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
//    }
}



RCT_EXPORT_METHOD(getOfflineData:(nonnull NSString *)mac){
    
    
    if ([self getBP5WithMac:mac]!=nil) {
        __weak typeof(self) weakSelf = self;
        [[self getBP5WithMac:mac] commandBatchUpload:^(NSNumber *count) {
            NSDictionary* response = @{
                                       kACTION:kACTION_HISTORICAL_NUM_BP,
                                       kHISTORICAL_NUM_BP:count
                                       };
            [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
            
        } progress:^(NSNumber *progressValue) {
            
        } dataArray:^(NSArray *bachArray) {
            NSMutableArray * historyDataArray = [NSMutableArray array];
            
            for(NSDictionary *dataDict in bachArray)
            {
                
                NSDate *date = [dataDict objectForKey:@"time"];
                
                //将时间格式转化成字符串，适配plugin和react native
                NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
                [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSString *dateStr = [mydateFormatter stringFromDate:date];
                NSDictionary* historyDataDict = @{
                                                  kMEASUREMENT_DATE_BP:dateStr,
                                                  kHIGH_BLOOD_PRESSURE_BP:dataDict[@"sys"],
                                                  kLOW_BLOOD_PRESSURE_BP:dataDict[@"dia"],
                                                  kPULSE_BP:dataDict[@"heartRate"],
                                                  kMEASUREMENT_AHR_BP:dataDict[@"irregular"],
                                                  //                                                  kMEASUREMENT_HSD_BP:dataDict[@"hsdValue"],
                                                  kDATAID:dataDict[@"dataID"]
                                                  };
                [historyDataArray addObject:historyDataDict];
                
                
            }
            
            if (historyDataArray.count > 0) {
                NSDictionary* deviceInfo = @{kACTION:kACTION_HISTORICAL_DATA_BP,kHISTORICAL_DATA_BP:[historyDataArray copy] };
                [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:deviceInfo];
            }
            
        } errorBlock:^(BPDeviceError error) {
            [BPProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithCode:error];
            
        }];
        
    }else{
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
    }

}



RCT_EXPORT_METHOD(disconnect:(nonnull NSString *)mac){
    NSLog(@"iOS doesn't support disconnect normal BT devices");
    [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:900];
    
}



@end
