//
//  BP550BTModule.m
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2016/11/23.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import "BP550BTModule.h"
#import "KN550BT.h"
#import "KN550BTController.h"
#import "BPProfileModule.h"
#import "iHealthDeviceManagerModule.h"
#import "ScanDeviceController.h"
#import "ConnectDeviceController.h"
#define EVENT_NOTIFY @"event_notify_bp550bt"

@implementation BP550BTModule

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
-(id)init
{
    if (self=[super init])
    {
        
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceConnectForKN550BT:) name:KN550BTConnectNoti object:nil];
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceDisConnectForKN550BT:) name:KN550BTDisConnectNoti object:nil];
        
        [KN550BTController shareKN550BTController];
        
    }
    return self;
}


-(KN550BT*)getDeviceWithMac:(NSString*)mac{
    
    KN550BTController *controller = [KN550BTController shareKN550BTController];
    NSArray *bpDeviceArray = [controller getAllCurrentKN550BTInstace];
    
    for(KN550BT *tempDevice in bpDeviceArray){
        if([mac isEqualToString:tempDevice.serialNumber]){
            
//            tempDevice.reactNativeFlg = @YES;
            return tempDevice;
        }
    }
    
    return nil;
}


//-(void)DeviceConnectForKN550BT:(NSNotification *)tempNoti{
//    KN550BTController *controller = [KN550BTController shareKN550BTController];
//    NSArray *BPDeviceArray = [controller getAllCurrentKN550BTInstace];
//    
//    KN550BT *bpInstance = [BPDeviceArray objectAtIndex:0];
//    NSString *mac = bpInstance.currentUUID;
//    NSDictionary *IDPSDic = [tempNoti userInfo];
//    
//    NSDictionary* deviceInfo = @{
//                                 kACTION:@"kn550bt_connected_bg",@"idps":IDPSDic };
//    [BPProfileModule sendEventToBridge:self.bridge eventNotify:EVENT_NOTIFY WithDict:response];
//    
//}
//
//-(void)DeviceDisConnectForKN550BT:(NSNotification *)tempNoti{
//    
//    NSDictionary *IDPSDic = [tempNoti userInfo];
//    NSString *mac = [IDPSDic objectForKey:@"SerialNumber"];
//    
//    NSDictionary* deviceInfo = @{@"mac":mac,@"action":@"kn550bt_disconnected_bg",@"idps":IDPSDic};
//    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
//    
//}


#pragma mark-获取连接设备
RCT_EXPORT_METHOD(getAllConnectedDevices){
    
    
    NSArray*bp550array= [[KN550BTController shareKN550BTController] getAllCurrentKN550BTInstace];
    
    NSMutableArray*deviceMacArray=[NSMutableArray array];
    
    for (int i=0; i<[bp550array count]; i++) {
        
        KN550BT*kn550bt=[bp550array objectAtIndex:i];
        
        [deviceMacArray addObject:kn550bt.serialNumber];
        
    }
    
    NSDictionary* deviceInfo = @{@"action":@"ACTION_GET_ALL_CONNECTED_DEVICES",@"devices":deviceMacArray};
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
    
    
}




#pragma mark - Method

RCT_EXPORT_METHOD(getFunctionInfo:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        __weak typeof(self) weakSelf = self;
        [[self getDeviceWithMac:mac] commandFunction:^(NSDictionary *dic) {
           
            NSDictionary* response = @{
                                       kACTION:kACTION_FUNCTION_INFORMATION_BP,
                                       kFUNCTION_IS_UPAIR_MEASURE: [dic objectForKey:@"upAirMeasureFlg"],
                                       kFUNCTION_IS_ARM_MEASURE: [dic objectForKey:@"armMeasureFlg"],
                                       kFUNCTION_HAVE_ANGLE_SENSOR: [dic objectForKey:@"haveAngleSensor"],
                                       kFUNCTION_HAVE_OFFLINE: [dic objectForKey:@"haveOffline"],
                                       kFUNCTION_HAVE_HSD: [dic objectForKey:@"haveHSD"],
                                       kFUNCTION_HAVE_ANGLE_SETTING: [dic objectForKey:@"haveAngleSet"],
                                       kFUNCTION_IS_MULTI_UPLOAD: [dic objectForKey:@"mutableUpload"],
                                       kFUNCTION_HAVE_SELF_UPDATE: [dic objectForKey: @"selfUpdate"],
                                       kType:@"KN550",
                                       kMAC:mac
                                       };
            [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
            
        } errorBlock:^(BPDeviceError error) {
            
            [BPProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithCode:error];
            
        }];
    }else{
        
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
        
    }
    
    
}

RCT_EXPORT_METHOD(getBattery:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        __weak typeof(self) weakSelf = self;
        [[self getDeviceWithMac:mac] commandEnergy:^(NSNumber *energyValue) {
            
            NSDictionary* response = @{
                                         kACTION:kACTION_BATTERY_BP,
                                         kBATTERY_BP:energyValue,
                                         kType:@"KN550",
                                         kMAC:mac
                                         };
            [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
            NSLog(@"%@",response);
            
        } errorBlock:^(BPDeviceError error) {
            
            [BPProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithCode:error];
            
        }];
        
    }else{
        
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
    }
    
    
}

RCT_EXPORT_METHOD(getOffLineNum:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        __weak typeof(self) weakSelf = self;
        [[self getDeviceWithMac:mac]commandTransferMemoryTotalCount:^(NSNumber *num) {
            
            NSDictionary* response = @{
                                         kACTION:kACTION_HISTORICAL_NUM_BP,
                                         kHISTORICAL_NUM_BP:num,
                                         kType:@"KN550",
                                         kMAC:mac
                                         };
            [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
            
        } errorBlock:^(BPDeviceError error) {
            
            [BPProfileModule sendErrorToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithCode:error];
            
        }];
         
         }else{
             [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
             
    }
    
    
}

RCT_EXPORT_METHOD(getOffLineData:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        __weak typeof(self) weakSelf = self;
        
        [[self getDeviceWithMac:mac] commandTransferMemoryDataWithTotalCount:^(NSNumber *count) {
            if ([count integerValue] == 0) {
                NSDictionary* response = @{kACTION:kACTION_HISTORICAL_DATA_BP };
                [BPProfileModule sendEventToBridge:weakSelf.bridge eventNotify:EVENT_NOTIFY WithDict:response];
            }
        } progress:^(NSNumber *progress) {
            
        } dataArray:^(NSArray *array) {
            NSMutableArray * tempArr = [[NSMutableArray alloc]init];
            
            for(NSDictionary *history in array)
            {
                NSDate *tempDate = [history objectForKey:@"time"];
                
                //将时间格式转化成字符串，适配plugin和react native【
                NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
                [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSString *dateStr = [mydateFormatter stringFromDate:tempDate];
                
                NSNumber*bpHSD=[history valueForKey:@"hsdValue"];
                NSDictionary *dic=[NSDictionary dictionary];
                if (bpHSD!=nil) {
                    dic = @{
                                          kMEASUREMENT_DATE_BP: dateStr,
                                          kLOW_BLOOD_PRESSURE_BP: [history objectForKey:@"dia"],
                                          kHIGH_BLOOD_PRESSURE_BP: [history objectForKey:@"sys"],
                                          kMEASUREMENT_AHR_BP: [history objectForKey:@"irregular"],
                                          kPULSE_BP: [history objectForKey:@"heartRate"],
                                          kDATAID: [history objectForKey:@"dataID"],
                                          kMEASUREMENT_HSD_BP: history[@"hsdValue"],
                                          kType:@"KN550",
                                          kMAC:mac
                                          };
                }else{
                    
                    
                   dic = @{
                                          kMEASUREMENT_DATE_BP: dateStr,
                                          kLOW_BLOOD_PRESSURE_BP: [history objectForKey:@"dia"],
                                          kHIGH_BLOOD_PRESSURE_BP: [history objectForKey:@"sys"],
                                          kMEASUREMENT_AHR_BP: [history objectForKey:@"irregular"],
                                          kPULSE_BP: [history objectForKey:@"heartRate"],
                                          kDATAID: [history objectForKey:@"dataID"],
                                          kType:@"KN550",
                                          kMAC:mac
                                          
                                          };
                }
                
                
                
                [tempArr addObject:dic];
                
            }
            
            if (tempArr.count > 0) {
                NSDictionary* response = @{
                                           kACTION:kACTION_HISTORICAL_DATA_BP,
                                           kHISTORICAL_DATA_BP:[tempArr copy],
                                           kType:@"KN550",
                                           kMAC:mac
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

RCT_EXPORT_METHOD(disconnect:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        
        [[self getDeviceWithMac:mac] commandDisconnectDevice];
        
    }else{
      
        [BPProfileModule sendErrorToBridge:self.bridge eventNotify:EVENT_NOTIFY WithCode:BPDidDisconnect];
    
    }
    
    
}


@end
