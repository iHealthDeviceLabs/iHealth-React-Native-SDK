//
//  BG1Module.m
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2016/11/23.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import "BG1Module.h"
#import "BG1ProfileModule.h"
#import "BGMacroFile.h"
#import "BG1Controller.h"
#import "BG1.h"
#define EVENT_NOTIFY @"event_notify_bg1"

@implementation BG1Module

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE()

- (NSDictionary *)constantsToExport
{
    return @{
             @"Event_Notify":@"event_notify_bg1",
             
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
        
        [BG1Controller shareBG1Controller];
        
    }
    return self;
}



-(BG1*)getBG1Instance{
    
    BG1Controller *controller = [BG1Controller shareBG1Controller];
    BG1 *bg1Instance = [controller getCurrentBG1Instance];
    if(bg1Instance != nil)
    {
        return bg1Instance;
    }
    else
    {
        return nil;
    }
    
}


#pragma mark
#pragma mark - Method


RCT_EXPORT_METHOD(sendCode:(nonnull NSString *)QR:(nonnull NSNumber *)codeType:(nonnull NSNumber *)testType){
    
    
    if ([self getBG1Instance]!=nil) {
        
        if (QR ==nil || QR.length<30) {
            NSDictionary* deviceInfo = @{@"mac":@"",@"action":@"action_measure_error_for_bg1",@"action_measure_error_for_bg1":@400,@"description":@"Parameter input error."};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
            return;
        }
        
        NSDictionary *codeDic = [[self getBG1Instance]codeStripStrAnalysis:QR];
        NSNumber *bottleID = [codeDic objectForKey:@"bottleId"];
        NSDate *dueDate = [codeDic objectForKey:@"overDate"];
        NSNumber *remainNum = [codeDic objectForKey:@"stripNum"];
        
        BGMeasureMode bgMeasureModel = BGMeasureMode_Blood;
        if(codeType.integerValue == 2)
        {
            bgMeasureModel = BGMeasureMode_NoBlood;
        }
        
        BGCodeMode bgCodeModel =BGCodeMode_GOD;
        if(codeType.integerValue == 2)
        {
            bgCodeModel = BGCodeMode_GDH;
        }
        [[self getBG1Instance] commandBG1MeasureMode:bgMeasureModel withCodeMode:bgCodeModel withCodeString:QR withSendCodeResultBlock:^{
            
            NSDictionary* deviceInfo = @{@"mac":@"",@"action":@"action_sendcode_result_for_bg1",@"set_bottle_message":@true};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } withStripInBlock:^{
            
            NSDictionary* deviceInfo = @{@"mac":@"",@"action":@"action_measure_strip_in_for_bg1"};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } withBloodBlock:^{
            
            NSDictionary* deviceInfo = @{@"mac":@"",@"action":@"action_measure_get_blood_for_bg1"};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } withResultBlock:^(NSDictionary *result) {
            
            NSDate *measureDate = [result objectForKey:@"Date"];
            
            //将时间格式转化成字符串，适配plugin和react native
            NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
            [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *dateStr = [mydateFormatter stringFromDate:measureDate];
            
            NSDictionary *resultDic = [NSDictionary dictionaryWithObjectsAndKeys:dateStr,@"date",[result objectForKey:@"Result"],@"value",[result objectForKey:@"dataID"],@"dataID", nil];
            
            NSDictionary* deviceInfo = @{@"mac":@"",@"action":@"action_measure_result_for_bg1",@"result":resultDic};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } withStripOutBlock:^{
            
            NSDictionary* deviceInfo = @{@"mac":@"",@"action":@"action_measure_strip_out_for_bg1"};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } withErrorBlock:^(BG1Error errorID) {
            
            
            NSString *descriptionStr = @"";
            
            switch (errorID) {
                case BG1Error_LowBattery:
                    descriptionStr=@"Battery is low.";
                    break;
                case BG1Error_ResultOutOfMeasurementRage:
                    descriptionStr=@"Glucose test result is out of the measurement range.";
                    break;
                case BG1Error_UnvalidReferenceVoltage:
                    descriptionStr=@"2.5V reference voltage error, not normal measurement, please repeat the test.";
                    break;
                case BG1Error_StripUsed:
                    descriptionStr=@"Strip is used or unknown moisture detected, discard the test strip and repeat the test with a new strip.";
                    break;
                case BG1Error_CodeError:
                    descriptionStr=@"CODE value check error. This error need let user scan code and call the send code function again,no alert need to show.";
                    break;
                case BG1Error_RoomTemperatureOutOfRange1:
                case BG1Error_RoomTemperatureOutOfRange2:
                    descriptionStr=@"The environmental temperature is beyond normal range, place the meter at room temperature for at least 30 minutes, then repeat the test.";
                    break;
                case BG1Error_ResultLow:
                    descriptionStr=@"Glucose test result is low.";
                    break;
                case BG1Error_ResultHigh:
                    descriptionStr=@"Glucose test result is high.";
                    break;
                case BG1Error_DisConnented:
                    descriptionStr=@"BG disConnented.";
                    break;
                case BG1Error_SleepingMode:
                    descriptionStr=@"BG sleeping mode.";
                    break;
                case BG1Error_ParameterError:
                    descriptionStr=@"Parameter input error.";
                    break;
                default:
                    descriptionStr=@"BG unknown.";
                    break;
            }
            
            NSDictionary* deviceInfo = @{@"mac":@"",@"action":@"action_measure_error_for_bg1",@"action_measure_error_for_bg1":[NSNumber numberWithInt:errorID],@"description":descriptionStr};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        }];
        
       
        
                
        
    }else{
        
        NSDictionary* deviceInfo = @{@"mac":@"",@"action":@"action_measure_error_for_bg1",@"action_measure_error_for_bg1":@100,@"description":@"BG disConnented." };
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        
    }
    
}





RCT_EXPORT_METHOD(getBottleInfoFromQR:(nonnull NSString *)QR){
    
    
    if ([self getBG1Instance]!=nil) {
        
        NSDictionary *codeDic = [[self getBG1Instance]codeStripStrAnalysis:QR];
        NSDate *tempDate = [codeDic objectForKey:@"DueDate"];
        
        //将时间格式转化成字符串，适配plugin和react native
        NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
        [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSTimeZone *dongBaTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*60*60];
        [mydateFormatter setTimeZone:dongBaTimeZone];
        NSString *dateStr = [mydateFormatter stringFromDate:tempDate];
        
        NSNumber *bottleID = [codeDic objectForKey:@"BottleID"];
        NSNumber *remainNum = [codeDic objectForKey:@"StripNum"];
        
        NSDictionary* deviceInfo = @{@"mac":@"",@"action":@"action_code_analysis_bg",@"stripNum":remainNum,@"overDate":dateStr,@"bottleId":bottleID};
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        
    }else{
        
        NSDictionary* deviceInfo = @{@"mac":@"",@"action":@"action_measure_error_for_bg1",@"action_measure_error_for_bg1":@100,@"description":@"BG disConnented."};
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        
    }
    
}


@end
