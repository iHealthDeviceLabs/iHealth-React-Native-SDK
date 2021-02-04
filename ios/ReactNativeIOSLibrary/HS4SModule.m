//
//  HS4SModule.m
//  ReactNativeIOSLibrary
//
//  Created by ihealth on 16/12/2.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import "HS4SModule.h"
#import "HSProfileModule.h"
#import "HSMacroFile.h"
#import "HS4Controller.h"
#import "HS4.h"
#import "iHealthDeviceManagerModule.h"
#import "ManageDeviceController.h"


#define EVENT_NOTIFY @"HS4.MODULE.NOTIFY" 

@implementation HS4SModule

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE()

#pragma mark-init

-(NSDictionary *)constantsToExport{
    return @{
             @"Event_Notify" :  EVENT_NOTIFY
             };
}

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}
-(HS4 *)getHS4WithMac:(NSString *)mac{
    HS4Controller *controller = [HS4Controller shareIHHs4Controller];
    NSArray *hs4DeviceArray = [controller getAllCurrentHS4Instace];
    for (HS4 *tempHS4 in  hs4DeviceArray) {
        if ([mac isEqualToString:tempHS4.deviceID]){
            return tempHS4;
            break;
        }
    }
    return nil;
}

#pragma mark
#pragma mark - Notification
#pragma mark - HS4
-(void)DeviceConnectForHS4S:(NSNotification *)notify{
    HS4Controller *controller = [HS4Controller shareIHHs4Controller];
    NSArray *hs4DeviceArray = [controller getAllCurrentHS4Instace];
    
    HS4 *hs4Instance = [hs4DeviceArray objectAtIndex:0];
}

#pragma mark
#pragma mark - Method


#pragma mark-获取连接设备
RCT_EXPORT_METHOD(getAllConnectedDevices){
    
    
    NSArray*hs4array= [[HS4Controller shareIHHs4Controller] getAllCurrentHS4Instace];
    
    NSMutableArray*deviceMacArray=[NSMutableArray array];
    
    for (int i=0; i<[hs4array count]; i++) {
        
        HS4*hs4=[hs4array objectAtIndex:i];
        
        [deviceMacArray addObject:hs4.deviceID];
        
    }
    
    NSDictionary* deviceInfo = @{@"action":@"action_get_all_connected_devices",@"devices":deviceMacArray};
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
    
    
}


RCT_EXPORT_METHOD(getOfflineData:(nonnull NSString*)mac){
    if ([self getHS4WithMac:mac] != nil) {
        
        NSLog(@"上传离线数据");
        [[self getHS4WithMac:mac]commandTransferMemorryData:^(NSDictionary *startDataDictionary) {
            
           
        } DisposeProgress:^(NSNumber *progress) {
            
        } MemorryData:^(NSArray *historyDataArray) {
           
            if(historyDataArray != nil){
                
                if(historyDataArray.count){
                    
                    NSMutableArray*dataArray=[NSMutableArray array];
                    
                    for (int i=0; i<historyDataArray.count; i++) {
                        
                        NSDate *tempDate = [[historyDataArray objectAtIndex:i] objectForKey:@"date"];
                        
                    
                        NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
                        [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        NSString *dateStr = [mydateFormatter stringFromDate:tempDate];
                        
                        
                        NSDictionary*dic=@{DATAID:[[historyDataArray objectAtIndex:i] objectForKey:@"dataID"],MEASUREMENT_DATE_HS:dateStr,WEIGHT_HS:[[historyDataArray objectAtIndex:i] objectForKey:@"weight"]};

                        [dataArray addObject:dic];
                    }
                    
                    
                     NSDictionary *deviceInfo = @{@"mac":mac,@"action":ACTION_HISTORICAL_DATA_HS,HISTORDATA_HS:dataArray};
                    
                    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
                    NSLog(@"historyDataArray:%@",historyDataArray);
 
                }
          
            }
        } FinishTransmission:^{
            NSDictionary *deviceInfo = @{@"mac":mac,@"action":ACTION_HISTORICAL_DATA_COMPLETE_HS};
            
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        } DisposeErrorBlock:^(HS4DeviceError errorID) {
            NSString *errorMassage = [NSString string];
            NSLog(@"errorID:%d",errorID);
            switch (errorID) {
                case 1:
                errorMassage = @"Battery level is low";
                break;
                case 2:
                errorMassage = @"The Scale failed to initialize.";
                break;
                case 5:
                errorMassage = @"Bluetooth connection error.";
                break;
                case 7:
                errorMassage = @"Invalidate.";
                break;
                case 8:
                errorMassage = @"Scale memory access error.";
                break;
                case 9:
                errorMassage = @"No History Data.";
                break;
                case 10:
                errorMassage = @"Device disconnect.";
                break;
//                case 11:
//                errorMassage = @"Communication error.";
//                break;
                default:
                break;
            }
            if(errorID == 9){
            NSDictionary *deviceInfo = @{@"mac":mac,@"action":ACTION_NO_HISTORICALDATA,ERROR_DESCRIPTION_HS:@"No History Data."};
                
                [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            }
            else if(errorID != 11){
                NSDictionary *deviceInfo = @{@"mac":mac,@"action":ACTION_ERROR_HS,ERROR_NUM_HS:errorMassage};
        
                [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];}
        }];
    }
}


RCT_EXPORT_METHOD(measureOnline:(nonnull NSString*)mac :(nonnull NSNumber*)unit :(nonnull NSNumber*)userId){
    if ([self getHS4WithMac:mac] != nil) {
       
        [[self getHS4WithMac:mac]commandMeasureWithUint:unit.intValue  Weight:^(NSNumber *unStableWeight) {
            NSDictionary *deviceInfo = @{@"mac":mac,@"action":ACTION_LIVEDATA_HS,LIVEDATA_HS:unStableWeight};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } StableWeight:^(NSDictionary *StableWeightDic) {
            NSDictionary *deviceInfo =@{@"mac":mac,@"action":ACTION_ONLINE_RESULT_HS,DATAID:[StableWeightDic valueForKey:@"dataID"],WEIGHT_HS:[StableWeightDic valueForKey:@"Weight"] };
            
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        } DisposeErrorBlock:^(HS4DeviceError errorID) {
           NSString *errorMassage = [NSString string];
            switch (errorID) {
                case 1:
                errorMassage = @"Battery level is low.";
                break;
                case 2:
                errorMassage = @"The Scale failed to initialize.";
                break;
                case 3:
                errorMassage = @"Maximum weight has been exceeded.";
                break;
                case 4:
                errorMassage = @"The Scale can't capture a steady reading.";
                break;
                case 5:
                errorMassage = @"Bluetooth connection error.";
                break;
                case 6:
                errorMassage = @"Movement while measuring.";
                break;
                case 7:
                errorMassage = @"Invalidate.";
                break;
                case 10:
                errorMassage = @"Device disconnect.";
                break;
                case 11:
                errorMassage = @"Communication error.";
                break;
                case 12:
                errorMassage = @"HS4DeviceRecWeightError.";
                break;
                default:
                break;
            }

            NSDictionary *deviceInfo = @{@"mac":mac,@"action":ACTION_ERROR_HS,ERROR_NUM_HS:errorMassage};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        }];
    }

}

RCT_EXPORT_METHOD(disconnect:(nonnull NSString*)mac){
    if ([self getHS4WithMac:mac] != nil){
        
        [[self getHS4WithMac:mac]commandDisconnectDevice];
        NSLog(@"End device connnect!");
        
    }else{
        
   }
}
- (void)sendErrorWithCode:(NSInteger)errorCode{
    [self sendEventWithAction:@"ACTION_ERROR_HS" keyString:@"value" valueString:@(errorCode)];
}

- (void)sendEventWithAction:(NSString*)actionName keyString:(NSString*)key valueString:(id)value{
    [self.bridge.eventDispatcher sendDeviceEventWithName:@"HS4.MODULE.NOTIFY"  body:@{@"action":actionName,key:value}];
}

@end
