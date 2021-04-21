//
//  BG1SModule.m
//  ReactNativeIOSLibrary
//
//  Created by user on 2019/11/12.
//  Copyright © 2019 daiqingquan. All rights reserved.
//

#import "BG1SModule.h"
#import "BG1S.h"
#import "BG1SController.h"
#import "BG1SProfileModule.h"

#import "BGHeader.h"

@implementation BG1SModule
@synthesize bridge = _bridge;
RCT_EXPORT_MODULE()

- (NSDictionary *)constantsToExport
{
    return @{ @"Event_Notify": BG1S_EVENT_NOTIFY ,
              
    };
}

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}


-(BG1S*)getDeviceWithMac:(NSString*)mac{
    
    BG1SController *controller = [BG1SController shareIHBG1SController];
    NSArray *BG1SDeviceArray = [controller getAllCurrentBG1SInstace];
    
    for(BG1S *tempDevice in BG1SDeviceArray){
        if([mac isEqualToString:tempDevice.serialNumber]){
            
            return tempDevice;
        }
    }
    return nil;
}

RCT_EXPORT_METHOD(getAllConnectedDevices){
    
    
    NSArray*BG1SDeviceArray= [[BG1SController shareIHBG1SController] getAllCurrentBG1SInstace];
    
    NSMutableArray*deviceMacArray=[NSMutableArray array];
    
    for (int i=0; i<[BG1SDeviceArray count]; i++) {
        
        BG1S *BG1S = [BG1SDeviceArray objectAtIndex:i];
        
        [deviceMacArray addObject:BG1S.serialNumber];
        
    }
    
    NSDictionary* deviceInfo = @{BG1S_ACTION:kACTION_GET_ALL_CONNECTED_DEVICES,BG1S_DEVICE:deviceMacArray};
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:BG1S_EVENT_NOTIFY body:deviceInfo];
}

RCT_EXPORT_METHOD(measure:(nonnull NSString *)mac measureMode:(nonnull NSNumber *)testType){
    
    
    if ([self getDeviceWithMac:mac] != nil) {
        
        BGMeasureMode models= BGMeasureMode_Blood;
        
        if ([testType intValue]==1) {
            
            models=BGMeasureMode_NoBlood;
            
        }else{
            
            models=BGMeasureMode_Blood;
        }
        
        [[self getDeviceWithMac:mac] commandCreateBG1STestModel:models DisposeBGStripInBlock:^(BOOL inORout) {
            
            if (inORout) {
                [self.bridge.eventDispatcher sendDeviceEventWithName:BG1S_EVENT_NOTIFY body:@{
                    BG1S_ACTION:ACTION_STRIP_INSERTION_STATUS,
                    BG1S_KEY_MAC:mac,
                    BG1S_TYPE:@"BG1S",
                    OPERATION_DESCRIBE:@"strip in",
                    STRIP_INSERTION_STATUS:@1,
                }];
            }else{
                
                [self.bridge.eventDispatcher sendDeviceEventWithName:BG1S_EVENT_NOTIFY body:@{
                    BG1S_ACTION:ACTION_STRIP_INSERTION_STATUS,
                    BG1S_KEY_MAC:mac,
                    BG1S_TYPE:@"BG1S",
                    OPERATION_DESCRIBE:@"strip put",
                    STRIP_INSERTION_STATUS:@2,
                }];
            }
            
        } DisposeBGBloodBlock:^{
            
            [self.bridge.eventDispatcher sendDeviceEventWithName:BG1S_EVENT_NOTIFY body:@{
                BG1S_ACTION:ACTION_GET_BLOOD,
                BG1S_KEY_MAC:mac,
                BG1S_TYPE:@"BG1S",
                OPERATION_DESCRIBE:@"get blood"
            }];
            
        } DisposeBGResultBlock:^(NSDictionary *result) {
            
            
            [self.bridge.eventDispatcher sendDeviceEventWithName:BG1S_EVENT_NOTIFY body:@{
                BG1S_ACTION:ACTION_MEASURE_RESULT,
                BG1S_KEY_MAC:mac,
                BG1S_TYPE:@"BG1S",
                MEASURE_RESULT:[result valueForKey:@"Result"],
                MEASURE_MODE:[result valueForKey:@"TestState"]
            }];
            
        } DisposeBGErrorBlock:^(BG1SDeviceError error) {
            
            [self sendBG1SErrorCode:error mac:mac];
            
        }];
        
        
    }
    
}

//getFunction
RCT_EXPORT_METHOD(getFunction:(nonnull NSString *)mac){
    if ([self getDeviceWithMac:mac]!=nil) {
        
        
        [[self getDeviceWithMac:mac] commandFunction:^(NSDictionary *functionDict) {
            
            
            [self.bridge.eventDispatcher sendDeviceEventWithName:BG1S_EVENT_NOTIFY body:@{
                BG1S_ACTION:ACTION_CODE_ANALYSIS,
                BG1S_KEY_MAC:mac,
                BG1S_TYPE:@"BG1S",
                INFO_BATTERY_BG1S:[functionDict valueForKey:@"Battary"],
                INFO_VERSION_CODE_BLOOD_BG1S:[functionDict valueForKey:@"CodeVersion"],
                INFO_VERSION_CODE_CTL_BG1S:[functionDict valueForKey:@"DcodeVersion"],
                
            }];
            
        } DisposeBGErrorBlock:^(BG1SDeviceError error) {
            
            
            [self sendBG1SErrorCode:error mac:mac];
            
        }];
        
        
    }
}

//断开连接
RCT_EXPORT_METHOD(disconnect:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]!=nil) {
        
        [[self getDeviceWithMac:mac] commandDisconnectDevice];
    }
    
}

-(void)sendBG1SErrorCode:(BG1SDeviceError)errorID mac:(NSString*)mac{
    
                NSString *errorMassage = [NSString string];
                switch (errorID) {
                    case 0:
                         errorMassage = @"BG1SDeviceError0";
                        break;
                    case 1:
                        errorMassage = @"BG1SError_LowBattery";
                        break;
                    case 2:
                         errorMassage = @"BG1SError_ReferenceUnstable";
                        break;
                    case 3:
                        errorMassage = @"BG1SError_BadStrip";
                        break;
                    case 4:
                        errorMassage = @"BG1SError_BadEEPROM";
                        break;
                    case 5:
                         errorMassage = @"BG1SError_LowAmbientTemperature";
                        break;
                    case 6:
                        errorMassage = @"BG1SError_HighAmbientTemperature";
                        break;
                    case 7:
                        errorMassage = @"BG1SError_BleedEarly";
                        break;
                    case 8:
                       errorMassage = @"BG1SError_Other";
                        break;
                        

                    default:
                        break;
                }
    
                NSDictionary *deviceInfo = @{BG1S_KEY_MAC:mac,BG1S_ACTION:ACTION_ERROR_BG1S,ERROR_NUM_BG1S:[NSNumber numberWithInt:errorID],ERROR_DESCRIPTION_BG1S:errorMassage};
                [self.bridge.eventDispatcher sendDeviceEventWithName:BG1S_EVENT_NOTIFY body:deviceInfo];
    
    
}

@end
