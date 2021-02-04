//
//  BP7SModule.m
//  ReactNativeIOSLibrary
//
//  Created by Liu Yanbo on 2016/12/05.
//  Copyright © 2016年 Liu Yanbo. All rights reserved.
//

#import "BP7SModule.h"
#import "BPProfileModule.h"
#import "BPMacroFile.h"
#import "BP7SController.h"
#import "BP7S.h"
#import "iHealthDeviceManagerModule.h"
#import "ScanDeviceController.h"
#import "ConnectDeviceController.h"
#define EVENT_NOTIFY @"BP7S.MODULE.NOTIFY"

@implementation BP7SModule
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
-(BP7S*)getDeviceWithMac:(NSString*)mac{
    
    BP7SController *controller = [BP7SController shareBP7SController];
    NSArray *bpDeviceArray = [controller getAllCurrentBP7SInstace];
    
    for(BP7S *tempDevice in bpDeviceArray){
        if([mac isEqualToString:tempDevice.serialNumber]){
            
            return tempDevice;
        }
    }
    
    return nil;
}

#pragma mark-获取连接设备
RCT_EXPORT_METHOD(getAllConnectedDevices){
    
    
    NSArray*bp7Sarray= [[BP7SController shareBP7SController] getAllCurrentBP7SInstace];
    
    NSMutableArray*deviceMacArray=[NSMutableArray array];
    
    for (int i=0; i<[bp7Sarray count]; i++) {
        
        BP7S*bp7s=[bp7Sarray objectAtIndex:i];
        
        [deviceMacArray addObject:bp7s.serialNumber];
        
    }
    
    NSDictionary* deviceInfo = @{@"action":@"ACTION_GET_ALL_CONNECTED_DEVICES",@"devices":deviceMacArray};
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
    
    
}



#pragma mark - Method

RCT_EXPORT_METHOD(getFunctionInfo:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        
        
        [[self getDeviceWithMac:mac] commandFunction:^(NSDictionary *dic) {
            
            NSDictionary* response = @{
                                       kACTION:kACTION_FUNCTION_INFORMATION_BP,
                                       kFUNCTION_IS_UPAIR_MEASURE:dic[@"upAirMeasureFlg"],
                                       kFUNCTION_IS_ARM_MEASURE:dic[@"armMeasureFlg"],
                                       kFUNCTION_HAVE_ANGLE_SENSOR:dic[@"haveAngleSensor"],
                                       kFUNCTION_HAVE_OFFLINE:dic[@"haveOffline"],
                                       kFUNCTION_HAVE_ANGLE_SETTING:dic[@"haveAngleSet"],
                                       kFUNCTION_IS_MULTI_UPLOAD:dic[@"mutableUpload"],
                                       kFUNCTION_HAVE_SELF_UPDATE:dic[@"selfUpdate"],
                                       kFUNCTION_HAVE_HSD:dic[@"haveHSD"]
                                       };
            [BPProfileModule sendEventToBridge:self.bridge eventNotify:EVENT_NOTIFY WithDict:response];
        } errorBlock:^(BPDeviceError error) {
            [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:error];
        }];
    }else{
        NSLog(@"error %d",BPDidDisconnect);
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
    }
    
    
}

//getOffLineNum
RCT_EXPORT_METHOD(getOffLineNum:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        
        [[self getDeviceWithMac:mac] commandTransferMemoryTotalCount:^(NSNumber *count) {
            NSDictionary* response = @{
                                       kACTION:kACTION_HISTORICAL_NUM_BP,
                                       kHISTORICAL_NUM_BP:count,
                                       };
            [BPProfileModule sendEventToBridge:self.bridge eventNotify:EVENT_NOTIFY WithDict:response];
        } errorBlock:^(BPDeviceError error) {
            [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:error];
        }];
    }else{
        NSLog(@"error %d",BPDidDisconnect);
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
    }
    
    
}

//getOffLineData
RCT_EXPORT_METHOD(getOffLineData:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        [[self getDeviceWithMac:mac] commandTransferMemoryDataWithTotalCount:^(NSNumber *count) {
            if (count.integerValue == 0) {
                NSDictionary* response = @{
                                           kACTION:kACTION_HISTORICAL_DATA_BP,
                                           };
                [BPProfileModule sendEventToBridge:self.bridge eventNotify:EVENT_NOTIFY WithDict:response];
            }
        } progress:^(NSNumber *progress) {
            NSLog(@"pregress %@",progress);
        } dataArray:^(NSArray *array) {
            NSLog(@"dataArray %@",array);
            NSMutableArray* historyDataArray = [NSMutableArray array];
            for (NSDictionary* dataDict in array) {
                if ([dataDict isKindOfClass:[NSDictionary class]]) {
                    NSDate *tempDate = [dataDict objectForKey:@"time"];
                    
                    //将时间格式转化成字符串，适配plugin和react native
                    NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
                    [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSString *dateStr = [mydateFormatter stringFromDate:tempDate];
                    NSDictionary* historyDataDict = @{
                                                      kMEASUREMENT_DATE_BP:dateStr,
                                                      kHIGH_BLOOD_PRESSURE_BP:dataDict[@"sys"],
                                                      kLOW_BLOOD_PRESSURE_BP:dataDict[@"dia"],
                                                      kPULSE_BP:dataDict[@"heartRate"],
                                                      kMEASUREMENT_AHR_BP:dataDict[@"irregular"],
                                                      kMEASUREMENT_HSD_BP:dataDict[@"hsdValue"],
                                                      kMEASUREMENT_STRAT_ANGLE_BP: dataDict[@"startAngle"],
                                                      kMEASUREMENT_ANGLE_CHANGE_BP:dataDict[@"measureAngleChange"],
                                                      kMEASUREMENT_HAND_BP:dataDict[@"chooseHand"],
                                                      kDATAID:dataDict[@"dataID"]
                                                      };
                    [historyDataArray addObject:historyDataDict];
                }
            }
            if (historyDataArray.count > 0) {
                NSDictionary* response = @{
                                           kACTION:kACTION_HISTORICAL_DATA_BP,
                                           kHISTORICAL_DATA_BP:[historyDataArray copy]
                                           };
                [BPProfileModule sendEventToBridge:self.bridge eventNotify:EVENT_NOTIFY WithDict:response];
            }
        } errorBlock:^(BPDeviceError error) {
            NSLog(@"error %d",error);
            [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:error];
        }];

    }else{
        NSLog(@"error %d",BPDidDisconnect);
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
    }
    
    
}
//getBattery
RCT_EXPORT_METHOD(getBattery:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        [[self getDeviceWithMac:mac] commandEnergy:^(NSNumber *energyValue) {
            NSLog(@"energyValue %@",energyValue);
            NSDictionary* response = @{
                                       kACTION:kACTION_BATTERY_BP,
                                       kBATTERY_BP:energyValue,
                                       };
            [BPProfileModule sendEventToBridge:self.bridge eventNotify:EVENT_NOTIFY WithDict:response];
        } errorBlock:^(BPDeviceError error) {
            NSLog(@"error %d",error);
            [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:error];
        }];
    }else{
        NSLog(@"error %d",BPDidDisconnect);
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
    }
    
    
}
//setUnit
RCT_EXPORT_METHOD(setUnit:(nonnull NSString *)mac unit:(nonnull NSNumber*)unit){
    
    if ([unit integerValue] > 1 || [unit integerValue] < 0)  {
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPInputParameterError];
        return;
    }
    
    if ([self getDeviceWithMac:mac]!=nil) {
        [[self getDeviceWithMac:mac] commandSetUnit:[unit integerValue] > 0 ? @"kPa" : @"mmHg" disposeSetReslut:^{
            NSLog(@"set unit success");
            NSDictionary* response = @{
                                       kACTION:kACTION_SET_UNIT_SUCCESS_BP,
                                       };
            [BPProfileModule sendEventToBridge:self.bridge eventNotify:EVENT_NOTIFY WithDict:response];
        } errorBlock:^(BPDeviceError error) {
            NSLog(@"error %d",error);
            [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:error];
        }];
    }else{
        NSLog(@"error %d",BPDidDisconnect);
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
    }
    
    
}
//angleSet
RCT_EXPORT_METHOD(angleSet:(nonnull NSString *)mac hl:(nonnull NSNumber*)hl ll:(nonnull NSNumber*)ll hr:(nonnull NSNumber*)hr lr:(nonnull NSNumber*)lr){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        NSDictionary* dict = @{
                               @"highAngleForLeft":hl,
                                @"lowAngleForLeft":ll,
                               @"highAngleForRight":hr,
                               @"lowAngleForRight":lr
                               };

        [[self getDeviceWithMac:mac] commandSetAngle:dict disposeSetReslut:^{
            NSDictionary* response = @{
                                       kACTION:kACTION_SET_ANGLE_SUCCESS_BP,
                                       };
            [BPProfileModule sendEventToBridge:self.bridge eventNotify:EVENT_NOTIFY WithDict:response];
        } errorBlock:^(BPDeviceError error) {
            NSLog(@"error %d",error);
            [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:error];
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
