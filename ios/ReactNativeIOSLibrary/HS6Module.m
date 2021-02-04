//
//  HS6Module.m
//  ReactNativeIOSLibrary
//
//  Created by ihealth on 16/12/12.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import "HS6Module.h"
#import "HS6ProfileModule.h"
#import "HSMacroFile.h"
#import "iHealthHS6.h"
#import "HealthUser.h"
#import "iHealthDeviceManagerModule.h"

#define EVENT_NOTIFY @"HS6.MODULE.NOTIFY"

#define HS6_CLIENT_ID @"e33d489fdd6d4961a33c4065f7cedb30"

#define HS6_CLIENT_SECRET @"17075697306e4930b87beffc58ceb2a4"

@implementation HS6Module{
    
    NSString*userAccount;
    
}

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE()

#pragma mark-init

-(NSDictionary *)constantsToExport{
    return @{
             @"Event_Notify" : EVENT_NOTIFY
                          };
}
+ (BOOL)requiresMainQueueSetup
{
    return YES;
}
- (void)sendErrorWithCode:(NSInteger)errorCode{
    [self sendEventWithAction:@"ACTION_ERROR_HS" keyString:@"value" valueString:@(errorCode)];
}

- (void)sendEventWithAction:(NSString*)actionName keyString:(NSString*)key valueString:(id)value{
    [self.bridge.eventDispatcher sendDeviceEventWithName:@"HS6.MODULE.NOTIFY"  body:@{@"action":actionName,key:value}];
}

#pragma mark
#pragma mark - Method
 RCT_EXPORT_METHOD(init:(nonnull NSString*)userName){
    
     [iHealthHS6 shareIHHS6Controller];
     
     userAccount=[userName copy];
     
     NSLog(@"Set User Succeed!");
}

/**
 * set HS6 wifi
 * Import parameter:
 * @param password  - wifi password.
 * Return parameters:
 
 * @param disposeHS6SuccessBlock  - set sucess
 
 * @param disposeHS6FailBlock  - set faild
 
 * @param disposeHS6EndBlock  - end set
 
 * @param disposeHS6ErrorBlock - error code
 * Error code definition：
 * refer to “error” : HS6 error instruction.
 */

/**
 Set HS6 wifi
 Import parameter:
 @param password wifi password.
 
 Return parameters:
 @param disposeHS6SuccessBlock set sucess
 @param disposeHS6FailBlock set faild
 @param disposeHS6EndBlock end set
 @param disposeHS6ErrorBlock error code
 */

RCT_EXPORT_METHOD(setWifi:(nonnull NSString*)ssid :(nonnull NSString*)password){
    
   
    iHealthHS6 *hs6Controller = [iHealthHS6 shareIHHS6Controller];
    if (hs6Controller != nil) {
        [hs6Controller commandSetHS6WithPassWord:password disposeHS6SuccessBlock:^(NSDictionary *deviceInfo) {
            
            NSMutableArray*deviceArray=[NSMutableArray array];
            
            [deviceArray addObject:@true];
            
            NSDictionary *deviceInf = @{@"action":ACTION_HS6_SETWIFI,SETWIFI_RESULT:deviceArray};
            
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInf];
            NSLog(@"WIFI sucess");
        } disposeHS6FailBlock:^(NSString *failmsg) {
            NSDictionary *deviceInf = @{@"action":ACTION_HS6_SETWIFI,SETWIFI_RESULT:failmsg};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInf];
            
        } disposeHS6EndBlock:^(NSDictionary *deviceDic) {
            NSLog(@"set WIFI over");
            
        } disposeHS6ErrorBlock:^(NSNumber *error) {
            NSDictionary *deviceInf = @{@"action":ACTION_HS6_ERROR,HS6_ERROR:[NSNumber numberWithInteger:error]};
            
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInf];
        }];
    }
       }

/**
 Binding QR Device
 When using the SDK for the first time, measuring method needs to be called to finish user verification.

 @param tempDeviceID device Mac
 Return parameters:
 The measurement via SDK will be operated in the case of 1-4, and will be terminated if any of 5-8 occurs. The interface needs to be re-called after analyzing the return parameters.
 Notice: when a new user registers via SDK, an ‘iHealth disclaimer’ will pop up automatically, and will require the user to agree in order to continue. SDK applications require an Internet connection; there is 10-day trial period if the SDK cannot connect to the internet, the SDK is fully functional during tryout period, but will be terminated without a working internet connection after 10 days.
 @param result Action = 1;(1:bind sucess 2：full user bind faild 3,:ts error bind faild 4 other),
 BineNum=10
 MAC
 Position = 1;（user in weight number）
 SetWifi=0
 Status = 1;（1:binding 2：unbind）
 TS (time);
 @param error error code
 */

RCT_EXPORT_METHOD(bindDeviceHS6:(nonnull NSString*)birthday :(nonnull NSNumber*)weight :(nonnull NSNumber*)height :(nonnull NSNumber*)isSporter :(nonnull NSNumber*)gender :(nonnull NSString*)serialNumber){
   iHealthHS6 *hs6Controller = [iHealthHS6 shareIHHS6Controller];
    if (hs6Controller != nil) {
        HealthUser* healthUser = [[HealthUser alloc] init];
        healthUser.userAccount = userAccount;
        healthUser.clientID = HS6_CLIENT_ID;
        healthUser.clientSecret = HS6_CLIENT_SECRET;
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        healthUser.birthday=[dateFormatter dateFromString:birthday];
        
        healthUser.weight=weight;
        
        healthUser.height=height;
        
        healthUser.isAthlete=isSporter.intValue;
        
        healthUser.sex=gender.intValue;

        [hs6Controller cloudCommandUserBinedQRDeviceWithUser:healthUser deviceID:serialNumber  binedResult:^(NSArray *resultArray) {
            
            NSDictionary*deviceDic=[resultArray objectAtIndex:0];
            
            NSMutableArray*deviceArray=[NSMutableArray array];
            
            NSDictionary *deviceBackDic = @{BIND_HS6_RESULT:[deviceDic objectForKey:@"Action"],HS6_MODEL:[deviceDic objectForKey:@"Status"],HS6_POSITION:[deviceDic objectForKey:@"Position"],HS6_SETTED_WIFI:[deviceDic objectForKey:@"SetWifi"]};
            
            [deviceArray addObject:deviceBackDic];
            
            NSDictionary *deviceInf = @{@"action":ACTION_HS6_BIND,HS6_BIND_EXTRA:deviceArray};
            NSLog(@"ResultArray%@",resultArray);
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInf];
        } binedError:^(NSString *errorCode) {
            NSDictionary *deviceInf = @{@"action":ACTION_HS6_ERROR,HS6_ERROR:errorCode};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInf];

        }];
    }
}
/**
 unBind QR Device
 
 Import parameter:
 @param tempUser Properties included: clientID，clientSecret，userAccount，height.
 clientID & clientSecret: the only identification for users of the SDK, requires registration from iHealth administrator, please email: sdk@ihealthlabs.com.cn for more information.
 @param serialNumber device Mac
 Return parameters:
 @param result Action = 1;(1:bind sucess 2：full user bind faild 3,:ts error bind faild 4 other),
 MAC
 Status = 2;（1:binding 2：unbind）
 TS
 @param error error code
 */
RCT_EXPORT_METHOD(unBindDeviceHS6:(nonnull NSString*)serialNumber){
    
    iHealthHS6 *hs6Controller = [iHealthHS6 shareIHHS6Controller];

    if (hs6Controller != nil) {
        HealthUser* healthUser = [[HealthUser alloc] init];
        healthUser.userAccount = userAccount;
        healthUser.clientID = HS6_CLIENT_ID;
        healthUser.clientSecret = HS6_CLIENT_SECRET;

        [hs6Controller cloudCommandUserDisBinedQRDeviceForUser:healthUser withDeviceID:serialNumber disBinedResult:^(NSArray *resultArray) {
            NSDictionary *deviceInf = @{@"action":ACTION_HS6_UNBIND,HS6_UNBIND_RESULT:resultArray};
            
            NSLog(@"unBindDeviceHS6:%@",resultArray);
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInf];

        } disBinedError:^(NSString *errorCode) {
            NSDictionary *deviceInf = @{@"action":ACTION_HS6_ERROR,HS6_ERROR:[NSString stringWithFormat:@"%@", errorCode]};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInf];
        }];
    }
}

RCT_EXPORT_METHOD(getToken:(nonnull NSString*)clientId :(nonnull NSString*)clientSecret:(nonnull NSString*)username :(nonnull NSString*)clientPara){

    iHealthHS6 *hs6Controller = [iHealthHS6 shareIHHS6Controller];

    if (hs6Controller != nil) {
        HealthUser* healthUser = [[HealthUser alloc] init];
        healthUser.userAccount = username;
        healthUser.clientID = clientId;
        healthUser.clientSecret = clientSecret;
        

        [hs6Controller commandHS6GetOpenAPITokenWithUser:healthUser withSuccessBlock:^(NSDictionary*openAPIInfoDic) {
            NSDictionary *deviceInf = @{@"action":ACTION_HS6_GET_TOKEN,GET_TOKEN_RESULT:openAPIInfoDic};
            NSLog(@"openAPIInfoDic%@",openAPIInfoDic);
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInf];
        } withErrorBlock:^(NSDictionary *errorCode) {
            
            if (errorCode!=nil && [errorCode isKindOfClass:[NSDictionary class]]) {
                NSDictionary *deviceInf = @{@"action":ACTION_HS6_ERROR, HS6_ERROR:[errorCode valueForKey:@"ErrorCode"],HS6_ERROR:[errorCode valueForKey:@"ErrorDescription"]};
                
                [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInf];
            }
           
        }];
    }
}

/**
 sync Weight Unit
 Import parameter:
 @param tempUser Properties included: clientID，clientSecret，userAccount,serialNub.
 @param unit IHHS6SDKUnitWeight_kg,IHHS6SDKUnitWeight_lb,IHHS6SDKUnitWeight_oz
 
 /// kg
 IHHS6SDKUnitWeight_kg = 0,
 /// lb
 IHHS6SDKUnitWeight_lbs =1 ,
 /// st
 IHHS6SDKUnitWeight_oz = 2,
 
 Return parameters:
 @param unitBlock YES or NO
 @param errorBlock error code
 */

RCT_EXPORT_METHOD(setUnit:(nonnull NSString*)username :(nonnull NSNumber*)unitType){
     iHealthHS6 *hs6Controller = [iHealthHS6 shareIHHS6Controller];
    if (hs6Controller != nil) {
        HealthUser* healthUser = [[HealthUser alloc] init];
        healthUser.userAccount = username;
        healthUser.clientID = HS6_CLIENT_ID;
        healthUser.clientSecret = HS6_CLIENT_SECRET;
        
        [hs6Controller commandHS6WithUser:healthUser withSyncWeightUnit:unitType.intValue withSuccessBlock:^(BOOL syncWeightUnit) {
            NSDictionary *deviceInf = @{@"action":ACTION_HS6_SET_UNIT,SET_UNIT_RESULT:[NSNumber numberWithBool:syncWeightUnit]};
            NSLog(@"setUnitResult:%d",syncWeightUnit);
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInf];
            
        } withErrorBlock:^(NSString *errorCode) {
            NSDictionary *deviceInf = @{@"action":ACTION_HS6_ERROR,HS6_ERROR:errorCode};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInf];
        }];
    }

}

/**
 DownloadHS6Data
 
 Import parameter:
 @param tempUser Properties included: clientID，clientSecret，userAccount
 clientID & clientSecret: the only identification for users of the SDK, requires registration from iHealth administrator, please email: sdk@ihealthlabs.com.cn for more information.
 @param downloadTS :From 1970, the number of seconds, download data download all data after this point in time.
 Return parameters:
 @param getHS6Data  AllHS6Data
 
 @param blockHS6LastTSFromCloud  The last timestamp of the data download can be passed in at the next download, and all the data after the timestamp is downloaded.
 
 @param errorBlock  error code    101,102,103,104:networkerror   400:input error 209:The user doesn't exist
 */

RCT_EXPORT_METHOD(getCloudData:(nonnull NSString*)clientId :(nonnull NSString*)clientSecret :(nonnull NSString*)username :(nonnull NSNumber*)ts :(nonnull NSNumber*)pageSize){
    
    iHealthHS6 *hs6Controller = [iHealthHS6 shareIHHS6Controller];
    
    if (hs6Controller != nil) {
        HealthUser* healthUser = [[HealthUser alloc] init];
        healthUser.userAccount = username;
        healthUser.clientID = clientId;
        healthUser.clientSecret = clientSecret;
        
        [hs6Controller commandDownloadHS6Data:healthUser withDownloadTS:[ts longValue] withPageSize:[pageSize longValue] withSuccessBlock:^(NSDictionary *dataDic) {
            
            NSDictionary *deviceInf = @{@"action":ACTION_HS6_GET_CLOUDDATA,HS6_CLOUDDATA:dataDic};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInf];
            
        } blockHS6LastTSFromCloud:^(NSNumber *lastTS) {
            
            NSDictionary *deviceInf = @{@"action":ACTION_HS6_GET_CLOUDDATA_LASTTS,HS6_CLOUDDATA_LASTTS:lastTS};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInf];
            
            
        } withErrorBlock:^(NSNumber *error) {
            
            NSDictionary *deviceInf = @{@"action":ACTION_HS6_ERROR,HS6_ERROR:error};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInf];
            
        }];
        
        
    }
}

@end
