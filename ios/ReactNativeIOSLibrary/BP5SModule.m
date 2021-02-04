//
//  BP5SModule.m
//  ReactNativeIOSLibrary
//
//  Created by soso on 2019/4/17.
//  Copyright © 2019 daiqingquan. All rights reserved.
//

#import "BP5SModule.h"

#import "BPProfileModule.h"
#import "BPMacroFile.h"
#import "BP5SController.h"
#import "BP5S.h"
#import "iHealthDeviceManagerModule.h"

#import "ScanDeviceController.h"
#import "ConnectDeviceController.h"
#define EVENT_NOTIFY @"BP5S.MODULE.NOTIFY"

@interface BP5SModule ()
@property (nonatomic, assign) BOOL isMeasuring;

@end


@implementation BP5SModule
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

-(BP5S*)getDeviceWithMac:(NSString*)mac{
    
    BP5SController *controller = [BP5SController sharedController];
    NSArray *bpDeviceArray = [controller getAllCurrentInstance];
    
    for(BP5S *tempDevice in bpDeviceArray){
        if([mac isEqualToString:tempDevice.serialNumber]){
            
            return tempDevice;
        }
    }
    
    return nil;
}


#pragma mark - Method


#pragma mark-获取连接设备
RCT_EXPORT_METHOD(getAllConnectedDevices){
    
    
    NSArray *bp5sArray= [[BP5SController sharedController] getAllCurrentInstance];
    
    NSMutableArray *deviceMacArray = [NSMutableArray array];
    
    for (int i=0; i<[bp5sArray count]; i++) {
        
        BP5S *bp5s=[bp5sArray objectAtIndex:i];
        
        [deviceMacArray addObject:bp5s.serialNumber];
        
    }
    
    NSDictionary* deviceInfo = @{@"action":@"ACTION_GET_ALL_CONNECTED_DEVICES",@"devices":deviceMacArray};
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
    
}


//开始测量
RCT_EXPORT_METHOD(startMeasure:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        __weak typeof(self) weakSelf = self;
        
        [[self getDeviceWithMac:mac] commandStartMeasureWithZeroingState:^(BOOL isComplete) {
            weakSelf.isMeasuring = YES;
            NSDictionary* response = @{
                                       @"mac":mac,
                                       kACTION:isComplete ? kACTION_ZOREING_BP : kACTION_ZOREOVER_BP,
                                       };
            [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
        } pressure:^(NSArray *pressureArr) {
            weakSelf.isMeasuring = YES;
            NSLog(@"pressure %@",pressureArr);
            NSDictionary* response = @{
                                       @"mac":mac,
                                       kACTION:kACTION_ONLINE_PRESSURE_BP,
                                       kBLOOD_PRESSURE_BP:pressureArr.firstObject,
                                       };
            [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
        } waveletWithHeartbeat:^(NSArray *waveletArr) {
            weakSelf.isMeasuring = YES;
            NSLog(@"xiaoboWithHeart %@",waveletArr);
            NSDictionary* response = @{
                                       @"mac":mac,
                                       kACTION:kACTION_ONLINE_PULSEWAVE_BP,
                                       kFLAG_HEARTBEAT_BP:@(1),
                                       kPULSEWAVE_BP:waveletArr
                                       };
            [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
        } waveletWithoutHeartbeat:^(NSArray *waveletArr) {
            weakSelf.isMeasuring = YES;
            NSLog(@"xiaoboNoHeart %@",waveletArr);
            NSDictionary* response = @{
                                       @"mac":mac,
                                       kACTION:kACTION_ONLINE_PULSEWAVE_BP,
                                       kFLAG_HEARTBEAT_BP:@(0),
                                       kPULSEWAVE_BP:waveletArr
                                       };
            [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
        } result:^(NSDictionary *resultDict) {
            weakSelf.isMeasuring = NO;
            NSLog(@"result %@",resultDict);
            NSDictionary* response = @{
                                       @"mac":mac,
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
            NSLog(@"error %lu",(unsigned long)error);
            [BPProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithCode:error];
        }];
        
    }else{
        self.isMeasuring = NO;
        NSLog(@"error %lu",(unsigned long)BPDidDisconnect);
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
    }
}

//停止测量
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
                                       @"mac":mac,
                                       kACTION:kACTION_INTERRUPTED_BP,
                                       };
            [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
            
        } errorBlock:^(BPDeviceError error) {
            
            NSLog(@"error %lu",(unsigned long)error);
            weakSelf.isMeasuring = NO;
            [BPProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithCode:error];
        }];
        
        
    }else{
        weakSelf.isMeasuring = NO;
        NSLog(@"error %lu",(unsigned long)BPDidDisconnect);
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
    }
    
    
}

//删除功能
RCT_EXPORT_METHOD(deleteData:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        __weak typeof(self) weakSelf = self;
        [[self getDeviceWithMac:mac] commandDeleteDataSuccessBlock:^{
            NSDictionary* response = @{
                                       @"mac":mac,
                                       kACTION:kACTION_Delete_BP,
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

//设置离线功能
RCT_EXPORT_METHOD(enbleOffline:(nonnull NSString *)mac mode:(nonnull NSNumber *)mode){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        __block BOOL success = YES;
        __weak typeof(self) weakSelf = self;
        
        BOOL flag;
        
        if ([mode boolValue] == YES) {
            flag = YES;
        }else{
            flag = NO;
        }
        
        [[self getDeviceWithMac:mac] commandSetOffline:flag success:^{
            
            if (flag == YES) {
                NSDictionary* response = @{
                                           @"mac":mac,
                                           kACTION:kACTION_ENABLE_OFFLINE_BP,
                                           };
                [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
            }else{
                NSDictionary* response = @{
                                           @"mac":mac,
                                           kACTION:kACTION_DISENABLE_OFFLINE_BP,
                                           };
                [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
            }
            
        } error:^(BPDeviceError error) {
            success = NO;
            [BPProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithCode:error];
        }];
    }else{
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
    }
}


//查电量
RCT_EXPORT_METHOD(getBattery:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        __weak typeof(self) weakSelf = self;
        [[self getDeviceWithMac:mac] commandEnergy:^(NSNumber *energyValue) {
            NSDictionary* response = @{
                                       @"mac":mac,
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

//查数据数量
RCT_EXPORT_METHOD(getOffLineNum:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        __weak typeof(self) weakSelf = self;
        [[self getDeviceWithMac:mac]commandTransferMemoryTotalCount:^(NSNumber *num) {
            
            NSDictionary* response = @{
                                       @"mac":mac,
                                       kACTION:kACTION_HISTORICAL_NUM_BP,
                                       kHISTORICAL_NUM_BP:num
                                       };
            [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
            
        } errorBlock:^(BPDeviceError error) {
            
            [BPProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithCode:error];
            
        }];
        
    }else{
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
    }
}


//查离线数据
RCT_EXPORT_METHOD(getOffLineData:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        __weak typeof(self) weakSelf = self;
        
        [[self getDeviceWithMac:mac] commandTransferMemoryDataWithTotalCount:^(NSNumber *count) {
            if ([count integerValue] == 0) {
                NSDictionary* response = @{@"mac":mac,kACTION:kACTION_HISTORICAL_DATA_BP };
                [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
            }
        } progress:^(NSNumber *progress) {
            
        } dataArray:^(NSArray *array) {
            NSMutableArray * tempArr = [[NSMutableArray alloc]init];
            
            for(NSDictionary *history in array)
            {
                
                NSNumber *dateNum = [history objectForKey:@"time"];

                NSDate *tempDate = [NSDate dateWithTimeIntervalSince1970:[dateNum integerValue]];                
                //将时间格式转化成字符串，适配plugin和react native
                NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
                [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSString *dateStr = [mydateFormatter stringFromDate:tempDate];
                
                NSNumber*bpHSD=[history valueForKey:@"hsdValue"];
                NSDictionary *dic=[NSDictionary dictionary];
                if (bpHSD!=nil) {
                    dic = @{
                            @"mac":mac,
                            kMEASUREMENT_DATE_BP: dateStr,
                            kLOW_BLOOD_PRESSURE_BP: [history objectForKey:@"dia"],
                            kHIGH_BLOOD_PRESSURE_BP: [history objectForKey:@"sys"],
                            kMEASUREMENT_AHR_BP: [history objectForKey:@"irregular"],
                            kPULSE_BP: [history objectForKey:@"heartRate"],
                            kDATAID: [history objectForKey:@"dataID"],
                            kMEASUREMENT_HSD_BP: history[@"hsdValue"]
                            };
                }else{
                    
                    
                    dic = @{
                            @"mac":mac,
                            kMEASUREMENT_DATE_BP: dateStr,
                            kLOW_BLOOD_PRESSURE_BP: [history objectForKey:@"dia"],
                            kHIGH_BLOOD_PRESSURE_BP: [history objectForKey:@"sys"],
                            kMEASUREMENT_AHR_BP: [history objectForKey:@"irregular"],
                            kPULSE_BP: [history objectForKey:@"heartRate"],
                            kDATAID: [history objectForKey:@"dataID"]
                            
                            };
                }
                [tempArr addObject:dic];
            }
            
            if (tempArr.count > 0) {
                NSDictionary* response = @{
                                           @"mac":mac,
                                           kACTION:kACTION_HISTORICAL_DATA_BP,
                                           kHISTORICAL_DATA_BP:[tempArr copy]
                                           };
                [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
            }
            
        } errorBlock:^(BPDeviceError error) {
            [BPProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithCode:error];
        }];
        
    }else{
        
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
    }
    
    
}

//查询功能
RCT_EXPORT_METHOD(getFunctionInfo:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        __weak typeof(self) weakSelf = self;
        [[self getDeviceWithMac:mac] commandFunction:^(NSDictionary *dic) {
            
            NSDictionary* response = @{
                                       @"mac":mac,
                                       kACTION:kACTION_FUNCTION_INFORMATION_BP,
                                       kFUNCTION_IS_UPAIR_MEASURE: [dic objectForKey:@"upAirMeasureFlg"],
                                       kFUNCTION_IS_ARM_MEASURE: [dic objectForKey:@"armMeasureFlg"],
                                       kFUNCTION_HAVE_ANGLE_SENSOR: [dic objectForKey:@"haveAngleSensor"],
                                       kFUNCTION_HAVE_OFFLINE: [dic objectForKey:@"haveOffline"],
                                       kFUNCTION_HAVE_HSD: [dic objectForKey:@"haveHSD"],
                                       kFUNCTION_IS_MULTI_UPLOAD: [dic objectForKey:@"mutableUpload"],
                                       kFUNCTION_HAVE_SELF_UPDATE: [dic objectForKey: @"selfUpdate"]};
            [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
            
        } errorBlock:^(BPDeviceError error) {
            
            [BPProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithCode:error];
            
        }];
    }else{
        
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
    }
}

//离线数据
RCT_EXPORT_METHOD(disconnect:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        [[self getDeviceWithMac:mac] commandDisconnectDevice];
    }else{
        NSLog(@"error %lu",(unsigned long)BPDidDisconnect);
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
    }
}



@end
