//
//  ECGModule.m
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2018/1/5.
//  Copyright © 2018年 daiqingquan. All rights reserved.
//

#import "ECGModule.h"
#import "ECGHeader.h"
#import "ECGProfileModule.h"
#import "ManageDeviceController.h"

#define EVENT_NOTIFY @"event_notify_ecg"

@implementation ECGModule

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE()

#pragma mark
#pragma mark - constantsToExport
- (NSDictionary *)constantsToExport{
    return @{@"Event_Notify": EVENT_NOTIFY };
    
}

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}
#pragma mark
#pragma mark - Init
-(id)init{
    if (self=[super init]){
    }
    return self;
}

-(ECG3*)getECG3WithMac:(nonnull NSString*)mac{
    
    ECG3Controller *controller = [ECG3Controller shareECG3Controller];
    NSArray *ecgDeviceArray = [controller getAllCurrentECG3Instace];
    
    for(ECG3 *tempECG3 in ecgDeviceArray){
        if([mac isEqualToString:tempECG3.serialNumber]){
            return tempECG3;
        }
    }
    
    return nil;
}

#pragma mark -
#pragma mark - Method

RCT_EXPORT_METHOD(getAllConnectedDevices){
    
    
    NSArray*ecg3array= [[ECG3Controller shareECG3Controller] getAllCurrentECG3Instace];
    
    NSMutableArray*deviceMacArray=[NSMutableArray array];
    
    for (int i=0; i<[ecg3array count]; i++) {
        
        ECG3 *ecg3=[ecg3array objectAtIndex:i];
        [deviceMacArray addObject:ecg3.serialNumber];
    }
    
    NSDictionary* deviceInfo = @{kACTION:kACTION_GET_ALL_CONNECTED_DEVICES,kDEVICES:deviceMacArray};
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
    
    
}



RCT_EXPORT_METHOD(getBattery:(nonnull NSString *)mac){
    
    if ([self getECG3WithMac:mac]!=nil) {
        __weak typeof(self) weakSelf = self;
        [[self getECG3WithMac:mac] commandECG3GetBatteryInfo:^(NSNumber *battery) {
            
            NSDictionary* deviceInfo = @{kACTION:kACTION_BATTERY_ECG,kBATTERY_ECG:battery,kMAC:mac,kType:@"ECG3"};
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } withErrorBlock:^(ECG3ErrorID errorID) {
            [weakSelf commandReturnECGError:errorID MAC:mac];
        }];
    }else{
        
        [self commandReturnECGError:ECG3Error_Disconnect MAC:mac];
        
    }
    
    
}

RCT_EXPORT_METHOD(sysTime:(nonnull NSString *)mac){
    
    if ([self getECG3WithMac:mac]!=nil) {
        __weak typeof(self) weakSelf = self;
        [[self getECG3WithMac:mac] commandECG3SyncTime:^{
            
            NSDictionary* deviceInfo = @{kACTION:kACTION_SYSTIME,kMAC:mac,kType:@"ECG3"};
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } withErrorBlock:^(ECG3ErrorID errorId) {
            [weakSelf commandReturnECGError:errorId MAC:mac];
        }];
       
    }else{
        [self commandReturnECGError:ECG3Error_Disconnect MAC:mac];
    }
}

RCT_EXPORT_METHOD(stopMeasure:(nonnull NSString *)mac){
    
    
    if ([self getECG3WithMac:mac]!=nil) {
        __weak typeof(self) weakSelf = self;
        [[self getECG3WithMac:mac] commandECG3FinishMeasure:^{
            
            
            NSDictionary* deviceInfo = @{kACTION:kACTION_STOPMEASURE_ECG,kMAC:mac,kType:@"ECG3"};
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } withErrorBlock:^(ECG3ErrorID errorId) {
            [weakSelf commandReturnECGError:errorId MAC:mac];
        }];
        
    }else{
        
        [self commandReturnECGError:ECG3Error_Disconnect MAC:mac];
    }
    
}


RCT_EXPORT_METHOD(startMeasure:(nonnull NSString *)mac){
    
    if ([self getECG3WithMac:mac]!=nil) {
        __weak typeof(self) weakSelf = self;
        [[self getECG3WithMac:mac] commandECG3StartMeasure:^{
            
        } withWaveData:^(NSArray *waveDataArray) {
            
            NSDictionary* deviceInfo = @{kACTION:kACTION_MEASURE_WAVEData,kMEASURE_WAVEData:waveDataArray,kMAC:mac,kType:@"ECG3"};
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } withPulseResult:^(BOOL hasHR, NSUInteger HR) {
            
            NSDictionary* deviceInfo = @{kACTION:kACTION_MEASURE_ECGPulse,kMEASURE_ECGPulse:@(HR),kMAC:mac,kType:@"ECG3"};
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } withErrorBlock:^(ECG3ErrorID errorId) {
            
            if (errorId>= ECG3Error_ElectrodeLoss && errorId <= ECG3Error_ElectrodeLossTimeout) {
                NSDictionary* deviceInfo = @{kACTION:kACTION_ELECTRODE_STATUS,kELECTRODE_STATUS:@(errorId),kMAC:mac,kType:@"ECG3"};
                [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            } else {
                [weakSelf commandReturnECGError:errorId MAC:mac];
            }
            
        }];
        
        
    }else{
        [self commandReturnECGError:ECG3Error_Disconnect MAC:mac];
    }
    
}

RCT_EXPORT_METHOD(disconnect:(nonnull NSString *)mac){
    if ([self getECG3WithMac:mac]!=nil) {
        [[ManageDeviceController commandGetInstance] commandDisconnectSelectDevice:[self getECG3WithMac:mac].currentUUID];
    }
}

-(void)commandReturnECGError:(ECG3ErrorID)errorID MAC:(NSString *)MAC{
    
    
    NSMutableDictionary*deviceInfo=[NSMutableDictionary dictionary];
    
    [deviceInfo setValue:kACTION_ERROR_ECG forKey:kACTION];
    
    NSString*errorDes=[NSString string];
    
    switch (errorID) {
        case ECG3Error_ElectrodeLoss:
            errorDes=@"Electrode Loss";
            break;
        case ECG3Error_ElectrodeLossRecovery:
            errorDes=@"Electrode Loss Recovery";
            break;
        case ECG3Error_ElectrodeLossTimeout:
            errorDes=@"Electrode Loss Timeout";
            break;
        case ECG3Error_SDCardCommunicationError:
            errorDes=@"SDCard Communication Error";
            break;
        case ECG3Error_SampleModuleError:
            errorDes=@"Sample Module Error";
            break;
        case ECG3Error_LowPower:
            errorDes=@"Low Power";
            break;
        case ECG3Error_DeviceMemoryFull:
            errorDes=@"Device Memory Full";
            break;
        case ECG3Error_Disconnect:
            errorDes=@"Disconnect";
            break;
        case ECG3Error_ParameterError:
            errorDes=@"Parameter Error";
            break;
        case ECG3Error_CommandTimeout:
            errorDes=@"Command timeout";
            break;
        default:
            break;
    }
    
    [deviceInfo setValue:[NSNumber numberWithInt:errorID] forKey:kERROR_NUM_ECG];
    
    [deviceInfo setValue:errorDes forKey:kERROR_DESCRIPTION_ECG];
    
    [deviceInfo setValue:@"ECG3" forKey:kType];
    if (MAC) {
        [deviceInfo setValue:MAC forKey:kMAC];
    }
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
}

@end
