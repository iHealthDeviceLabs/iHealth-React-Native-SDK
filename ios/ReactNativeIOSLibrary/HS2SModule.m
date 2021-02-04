//
//  HS2Module.m
//  ReactNativeIOSLibrary
//
//  Created by jing on 2018/11/26.
//  Copyright © 2018年 daiqingquan. All rights reserved.
//

#import "HS2SModule.h"
#import "HS2SProfileModule.h"
#import "HSMacroFile.h"
#import "HS2SController.h"
#import "HS2S.h"
#import "iHealthDeviceManagerModule.h"
#import "ManageDeviceController.h"

#define EVENT_NOTIFY @"HS2S.MODULE.NOTIFY"
#define kMAC_KEY        @"mac"
#define kACTION_KEY     @"action"
#define kTYPE_KEY     @"type"

#define kTYPE_HS2S     @"HS2S"

@implementation HS2SModule
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

-(HS2S *)getHS2SWithMac:(NSString *)mac{
    HS2SController *controller = [HS2SController shareIHHS2SController];
    NSArray *hs2sDeviceArray = [controller getAllCurrentHS2SInstace];
    for (HS2S *tempHS2S in  hs2sDeviceArray) {
        if ([mac isEqualToString:tempHS2S.serialNumber]){
            return tempHS2S;
            break;
        }
    }
    return nil;
}

#pragma mark
#pragma mark - Method


#pragma mark-获取连接设备
RCT_EXPORT_METHOD(getAllConnectedDevices){
    
    
    NSArray*hs2sarray= [[HS2SController shareIHHS2SController] getAllCurrentHS2SInstace];
    
    NSMutableArray*deviceMacArray=[NSMutableArray array];
    
    for (int i=0; i<[hs2sarray count]; i++) {
        
        HS2S*hs2s=[hs2sarray objectAtIndex:i];
        
        [deviceMacArray addObject:hs2s.serialNumber];
        
    }
    
    NSDictionary* deviceInfo = @{kACTION_KEY:ACTION_GET_ALL_CONNECTED_DEVICES,@"devices":deviceMacArray};
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
    
    
}

RCT_EXPORT_METHOD(getDeviceInfo:(nonnull NSString*)mac){
    if ([self getHS2SWithMac:mac] != nil) {

        [[self getHS2SWithMac:mac] commandGetHS2SDeviceInfo:^(NSDictionary *deviceInfo) {
            
            
            NSDictionary* deviceInfoDic = @{kMAC_KEY:mac,
                                            kTYPE_KEY:kTYPE_HS2S,
                                            kACTION_KEY:ACTION_GET_HS2S_DEVICE_INFO,
                                            HS2S_DEVICE_BATTERY:[deviceInfo valueForKey:@"Battary"],
                                            HS2S_DEVICE_UNIT:[deviceInfo valueForKey:@"Unit"],
                                            HS2S_DEVICE_USER_COUNT:[deviceInfo valueForKey:@"UserCount"]
            };
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfoDic];
            
        } DiaposeErrorBlock:^(HS2SDeviceError errorID) {
            
            [self sendHS2SErrorCode:errorID mac:mac];
        }];

    }
}

RCT_EXPORT_METHOD(getBattery:(nonnull NSString*)mac){
    if ([self getHS2SWithMac:mac] != nil) {

        [[self getHS2SWithMac:mac]commandGetHS2SBattery:^(NSNumber *battary) {
            
            NSDictionary *deviceInfo = @{kMAC_KEY:mac,kTYPE_KEY:kTYPE_HS2S,kACTION_KEY:ACTION_BATTARY_HS,BATTERY_HS:battary};
                       
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
                       
            
        } DiaposeErrorBlock:^(HS2SDeviceError errorID) {
            
             [self sendHS2SErrorCode:errorID mac:mac];
            
        }];

    }
}
RCT_EXPORT_METHOD(setUnit:(nonnull NSString*)mac :(nonnull NSNumber*)unit){
       
    
    if ([self getHS2SWithMac:mac] != nil) {
        
        HSUnit tempUnit;
               
               switch ([unit intValue]) {
                   case 1:
                       tempUnit=HSUnit_Kg;
                       break;
                   case 2:
                       tempUnit=HSUnit_LB;
                       break;
                   case 3:
                       tempUnit=HSUnit_ST;
                       break;
                   default:
                        tempUnit=HSUnit_Kg;
                       break;
               }
        
        
        __weak typeof(self) weakSelf = self;

        [[self getHS2SWithMac:mac] commandSetHS2SUnit:tempUnit result:^(BOOL result) {
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                
            kMAC_KEY:mac,
            
            kTYPE_KEY:kTYPE_HS2S,
            
            kACTION_KEY:ACTION_SET_HS2S_UNIT,
            
            HS2S_SET_RESULT:[NSNumber numberWithBool:result]
            
            }];
            
        } DisposeErrorBlock:^(HS2SDeviceError errorID) {
            
             [self sendHS2SErrorCode:errorID mac:mac];
            
        }];

    }
    
}

RCT_EXPORT_METHOD(getUserInfo:(nonnull NSString*)mac){
    
    if ([self getHS2SWithMac:mac] != nil) {
        
          __weak typeof(self) weakSelf = self;

        [[self getHS2SWithMac:mac]commandGetHS2SUserInfo:^(NSDictionary *userInfo) {
            
            
            NSMutableArray*tempUserArray=[userInfo valueForKey:@"UserInfo"];
            
            NSMutableArray*resultArray=[NSMutableArray array];
            
            
            if (tempUserArray>0) {
                
                for (int i=0; i<tempUserArray.count; i++) {
                    
                    NSMutableDictionary*tempDic=[tempUserArray objectAtIndex:i];
                    
                     NSMutableDictionary*resultDic=[NSMutableDictionary dictionary];
                    
                    [resultDic setValue:[tempDic valueForKey:@"UserInfo_Fitness"] forKey:HS2S_BODYBUILDING];
                    
                    [resultDic setValue:[tempDic valueForKey:@"UserInfo_ImpedanceMark"] forKey:HS2S_IMPEDANCE];
                    
                    [resultDic setValue:[tempDic valueForKey:@"UserInfo_Height"] forKey:HS2S_HEIGHT];
                    
                    [resultDic setValue:[tempDic valueForKey:@"UserInfo_Age"] forKey:HS2S_AGE];
                    
                    [resultDic setValue:[tempDic valueForKey:@"UserInfo_SEX"] forKey:HS2S_GENDER];
                    
                    [resultDic setValue:[tempDic valueForKey:@"UserInfo_Weight"] forKey:HS2S_WEIGTH];

                    
                    [resultDic setValue:[tempDic valueForKey:@"UserInfo_CreatTS"] forKey:HS2S_CREATE_TIME];
                    
                    
                    NSString * userIDstr  =[[NSString alloc] initWithData:[tempDic valueForKey:@"UserInfo_ID"] encoding:NSUTF8StringEncoding];
                    
                    [resultDic setValue:userIDstr forKey:HS2S_USER_ID];
                    
                    [resultArray addObject:resultDic];
                    
                }
            }
            
            
            
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                
            kMAC_KEY:mac,
            
            kTYPE_KEY:kTYPE_HS2S,
            
            kACTION_KEY:ACTION_GET_HS2S_USER_INFO,
            
            HS2S_USER_INFO_COUNT:[userInfo valueForKey:@"UserCount"],
            
            HS2S_USER_INFO_ARRAY:resultArray
            }];
            
        } DiaposeErrorBlock:^(HS2SDeviceError errorID) {
            
             [self sendHS2SErrorCode:errorID mac:mac];
            
        }];

    }
}

RCT_EXPORT_METHOD(updateUserInfo:(nonnull NSString*)mac :(nonnull NSString*)userID :(nonnull NSNumber*)createTS :(nonnull NSNumber*)weight :(nonnull NSNumber*)age :(nonnull NSNumber*)height :(nonnull NSNumber*)sex :(nonnull NSNumber*)impedanceMark :(nonnull NSNumber*)fitnessMark){
    
    if ([self getHS2SWithMac:mac] != nil) {
        
        
        HealthUser*user=[HealthUser new];
        
       
        NSData *data =[userID dataUsingEncoding:NSUTF8StringEncoding];
            
        user.hs2SUserID=data;
            
        user.createTS=[createTS integerValue];
        
        user.weight=weight;
        
        user.age=age;
        
        user.height=height;
        
        if ([sex integerValue]==0) {
            
            user.sex=UserSex_Female;
            
        }else{
            
           user.sex=UserSex_Male;
        }
        
        if ([impedanceMark integerValue]==0) {
            
            user.impedanceMark=HS2SImpedanceMark_NO;
            
        }else{
            
           user.impedanceMark=HS2SImpedanceMark_YES;
        }
        
        if ([fitnessMark integerValue]==0) {
            
            user.fitnessMark=HS2SFitnessMark_NO;
            
        }else{
            
           user.fitnessMark=HS2SFitnessMark_YES;
        }
       
        __weak typeof(self) weakSelf = self;

        [[self getHS2SWithMac:mac] commandUpdateHS2SUserInfoWithUser:user result:^(BOOL result) {
            
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                           
                       kMAC_KEY:mac,
                       
                       kTYPE_KEY:kTYPE_HS2S,
                       
                       kACTION_KEY:ACTION_UPDATE_HS2S_USER_INFO,
                       
                       HS2S_SET_RESULT:[NSNumber numberWithBool:result]
                       
                       }];
            
            
        } DiaposeErrorBlock:^(HS2SDeviceError errorID) {
            
             [self sendHS2SErrorCode:errorID mac:mac];
        }];

    }
    
}

RCT_EXPORT_METHOD(deleteUser:(nonnull NSString*)mac :(nonnull NSString*)userID){
    
    
    NSData *userIDData =[userID dataUsingEncoding:NSUTF8StringEncoding];
    
    
    __weak typeof(self) weakSelf = self;
    
    if ([self getHS2SWithMac:mac] != nil) {

        [[self getHS2SWithMac:mac]commandDeleteHS2SUserWithUserID:userIDData result:^(BOOL result) {
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                      
                                  kMAC_KEY:mac,
                                  
                                  kTYPE_KEY:kTYPE_HS2S,
                                  
                                  kACTION_KEY:ACTION_DELETE_HS2S_USER,
                                  
                                  HS2S_SET_RESULT:[NSNumber numberWithBool:result]
                                  
                                  }];
            
        } DiaposeErrorBlock:^(HS2SDeviceError errorID) {
            
             [self sendHS2SErrorCode:errorID mac:mac];
        }];

    }
}

RCT_EXPORT_METHOD(getMemoryDataCount:(nonnull NSString*)mac :(nonnull NSString*)userID){
    
    
    NSData *userIDData =[userID dataUsingEncoding:NSUTF8StringEncoding];
    
     __weak typeof(self) weakSelf = self;
    
    if ([self getHS2SWithMac:mac] != nil) {

        [[self getHS2SWithMac:mac]commandGetHS2SMemoryDataCountWithUserID:userIDData memoryCount:^(NSNumber *count) {
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                 
                                             kMAC_KEY:mac,
                                             
                                             kTYPE_KEY:kTYPE_HS2S,
                                             
                                             kACTION_KEY:ACTION_GET_HS2S_MEMORY_COUNT,
                                             
                                             MEMORY_COUNT:count
                                             
                                             }];
            
        } DiaposeErrorBlock:^(HS2SDeviceError errorID) {
            
             [self sendHS2SErrorCode:errorID mac:mac];
        }];

    }
}

RCT_EXPORT_METHOD(getMemoryData:(nonnull NSString*)mac :(nonnull NSString*)userID){
    
    
    NSData *userIDData =[userID dataUsingEncoding:NSUTF8StringEncoding];
    
     __weak typeof(self) weakSelf = self;
    
    if ([self getHS2SWithMac:mac] != nil) {

        [[self getHS2SWithMac:mac]commandGetHS2SMemoryDataWithUserID:userIDData memoryData:^(NSArray *data) {
            
            
            
            NSMutableArray*resultArray=[NSMutableArray array];
            
            
            if (data>0) {
                
                for (int i=0; i<data.count; i++) {
                    
                    NSMutableDictionary*tempDic=[data objectAtIndex:i];
                    
                     NSMutableDictionary*resultDic=[NSMutableDictionary dictionary];
                    
                    [resultDic setValue:[tempDic valueForKey:@"UserInfo_Fitness"] forKey:HS2S_BODYBUILDING];
                    
                    [resultDic setValue:[tempDic valueForKey:@"UserInfo_ImpedanceMark"] forKey:HS2S_IMPEDANCE];
                    
                    [resultDic setValue:[tempDic valueForKey:@"UserInfo_Height"] forKey:HS2S_HEIGHT];
                    
                    [resultDic setValue:[tempDic valueForKey:@"UserInfo_Age"] forKey:HS2S_AGE];
                    
                    [resultDic setValue:[tempDic valueForKey:@"UserInfo_SEX"] forKey:HS2S_GENDER];
                    
//                    [resultDic setValue:[tempDic valueForKey:@"UserInfo_Weight"] forKey:HS2S_WEIGTH];
                    
                     [resultDic setValue:[tempDic valueForKey:@"HS2SWeigthResult"] forKey:HS2S_WEIGTH];
                    
                    NSDate *tempDate =[tempDic valueForKey:@"HS2SMeasureTS"];
                    
                                                 
                    NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
                                                 
                                                
                    [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                                                                       
                                                 
                    NSString *dateStr = [mydateFormatter stringFromDate:tempDate];
                    
                    [resultDic setValue:dateStr forKey:HS2S_MEASURE_TIME];
                    
                    [resultDic setValue:[tempDic valueForKey:@"HS2SBodyWeightFlag"] forKey:HS2S_INSTRUCTION_TYPE];
                    
                    if ([[tempDic valueForKey:@"HS2SBodyWeightFlag"] intValue]==1) {
                        
                        
                        [resultDic setValue:[tempDic valueForKey:@"HS2SFatWeight"] forKey:HS2S_FAT_WEIGHT];
                        
                        [resultDic setValue:[tempDic valueForKey:@"HS2SFatControl"] forKey:HS2S_FAT_CONTROL];
                        
                        [resultDic setValue:[tempDic valueForKey:@"HS2SWeightControl"] forKey:HS2S_WEIGHT_CONTROL];
                        
                        [resultDic setValue:[tempDic valueForKey:@"HS2SStandardWeight"] forKey:HS2S_STANDARD_WEIGHT];
                        
                        [resultDic setValue:[tempDic valueForKey:@"HS2SSkeletalMuscle"] forKey:HS2S_STANDARD_WEIGHT];
                        
                         [resultDic setValue:[tempDic valueForKey:@"HS2SBodyWaterPercentAge"] forKey:HS2S_BODY_WATER_RATE];
                        
                         [resultDic setValue:[tempDic valueForKey:@"HS2SMuscle"] forKey:HS2S_MUSCLE_MASS];
                        
                         [resultDic setValue:[tempDic valueForKey:@"HS2SMuscleControl"] forKey:HS2S_MUSCLE_CONTROL];
                        
                         [resultDic setValue:[tempDic valueForKey:@"HS2SProteinPercentAge"] forKey:HS2S_PHYSICAL_AGE];
                        
                        [resultDic setValue:[tempDic valueForKey:@"HS2SVFR"] forKey:HS2S_VISCERAL_FAT_GRADE];
                        
                        [resultDic setValue:[tempDic valueForKey:@"HS2SResultBodyFatPercentAge"] forKey:HS2S_BODY_FIT_PERCENTAGE];
                        
                        [resultDic setValue:[tempDic valueForKey:@"HS2SBoneMineral"] forKey:HS2S_BONE_SALT_CONTENT];

                        
                    }
                    
                    [resultArray addObject:resultDic];
                    
                }
            }
            
            
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                            
                                                        kMAC_KEY:mac,
                                                        
                                                        kTYPE_KEY:kTYPE_HS2S,
                                                        
                                                        kACTION_KEY:ACTION_GET_HS2S_MEMORY_DATA,
                                                        
                                                        MEMORY_DATA:resultArray
                                                        
                                                        }];
            
        } DiaposeErrorBlock:^(HS2SDeviceError errorID) {
            
             [self sendHS2SErrorCode:errorID mac:mac];
            
        }];

    }
}

RCT_EXPORT_METHOD(deleteMemoryData:(nonnull NSString*)mac :(nonnull NSString*)userID){
    
    
    NSData *userIDData =[userID dataUsingEncoding:NSUTF8StringEncoding];
    
     __weak typeof(self) weakSelf = self;
    
    if ([self getHS2SWithMac:mac] != nil) {

        [[self getHS2SWithMac:mac]commandDeleteHS2SMemoryDataWithUserID:userIDData result:^(BOOL result) {
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                 
                                             kMAC_KEY:mac,
                                             
                                             kTYPE_KEY:kTYPE_HS2S,
                                             
                                             kACTION_KEY:ACTION_DELETE_HS2S_MEMORY_DATA,
                                             
                                             HS2S_SET_RESULT:[NSNumber numberWithBool:result]
                                             
                                             }];
            
        } DiaposeErrorBlock:^(HS2SDeviceError errorID) {
            
             [self sendHS2SErrorCode:errorID mac:mac];
            
        }];

    }
}

RCT_EXPORT_METHOD(getAnonymousMemoryDataCount:(nonnull NSString*)mac){
    
    __weak typeof(self) weakSelf = self;
    
    if ([self getHS2SWithMac:mac] != nil) {

        [[self getHS2SWithMac:mac]commandGetHS2SAnonymousMemoryDataCount:^(NSNumber *count) {
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                            
                                                        kMAC_KEY:mac,
                                                        
                                                        kTYPE_KEY:kTYPE_HS2S,
                                                        
                                                        kACTION_KEY:ACTION_GET_HS2S_ANONYMOUS_MEMORY_COUNT,
                                                        
                                                        MEMORY_COUNT:count
                                                        
                                                        }];
            
        } DiaposeErrorBlock:^(HS2SDeviceError errorID) {
            
             [self sendHS2SErrorCode:errorID mac:mac];
            
        }];

    }
}

RCT_EXPORT_METHOD(getAnonymousMemoryData:(nonnull NSString*)mac){
    
    
     __weak typeof(self) weakSelf = self;
    

    if ([self getHS2SWithMac:mac] != nil) {

        [[self getHS2SWithMac:mac]commandGetHS2SAnonymousMemoryData:^(NSArray *data) {
            
            
            NSMutableArray*resultArray=[NSMutableArray array];
                      
                      
                      if (data>0) {
                          
                          for (int i=0; i<data.count; i++) {
                              
                              NSMutableDictionary*tempDic=[data objectAtIndex:i];
                              
                               NSMutableDictionary*resultDic=[NSMutableDictionary dictionary];
                              
                              
                              NSDate *tempDate =[tempDic valueForKey:@"HS2SMeasureTS"];
 
                              NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
                              
                              [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                                                    
                              NSString *dateStr = [mydateFormatter stringFromDate:tempDate];
                              
                              [resultDic setValue:[tempDic valueForKey:@"HS2SWeigthResult"] forKey:HS2S_WEIGTH];
                              
                              [resultDic setValue:dateStr forKey:HS2S_MEASURE_TIME];

                              [resultArray addObject:resultDic];
                              
                          }
                      }
            
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                       
                                                                   kMAC_KEY:mac,
                                                                   
                                                                   kTYPE_KEY:kTYPE_HS2S,
                                                                   
                                                                   kACTION_KEY:ACTION_GET_HS2S_ANONYMOUS_MEMORY_DATA,
                                                                   
                                                                   MEMORY_DATA:resultArray
                                                                   
                                                                   }];
            
        } DiaposeErrorBlock:^(HS2SDeviceError errorID) {
            
             [self sendHS2SErrorCode:errorID mac:mac];
            
        }];

    }
}

RCT_EXPORT_METHOD(deleteAnonymousMemoryData:(nonnull NSString*)mac){
    
    __weak typeof(self) weakSelf = self;
    

    if ([self getHS2SWithMac:mac] != nil) {

        [[self getHS2SWithMac:mac]commandDeleteHS2SAnonymousMemoryData:^(BOOL result) {
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                
            kMAC_KEY:mac,
            
            kTYPE_KEY:kTYPE_HS2S,
            
            kACTION_KEY:ACTION_DELETE_HS2S_ANONYMOUS_MEMORY_DATA,
            
            HS2S_SET_RESULT:[NSNumber numberWithBool:result]
            
            }];
            
        } DiaposeErrorBlock:^(HS2SDeviceError errorID) {
            
             [self sendHS2SErrorCode:errorID mac:mac];
            
        }];

    }
}

RCT_EXPORT_METHOD(measure:(nonnull NSString*)mac :(nonnull NSNumber*)userType :(nonnull NSString*)userID :(nonnull NSNumber*)createTS :(nonnull NSNumber*)weight :(nonnull NSNumber*)age :(nonnull NSNumber*)height :(nonnull NSNumber*)sex :(nonnull NSNumber*)impedanceMark :(nonnull NSNumber*)fitnessMark){
    

    if ([self getHS2SWithMac:mac] != nil) {
        
        
        HealthUser*user=[HealthUser new];
        
        
        if ([userType integerValue]==0) {
            
            user.userType=UserType_Guest;
            
        }else{
            
           user.userType=UserType_Normal;
        }
        
              
               NSData *data =[userID dataUsingEncoding:NSUTF8StringEncoding];
        
                   
               user.hs2SUserID=data;
                   
               user.createTS=[createTS integerValue];
               
               user.weight=weight;
               
               user.age=age;
               
               user.height=height;
               
               if ([sex integerValue]==0) {
                   
                   user.sex=UserSex_Female;
                   
               }else{
                   
                  user.sex=UserSex_Male;
               }
               
               if ([impedanceMark integerValue]==0) {
                   
                   user.impedanceMark=HS2SImpedanceMark_NO;
                   
               }else{
                   
                  user.impedanceMark=HS2SImpedanceMark_YES;
               }
               
               if ([fitnessMark integerValue]==0) {
                   
                   user.fitnessMark=HS2SFitnessMark_NO;
                   
               }else{
                   
                  user.fitnessMark=HS2SFitnessMark_YES;
               }
              

        [[self getHS2SWithMac:mac]commandStartHS2SMeasureWithUser:user weight:^(NSNumber *unStableWeight) {
            
             NSDictionary *deviceInfo = @{kMAC_KEY:mac,kTYPE_KEY:kTYPE_HS2S,kACTION_KEY:ACTION_HS2S_ONLINE_DATA,HS2S_WEIGTH:unStableWeight};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } stableWeight:^(NSNumber *stableWeight) {
            
             NSDictionary *deviceInfo =@{kMAC_KEY:mac,kTYPE_KEY:kTYPE_HS2S,kACTION_KEY:ACTION_HS2S_ONLINE_RESULT,HS2S_WEIGTH:stableWeight };
         
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } weightAndBodyInfo:^(NSDictionary *weightAndBodyInfoDic) {
            
        NSMutableDictionary*resultDic=[NSMutableDictionary dictionary];
        
        [resultDic setValue:[weightAndBodyInfoDic valueForKey:@"UserInfo_Fitness"] forKey:HS2S_BODYBUILDING];
        
        [resultDic setValue:[weightAndBodyInfoDic valueForKey:@"UserInfo_ImpedanceMark"] forKey:HS2S_IMPEDANCE];
        
        [resultDic setValue:[weightAndBodyInfoDic valueForKey:@"UserInfo_Height"] forKey:HS2S_HEIGHT];
        
        [resultDic setValue:[weightAndBodyInfoDic valueForKey:@"UserInfo_Age"] forKey:HS2S_AGE];
        
        [resultDic setValue:[weightAndBodyInfoDic valueForKey:@"UserInfo_SEX"] forKey:HS2S_GENDER];
        
        [resultDic setValue:[weightAndBodyInfoDic valueForKey:@"HS2SWeigthResult"] forKey:HS2S_WEIGTH];
            
        NSDate *tempDate =[weightAndBodyInfoDic valueForKey:@"HS2SMeasureTS"];
        
                            
        NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
                                     
        [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                                                           
        NSString *dateStr = [mydateFormatter stringFromDate:tempDate];
                                     
        
        [resultDic setValue:dateStr forKey:HS2S_MEASURE_TIME];
        
        [resultDic setValue:[weightAndBodyInfoDic valueForKey:@"HS2SBodyWeightFlag"] forKey:HS2S_INSTRUCTION_TYPE];
        
        if ([[weightAndBodyInfoDic valueForKey:@"HS2SBodyWeightFlag"] intValue]==1) {
            
            
            [resultDic setValue:[weightAndBodyInfoDic valueForKey:@"HS2SFatWeight"] forKey:HS2S_FAT_WEIGHT];
            
            [resultDic setValue:[weightAndBodyInfoDic valueForKey:@"HS2SFatControl"] forKey:HS2S_FAT_CONTROL];
            
            [resultDic setValue:[weightAndBodyInfoDic valueForKey:@"HS2SWeightControl"] forKey:HS2S_WEIGHT_CONTROL];
            
            [resultDic setValue:[weightAndBodyInfoDic valueForKey:@"HS2SStandardWeight"] forKey:HS2S_STANDARD_WEIGHT];
            
            [resultDic setValue:[weightAndBodyInfoDic valueForKey:@"HS2SSkeletalMuscle"] forKey:HS2S_STANDARD_WEIGHT];
            
             [resultDic setValue:[weightAndBodyInfoDic valueForKey:@"HS2SBodyWaterPercentAge"] forKey:HS2S_BODY_WATER_RATE];
            
             [resultDic setValue:[weightAndBodyInfoDic valueForKey:@"HS2SMuscle"] forKey:HS2S_MUSCLE_MASS];
            
             [resultDic setValue:[weightAndBodyInfoDic valueForKey:@"HS2SMuscleControl"] forKey:HS2S_MUSCLE_CONTROL];
            
             [resultDic setValue:[weightAndBodyInfoDic valueForKey:@"HS2SProteinPercentAge"] forKey:HS2S_PHYSICAL_AGE];
            
            [resultDic setValue:[weightAndBodyInfoDic valueForKey:@"HS2SVFR"] forKey:HS2S_VISCERAL_FAT_GRADE];
            
            [resultDic setValue:[weightAndBodyInfoDic valueForKey:@"HS2SResultBodyFatPercentAge"] forKey:HS2S_BODY_FIT_PERCENTAGE];
            
            [resultDic setValue:[weightAndBodyInfoDic valueForKey:@"HS2SBoneMineral"] forKey:HS2S_BONE_SALT_CONTENT];

            
        }
                               
            
            NSDictionary *deviceInfo =@{kMAC_KEY:mac,kTYPE_KEY:kTYPE_HS2S,kACTION_KEY:ACTION_HS2S_BODYFAT_RESULT,HS2S_DATA_BODY_FAT_RESULT:resultDic };
            
               [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
            
        } disposeHS2SMeasureFinish:^{
            
            NSDictionary *deviceInfo =@{kMAC_KEY:mac,kTYPE_KEY:kTYPE_HS2S,kACTION_KEY:ACTION_HS2S_MEASURE_FINISH};
            
               [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } DiaposeErrorBlock:^(HS2SDeviceError errorID) {
            
             [self sendHS2SErrorCode:errorID mac:mac];
            
        }];

    }
}


RCT_EXPORT_METHOD(resetDevice:(nonnull NSString*)mac){
    
    
    __weak typeof(self) weakSelf = self;
    

    if ([self getHS2SWithMac:mac] != nil) {

        [[self getHS2SWithMac:mac]commandResetHS2SDevice:^(BOOL result) {
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                
            kMAC_KEY:mac,
            
            kTYPE_KEY:kTYPE_HS2S,
            
            kACTION_KEY:ACTION_HS2S_RESET_DEVICE,
            
            HS2S_SET_RESULT:[NSNumber numberWithBool:result]
            
            }];
            
        } DiaposeErrorBlock:^(HS2SDeviceError errorID) {
            
             [self sendHS2SErrorCode:errorID mac:mac];
            
        }];

    }
}

//RCT_EXPORT_METHOD(broadCastTypeDevice:(nonnull NSString*)mac){
//
//
//    __weak typeof(self) weakSelf = self;
//
//
//    if ([self getHS2SWithMac:mac] != nil) {
//
//        [[self getHS2SWithMac:mac]commandBroadCastTypeHS2SDevice:^(BOOL result) {
//
//            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
//
//            kMAC_KEY:mac,
//
//            kTYPE_KEY:kTYPE_HS2S,
//
//            kACTION_KEY:ACTION_BroadCastType_DEVICE,
//
//            HS2S_SET_RESULT:[NSNumber numberWithBool:result]
//
//            }];
//
//        } DiaposeErrorBlock:^(HS2SDeviceError errorID) {
//
//             [self sendHS2SErrorCode:errorID mac:mac];
//
//        }];
//
//    }
//}


RCT_EXPORT_METHOD(setDeviceLightUp:(nonnull NSString*)mac){
    
    
    __weak typeof(self) weakSelf = self;
    

    if ([self getHS2SWithMac:mac] != nil) {
        
        
        [[self getHS2SWithMac:mac] commandSetHS2SDeviceLightUp:^(BOOL result) {
             [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                           
                       kMAC_KEY:mac,
                       
                       kTYPE_KEY:kTYPE_HS2S,
                       
                       kACTION_KEY:ACTION_HS2S_LightUp_DEVICE,
                       
                       HS2S_SET_RESULT:[NSNumber numberWithBool:result]
                       
                       }];
        } DiaposeErrorBlock:^(HS2SDeviceError errorID) {
            
              [self sendHS2SErrorCode:errorID mac:mac];
            
        }];


    }
}


RCT_EXPORT_METHOD(enterHS2SHeartRateMeasurementMode:(nonnull NSString*)mac){
    
    
    __weak typeof(self) weakSelf = self;
    

    if ([self getHS2SWithMac:mac] != nil) {
        
        
        [[self getHS2SWithMac:mac] commandEnterHS2SHeartRateMeasurementMode:^(NSDictionary *heartResultDic) {
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                      
                                  kMAC_KEY:mac,
                                  
                                  kTYPE_KEY:kTYPE_HS2S,
                                  
                                  kACTION_KEY:ACTION_HS2S_MEASURE_HEARTRATE,
                                  
                                  HS2S_MEASURE_HEARTRATE_RESULT:heartResultDic
                                  
                                  }];
            
        } measurementStatus:^(NSNumber *measurementStatus) {
            
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                      
                                  kMAC_KEY:mac,
                                  
                                  kTYPE_KEY:kTYPE_HS2S,
                                  
                                  kACTION_KEY:ACTION_HS2S_MEASURE_HEARTRATE_DEVICE_STATUS,
                                  
                                  HS2S_DEVICE_STATUS:measurementStatus
                                  
                                  }];
            
        } DiaposeErrorBlock:^(HS2SDeviceError errorID) {
            
             [self sendHS2SErrorCode:errorID mac:mac];
            
        }];


    }
}


RCT_EXPORT_METHOD(exitHS2SHeartRateMeasurementMode:(nonnull NSString*)mac){
    
    
    __weak typeof(self) weakSelf = self;
    

    if ([self getHS2SWithMac:mac] != nil) {
        
        
        [[self getHS2SWithMac:mac] commandExitHS2SHeartRateMeasurementMode:^(BOOL result) {
            
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                
            kMAC_KEY:mac,
            
            kTYPE_KEY:kTYPE_HS2S,
            
            kACTION_KEY:ACTION_HS2S_EXIT_MEASURE_HEARTRATE_STATUS,
            
            HS2S_SET_RESULT:[NSNumber numberWithBool:result]
            
            }];
            
        } DiaposeErrorBlock:^(HS2SDeviceError errorID) {
            
            
            [self sendHS2SErrorCode:errorID mac:mac];
            
        }];


    }
}




-(void)sendHS2SErrorCode:(HS2SDeviceError)errorID mac:(NSString*)mac{
    
    
                NSString *errorMassage = [NSString string];
                switch (errorID) {
                    case 0:
                         errorMassage = @"HS2SDeviceError_CommunicationTimeout";
                        break;
                    case 1:
                        errorMassage = @"HS2SDeviceError_ReceivedCommandError";
                        break;
                    case 2:
                         errorMassage = @"HS2SDeviceError_InputParameterError";
                        break;
                    case 3:
                        errorMassage = @"HS2SDeviceError_MoreThanMaxNumbersOfUser";
                        break;
                    case 4:
                        errorMassage = @"HS2SDeviceError_WriteFlashError";
                        break;
                    case 5:
                         errorMassage = @"HS2SDeviceError_UserNotExist";
                        break;
                    case 6:
                        errorMassage = @"HS2SDeviceError_StartMeasureError";
                        break;
                    case 7:
                        errorMassage = @"HS2SDeviceError_MeasureTimeout";
                        break;
                    case 8:
                       errorMassage = @"HS2SDeviceError_MeasureOverweight";
                        break;
                        
                    case 9:
                        errorMassage = @"HS2SDeviceError_Disconnect";
                        break;
                    case 10:
                        errorMassage = @"HS2SDeviceError_Unsupported";
                       break;

                    default:
                        break;
                }
    
                NSDictionary *deviceInfo = @{kMAC_KEY:mac,kACTION_KEY:ACTION_ERROR_HS,ERROR_NUM_HS:errorMassage};
                [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
    
    
}

RCT_EXPORT_METHOD(disconnect:(nonnull NSString*)mac){
    if ([self getHS2SWithMac:mac] != nil){
        
        [[self getHS2SWithMac:mac]commandDisconnectDevice];
        NSLog(@"End device connnect!");
        
    }else{
        
    }
}


- (void)sendEventWithAction:(NSString*)actionName keyString:(NSString*)key valueString:(id)value{
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{kACTION_KEY:actionName,key:value}];
}

@end

