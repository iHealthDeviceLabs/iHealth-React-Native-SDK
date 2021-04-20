//
//  BG5SModule.m
//  ReactNativeIOSLibrary
//
//  Created by soso on 2019/4/24.
//  Copyright © 2019 daiqingquan. All rights reserved.
//

#import "BG5SModule.h"

#import "BG5SProfileModule.h"
#import "BGMacroFile.h"
#import "BG5SController.h"
#import "BG5S.h"
#import "ManageDeviceController.h"


#define EVENT_NOTIFY    @"event_notify_bg5s"
#define kMAC_KEY        @"mac"
#define kACTION_KEY     @"action"

#define kFUNCTION_BatteryValue @"batteryValue"
#define kFUNCTION_DeviceDate @"deviceDate"
#define kFUNCTION_DeviceTimeZone @"deviceTimeZone"
#define kFUNCTION_StripUsedValue @"stripUsedValue"
#define kFUNCTION_OfflineDataQuantity @"offlineDataQuantity"
#define kFUNCTION_BloodCodeVersion @"bloodCodeVersion"
#define kFUNCTION_CtlCodeVersion @"ctlCodeVersion"
#define kFUNCTION_Unit @"unit"


@interface BG5SModule ()<BG5SDelegate>
@property (nonatomic, assign) BOOL isMeasuring;

@end
@implementation BG5SModule
@synthesize bridge = _bridge;
RCT_EXPORT_MODULE()

- (NSDictionary *)constantsToExport
{
    return @{ @"Event_Notify": EVENT_NOTIFY };
}

+ (BOOL)requiresMainQueueSetup 
{
    return YES;
}


-(BG5S*)getDeviceWithMac:(NSString*)mac{
    
    BG5SController *controller = [BG5SController sharedController];
    NSArray *bgDeviceArray = [controller getAllCurrentInstace];
    
    for(BG5S *tempDevice in bgDeviceArray){
        if([mac isEqualToString:tempDevice.serialNumber]){
            tempDevice.delegate = self;
            return tempDevice;
        }
    }
    return nil;
}

RCT_EXPORT_METHOD(getAllConnectedDevices){
    
    
    NSArray*bgDeviceArray= [[BG5SController sharedController] getAllCurrentInstace];
    
    NSMutableArray*deviceMacArray=[NSMutableArray array];
    
    for (int i=0; i<[bgDeviceArray count]; i++) {
        
        BG5S *bg5s = [bgDeviceArray objectAtIndex:i];
        
        [deviceMacArray addObject:bg5s.serialNumber];
        
    }
    
    NSDictionary* deviceInfo = @{kACTION_KEY:@"ACTION_GET_ALL_CONNECTED_DEVICES",@"devices":deviceMacArray};
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
}


//综合查询
RCT_EXPORT_METHOD(getStatusInfo:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        __weak typeof(self) weakSelf = self;
        [[self getDeviceWithMac:mac] queryStateInfoWithSuccess:^(BG5SStateInfo *stateInfo) {
            
            
            NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
            [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *dateStr = [mydateFormatter stringFromDate:stateInfo.deviceDate];
            
            NSDictionary* response = @{
                                       kMAC_KEY:mac,
                                       kACTION_KEY:kACTION_GET_STATUS_INFO,
                                       INFO_BATTERY_LEVEL:@(stateInfo.batteryValue),
                                       INFO_TIME:dateStr,
                                       INFO_TIMEZONE:@(stateInfo.deviceTimeZone),
                                       INFO_USED_STRIP:@(stateInfo.stripUsedValue),
                                       INFO_OFFLINE_DATA_NUM:@(stateInfo.offlineDataQuantity),
                                       INFO_CODE_VERSION_BLOOD:@(stateInfo.bloodCodeVersion),
                                       INFO_CODE_VERSION_CTL:@(stateInfo.ctlCodeVersion),
                                       INFO_UNIT:(stateInfo.unit == BGUnit_mmolPL)?@"mmol":((stateInfo.unit == BGUnit_mgPmL)?@"mg":@"unknown"),
                                       };
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:response];
            
            
        } errorBlock:^(BG5SError error, NSString *detailInfo) {
            [weakSelf sendMeasureErrorEventWithMac:mac errorId:error];
        }];
    }else{
        [self sendNoMatchedDeviceEventWithMac:mac];
    }
}

//同步时间
RCT_EXPORT_METHOD(setTime:(nonnull NSString *)mac date:(nonnull NSString *)date timezone:(nonnull NSNumber *)timezone){
    if ([self getDeviceWithMac:mac]) {
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
               
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
               
        NSDate*mydate=[dateFormatter dateFromString:date];


        __weak typeof(self) weakSelf = self;
        [[self getDeviceWithMac:mac] setTimeWithDate:mydate timezone:[timezone floatValue] successBlock:^{
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                                         kMAC_KEY:mac,
                                                                                         kACTION_KEY:kACTION_SET_TIME,
                                                                                         }];
        } errorBlock:^(BG5SError error, NSString *detailInfo) {
            [weakSelf sendMeasureErrorEventWithMac:mac errorId:error];
        }];
    }else{
        [self sendNoMatchedDeviceEventWithMac:mac];
    }
}

////同步时间
//RCT_EXPORT_METHOD(setTime:(nonnull NSString *)mac){
//    if ([self getDeviceWithMac:mac]) {
//
//        __weak typeof(self) weakSelf = self;
//
//        NSString *zone = [[NSTimeZone systemTimeZone] description];
//        NSString *time = [[zone componentsSeparatedByString:@"offset "] objectAtIndex:1];
//        float floatTimeZone = time.floatValue/3600;
//
//        [[self getDeviceWithMac:mac] setTimeWithDate:[NSDate date] timezone:floatTimeZone successBlock:^{
//            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
//                                                                                         kMAC_KEY:mac,
//                                                                                         kACTION_KEY:kACTION_SET_TIME,
//                                                                                         }];
//        } errorBlock:^(BG5SError error, NSString *detailInfo) {
//            [weakSelf sendMeasureErrorEventWithMac:mac errorId:error];
//        }];
//    }else{
//        [self sendNoMatchedDeviceEventWithMac:mac];
//    }
//}

//设置单位
RCT_EXPORT_METHOD(setUnit:(nonnull NSString *)mac type:(nonnull NSNumber *)type){
    if ([self getDeviceWithMac:mac]) {
        
        BGUnit tempUnit = BGUnit_mmolPL;
        if ([type isEqual:@(BGUnit_mmolPL)]) {
            tempUnit = BGUnit_mmolPL;
        } else if([type isEqual:@(BGUnit_mgPmL)]) {
            tempUnit = BGUnit_mgPmL;
        } else {
            [self sendNoMatchedDeviceEventWithMac:mac];
            return;
        }
        __weak typeof(self) weakSelf = self;
        
        [[self getDeviceWithMac:mac] setUnit:tempUnit successBlock:^{
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                                         kMAC_KEY:mac,
                                                                                         kACTION_KEY:kACTION_SET_UNIT,
                                                                                         }];
        } errorBlock:^(BG5SError error, NSString *detailInfo) {
            [weakSelf sendMeasureErrorEventWithMac:mac errorId:error];
            
        }];
        
    }else{
        [self sendNoMatchedDeviceEventWithMac:mac];
    }
}

//设置离线模式  Is offline measurement allowed    0:allowed  1:Offline measurement is not allowed
RCT_EXPORT_METHOD(setOfflineModel:(nonnull NSString *)mac type:(nonnull NSNumber *)type){
    if ([self getDeviceWithMac:mac]) {
        
        BOOL modelType=YES;
        
        if ([type intValue]==0) {
            modelType=NO;
        }else{
            
            modelType=YES;
        }
        
        
        __weak typeof(self) weakSelf = self;
        
        
        [[self getDeviceWithMac:mac] setIsOfflineMeasurementAllowed:modelType successBlock:^{
             [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                                                    kMAC_KEY:mac,
                                                                                                    kACTION_KEY:kACTION_SET_OFFINEMODEL,
                                                                                                    }];
        } errorBlock:^(BG5SError error, NSString *detailInfo) {
            
             [weakSelf sendMeasureErrorEventWithMac:mac errorId:error];
        }];
        
    }else{
        [self sendNoMatchedDeviceEventWithMac:mac];
    }
}


//删除试条使用条数
RCT_EXPORT_METHOD(deleteUsedStrip:(nonnull NSString *)mac){
    if ([self getDeviceWithMac:mac]) {
        __weak typeof(self) weakSelf = self;
        [[self getDeviceWithMac:mac] deleteStripUsedInfoWithSuccessBlock:^{
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                                     kMAC_KEY:mac,
                                                                                     kACTION_KEY:kACTION_DELETE_USED_STRIP,
                                                                                     }];
        } errorBlock:^(BG5SError error, NSString *detailInfo) {
            [weakSelf sendMeasureErrorEventWithMac:mac errorId:error];
        }];
    }else{
        [self sendNoMatchedDeviceEventWithMac:mac];
    }
}

//删除离线数据
RCT_EXPORT_METHOD(deleteOfflineData:(nonnull NSString *)mac){
    if ([self getDeviceWithMac:mac]) {
        __weak typeof(self) weakSelf = self;
        [[self getDeviceWithMac:mac] deleteRecordWithSuccessBlock:^{
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                                     kMAC_KEY:mac,
                                                                                     kACTION_KEY:kACTION_DELETE_OFFLINE_DATA,
                                                                                     }];
        } errorBlock:^(BG5SError error, NSString *detailInfo) {
            [weakSelf sendMeasureErrorEventWithMac:mac errorId:error];
            
        }];
    }else{
        [self sendNoMatchedDeviceEventWithMac:mac];
    }
}


//同步离线数据
RCT_EXPORT_METHOD(getOfflineData:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]) {
        __weak typeof(self) weakSelf = self;
        [[self getDeviceWithMac:mac] queryRecordWithSuccessBlock:^(NSArray *array) {
            
            NSMutableArray * tempArr = [[NSMutableArray alloc]init];
            
            for(BG5SRecordModel *model in array) {
                NSDate *tempDate = model.measureDate;
                BOOL flag = model.canCorrect;
                
                //将时间格式转化成字符串，适配plugin和react native
                NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
                [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSString *dateStr = [mydateFormatter stringFromDate:tempDate];
                
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dateStr,@"data_measure_time",@(model.value),@"data_value",model.dataID,@"dataID",@(model.timeZone),@"data_measure_timezone",flag,@"data_time_proof", nil];
                
                [tempArr addObject:dic];
            }
            
            NSDictionary*hisDic=[NSDictionary dictionaryWithObjectsAndKeys:tempArr,@"history", nil];
            
            
            NSDictionary *deviceInfo = @{@"mac":mac,@"action":kACTION_GET_OFFLINE_DATA,kGET_OFFLINEDATA:hisDic,@"type":@"BG5S"};
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } errorBlock:^(BG5SError error, NSString *detailInfo) {
            [weakSelf sendMeasureErrorEventWithMac:mac errorId:error];
        }];
    }else{
        [self sendNoMatchedDeviceEventWithMac:mac];
        
    }
}


//开始测量
RCT_EXPORT_METHOD(startMeasure:(nonnull NSString *)mac type:(nonnull NSNumber *)type){
    if ([self getDeviceWithMac:mac]) {
        __weak typeof(self) weakSelf = self;
        
        BGMeasureMode measureMode = BGMeasureMode_Blood;
        if ([type isEqual:@(BGMeasureMode_Blood)]) {
            measureMode = BGMeasureMode_Blood;
        } else if([type isEqual:@(BGMeasureMode_NoBlood)]) {
            measureMode = BGMeasureMode_NoBlood;
        } else {
            [self sendNoMatchedDeviceEventWithMac:mac];
            return;
        }
        
        [[self getDeviceWithMac:mac] startMeasure:measureMode withSuccessBlock:^{
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                                     kMAC_KEY:mac,
                                                                                     kACTION_KEY:kACTION_START_MEASURE,
                                                                                     }];
        } errorBlock:^(BG5SError error, NSString *detailInfo) {
            [weakSelf sendMeasureErrorEventWithMac:mac errorId:error];

        }];
    }else{
        [self sendNoMatchedDeviceEventWithMac:mac];
    }
}

- (void)device:(BG5S *)device occurError:(BG5SError)error errorDescription:(NSString *)errorDescription{
    NSLog(@"下位机主发的错误信息：%d",(int)error);
    [self sendMeasureErrorEventWithMac:device.serialNumber errorId:error];
    
}
- (void)device:(BG5S *)device stripStateDidUpdate:(BG5SStripState)state{
    NSLog(@"试条状态：%@",(state == BG5SStripState_Insert)?@"插入":@"拔出");
    
    if (state == BG5SStripState_Insert) {
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                                 kMAC_KEY:device.serialNumber,
                                                                                 kACTION_KEY:kACTION_STRIP_IN,
                                                                                 }];
    }else{
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                                     kMAC_KEY:device.serialNumber,
                                                                                     kACTION_KEY:kACTION_STRIP_OUT,
                                                                                     }];
    }
    
  
}
- (void)deviceDropBlood:(BG5S *)device{
    NSLog(@"滴血");
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                             kMAC_KEY:device.serialNumber,
                                                                             kACTION_KEY:kACTION_GET_BLOOD,
                                                                             }];
}
- (void)device:(BG5S *)device dataID:(NSString *)dataID measureReult:(NSInteger)result{
    NSLog(@"结果:%d",(int)result);
//    NSDictionary *resultDic = [NSDictionary dictionaryWithObjectsAndKeys:@(result),@"value",dataID,@"dataID", nil];
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                             kMAC_KEY:device.serialNumber,
                                                                             RESULT_VALUE:@(result),
                                                                             kDATA_ID:dataID,
                                                                             
                                                                             kACTION_KEY:kACTION_RESULT,
                                                                             }];
}
- (void)device:(BG5S *)device chargeStateDidUpdate:(BG5SChargeState)state{
    NSLog(@"充电线状态：%@",(state == BG5SChargeState_Charging)?@"插入":@"拔出");
    
    if (state == BG5SChargeState_Charging) {
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                                 kMAC_KEY:device.serialNumber,
                                                                                 kACTION_KEY:kACTION_ENTER_CHARGED_STATE,
                                                                                 }];
    }else{
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                                 kMAC_KEY:device.serialNumber,
                                                                                 kACTION_KEY:kACTION_LEAVE_CHARGED_STATE,
                                                                                 }];
        
    }

}


//断开连接
RCT_EXPORT_METHOD(disConnect:(nonnull NSString *)mac){
    if ([self getDeviceWithMac:mac]!=nil) {
        
        [[self getDeviceWithMac:mac] disconnectDevice];
    }else{
        
    }
}

//开始离线数据修正
RCT_EXPORT_METHOD(adjustOfflineData:(nonnull NSString *)mac timeString:(nonnull NSString *)timeString array:(nonnull NSArray *)array ){
    if ([self getDeviceWithMac:mac]!=nil) {
        
        if (array.count > 0 ) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *date = [formatter dateFromString:timeString];
            
            NSArray *correctArray = [[self getDeviceWithMac:mac] processData:array deviceDate:date];
        }
        
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                                 kMAC_KEY:mac,
                                                                                kACTION_KEY:kACTION_ADJUST_OFFLINE_DATA,
                                                                                 }];
        
    }else{
        [self sendNoMatchedDeviceEventWithMac:mac];

    }
}

- (void)sendMeasureErrorEventWithMac:(NSString *)mac errorId:(BG5SError)errorId{
    
    
    NSString *errorDescription = @"";
    
    switch (errorId) {
        case 0:
            errorDescription = @"Only showed in BG5S's screen and need charging.";
            break;
        case 1:
            errorDescription = @"Strip removed in the middle of reading, repeat the test with a new strip.";
            break;
        case 2:
            errorDescription = @"Reference voltage error, not normal measurement, please repeat the test.";
            break;
        case 3:
            errorDescription = @"Strip is used or unknown moisture detected, discard the test strip and repeat the test with a new strip.";
            break;
        case 4:
            errorDescription = @"Reading transmission error. Repeat the test with a new test strip. If the problem persists, contact iHealth customer service for assistance.";
            break;
        case 5:
            errorDescription = @"The environmental temperature is beyond normal range, place the meter at room temperature for at least 30 minutes, then repeat the test.";
            break;
        case 6:
            errorDescription = @"The environmental temperature is beyond normal range, place the meter at room temperature for at least 30 minutes, then repeat the test.";
            break;
        case 7:
            errorDescription = @"Only showed in BG5S's screen.";
            break;
        case 8:
            errorDescription = @"Glucose test result is low.";
            break;
        case 9:
            errorDescription = @"Glucose test result is high.";
            break;
        case 10:
            errorDescription = @"Reset and if the problem persists, contact iHealth customer service for assistance.";
            break;
        case 400:
            errorDescription = @"arameter input error.";
            break;
        case 401:
            errorDescription = @"Quantity not match";
            break;
        case 402:
            errorDescription = @"Single packet is not full.";
            break;
        case 403:
            errorDescription = @"Packet index not match.";
            break;
        case 500:
            errorDescription = @"Command timeout";
            break;
        case 501:
            errorDescription = @"Command is not supported for current device.";
            break;
        default:
            break;
    }
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                             kMAC_KEY:mac,
                                                                             kACTION_KEY:kACTION_ERROR_BG,
                                                                             kERROR_NUM_BG:@(errorId),
                                                                             kERROR_DESCRIPTION_BG:errorDescription
                                                                             }];
}


- (void)sendNoMatchedDeviceEventWithMac:(NSString *)mac{
    if (mac && mac.length > 0) {
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                                 kMAC_KEY:mac,
                                                                                 kACTION_KEY:kACTION_ERROR_BG,
                                                                                 kERROR_NUM_BG:@100
                                                                                 }];
    } else {
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                                 kACTION_KEY:kACTION_ERROR_BG,
                                                                                
                                                                                 kERROR_NUM_BG:@100,
                                                                                 kERROR_DESCRIPTION_BG:@"Device disconnect."

                                                                                 }];
    }
}



@end
