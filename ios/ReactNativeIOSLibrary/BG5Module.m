//
//  BG5Module.m
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2016/11/23.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import "BG5Module.h"
#import "BGProfileModule.h"
#import "BGMacroFile.h"
#import "BG5Controller.h"
#import "BG5.h"

#define EVENT_NOTIFY    @"event_notify_bg5"
#define kMAC_KEY        @"mac"
#define kACTION_KEY     @"action"

@interface BG5Module()

/**
 保存设备回复的开机模式
 */
@property (assign, nonatomic) NSInteger deviceSelectedOpenMode;

/**
 保存用户传入的测量模式
 */
@property (assign, nonatomic) NSInteger userSelectedMeasureMode;

@end

@implementation BG5Module

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE()

- (NSDictionary *)constantsToExport{
    return @{
             @"Event_Notify":EVENT_NOTIFY,
             };
}
+ (BOOL)requiresMainQueueSetup
{
    return YES;
}
#pragma mark - Objc Method
-(id)init{
    self = [super init];
    if (self) {
        [BG5Controller shareIHBg5Controller];
        self.deviceSelectedOpenMode = 0;// 初始化时，将开机模式设置为0；目的是，在用户调用开始测量方法时，判断用户是否已经调用过发码方法。调用过发码方法后，openMode的值是1或2
        self.userSelectedMeasureMode = 0;// 初始化时，将开机模式设置为0；目的是，在用户调用开始测量方法时，判断用户发码时传入的测量模式 是否等于 开始测量传入的测量模式
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clear) name:BG5DisConnectNoti object:nil];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)clear{
    self.deviceSelectedOpenMode = 0;
    self.userSelectedMeasureMode = 0;
}

/**
 返回传入的Mac地址对应的BG5对象

 @param mac mac地址，需要完整的mac地址
 @return BG5对象;如果没有匹配mac地址的BG5对象，那么返回nil
 */
-(BG5*)getDeviceWithMac:(NSString*)mac{
    
    BG5Controller *controller = [BG5Controller shareIHBg5Controller];
    NSArray *BGDeviceArray = [controller getAllCurrentBG5Instace];
    NSLog(@"%@",BGDeviceArray);
    for(BG5 *tempBG5 in BGDeviceArray){
        if([mac isEqualToString:tempBG5.serialNumber]){
            return tempBG5;
        }
    }
    return nil;
}

- (void)sendMeasureErrorEventWithMac:(NSString *)mac errorId:(NSNumber *)errorId{
    
    
    NSString *errorDescription = @"";
    
    switch (errorId.integerValue) {
        case 0:
            errorDescription = @"Battery is low.";
            break;
        case 1:
            errorDescription = @"Glucose test result is out of the measurement range.";
            break;
        case 2:
            errorDescription = @"Unknown interference detected, please repeat the test.";
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
            errorDescription = @"Test strip coding error.";
            break;
        case 8:
            errorDescription = @"Communication error, press \"START\" or rescan the code to repeat the test.";
            break;
        case 9:
            errorDescription = @"Strip removed in the middle of reading, repeat the test with a new strip.";
            break;
        case 10:
            errorDescription = @"Insert a new test strip and repeat the test.";
            break;
        case 11:
            errorDescription = @"Cannot write to SN or KEY.";
            break;
        case 12:
            errorDescription = @"Please set time.";
            break;
        case 13:
            errorDescription = @"0 test strips remaining.";
            break;
        case 14:
            errorDescription = @"Test strip expired.";
            break;
        case 15:
            errorDescription = @"Unplug the charging cable before testing.";
            break;
        case 18:
            errorDescription = @"Unplug the charging cable before read the history data";
            break;
        case 19:
            errorDescription = @"Charging line is inserted";
            break;
        case 20:
            errorDescription = @"Charging line pull out";
            break;
        case 21:
            errorDescription = @"The bluetooth module failure";
            break;
        case 22:
            errorDescription = @"Need to set time at first.";
            break;
        case 30:
            errorDescription = @"BG Over Time Error.";
            break;
        case 112:
            errorDescription = @"Device don't support to query energy.";
            break;
        case RNBGError_InputParameterError:
            errorDescription = @"Parameters out of range.";
            break;
        case RNBGError_FunctionCallOrderError:
            errorDescription = @"The order of call is wrong.";
            break;
        case RNBGError_MeasureModeNotMatched:
            errorDescription = @"Measure Mode is not matched in fucntion call (setBottleMessageWithInfo and startMeasure)";
            break;
        case RNBGError_DisconnectFunctionNotSupportIniOSPlatform:
            errorDescription = @"Function(disConnect) is not supported in iOS platform.";
            break;
        case RNBGError_getBottleInfoFromQRFunctionInpurParameterError:
            errorDescription = @"Function(getBottleInfoFromQR) Input Parameter Error";
            break;
        default:
            break;
    }
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                             kMAC_KEY:mac,
                                                                             kACTION_KEY:kACTION_ERROR_BG,
                                                                             kERROR_NUM_BG:errorId,
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
                                                                                 kERROR_NUM_BG:@100
                                                                                 }];
    }
    
}

- (void)sendInputParameterErrorEventWithMac:(NSString *)mac{
    if (mac && mac.length > 0) {
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                                 kMAC_KEY:mac,
                                                                                 kACTION_KEY:kACTION_ERROR_BG,
                                                                                 kERROR_NUM_BG:@400,
                                                                                 kERROR_DESCRIPTION_BG:@"Parameters out of range."
                                                                                 }];
    } else {
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                                 kACTION_KEY:kACTION_ERROR_BG,
                                                                                 kERROR_NUM_BG:@400,
                                                                                 kERROR_DESCRIPTION_BG:@"Parameters out of range."
                                                                                 }];
    }
    
}

#pragma mark - Objc method for BG5Module.js function

#pragma mark-获取连接设备
RCT_EXPORT_METHOD(getAllConnectedDevices){
    
    
    NSArray*bg5array= [[BG5Controller shareIHBg5Controller] getAllCurrentBG5Instace];
    
    NSMutableArray*deviceMacArray=[NSMutableArray array];
    
    for (int i=0; i<[bg5array count]; i++) {
        
        BG5*bg5=[bg5array objectAtIndex:i];
        
        [deviceMacArray addObject:bg5.serialNumber];
        
    }
    
    NSDictionary* deviceInfo = @{kACTION_KEY:@"ACTION_GET_ALL_CONNECTED_DEVICES",@"devices":deviceMacArray};
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
    
    
}

#pragma mark 保持连接
RCT_EXPORT_METHOD(holdLink:(nonnull NSString *)mac){

    if ([self getDeviceWithMac:mac]) {
        __weak typeof(self) weakSelf = self;
        [[self getDeviceWithMac:mac] commandKeepConnect:^(BOOL sendOk) {
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                        kMAC_KEY:mac,
                                                        kACTION_KEY:kACTION_KEEP_LINK,
                                                        }];
        } DisposeErrorBlock:^(NSNumber *errorID) {
            [weakSelf sendMeasureErrorEventWithMac:mac errorId:errorID];
        }];
    }else{
        [self sendNoMatchedDeviceEventWithMac:mac];
    }
}

#pragma mark 获得电池电量
RCT_EXPORT_METHOD(getBattery:(nonnull NSString *)mac){

    if ([self getDeviceWithMac:mac]) {
        __weak typeof(self) weakSelf = self;
        [[self getDeviceWithMac:mac] commandQueryBattery:^(NSNumber *energy) {
            NSLog(@"电量");
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                            kMAC_KEY:mac,
                                                            kACTION_KEY:kACTION_GET_BATTERY,
                                                            kGET_BATTERY:energy
                                                            }];
            
        } DisposeErrorBlock:^(NSNumber *errorID) {
            [weakSelf sendMeasureErrorEventWithMac:mac errorId:errorID];
        }];
        
    }else{
        [self sendNoMatchedDeviceEventWithMac:mac];
    }
}
#pragma mark 设置时间
RCT_EXPORT_METHOD(setTime:(nonnull NSString *)mac){
    
    
    if ([self getDeviceWithMac:mac]) {
        __weak typeof(self) weakSelf = self;
        [[self getDeviceWithMac:mac] commandBGSetTime:^(BOOL setResult) {
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                            kMAC_KEY:mac,
                                                            kACTION_KEY:kACTION_SET_TIME,
                                                            }];
        } DisposeBGErrorBlock:^(NSNumber *errorID) {
            [weakSelf sendMeasureErrorEventWithMac:mac errorId:errorID];
        }];
    }else{
        [self sendNoMatchedDeviceEventWithMac:mac];
        
    }
}

#pragma mark 设置单位
RCT_EXPORT_METHOD(setUnit:(nonnull NSString *)mac unitType:(nonnull NSNumber *)type){
#warning 下位机回复是否表示设置成功
    if ([self getDeviceWithMac:mac]) {
        
        BGUnit tempUnit = BGUnit_mmolPL;
        if ([type isEqual:@(BGUnit_mmolPL)]) {
            tempUnit = BGUnit_mmolPL;
        } else if([type isEqual:@(BGUnit_mgPmL)]) {
            tempUnit = BGUnit_mgPmL;
        } else {
            [self sendInputParameterErrorEventWithMac:mac];
            return;
        }
        __weak typeof(self) weakSelf = self;
        [[self getDeviceWithMac:mac] commandBGSetUnit:tempUnit DisposeSetUnitResult:^(BOOL setResult) {
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                        kMAC_KEY:mac,
                                                        kACTION_KEY:kACTION_SET_UNIT,
                                                        }];
            
        } DisposeBGErrorBlock:^(NSNumber *errorID) {
            
            [weakSelf sendMeasureErrorEventWithMac:mac errorId:errorID];
        }];
        
    }else{
        [self sendNoMatchedDeviceEventWithMac:mac];
    }
}

#pragma mark 获得Bottle ID
RCT_EXPORT_METHOD(getBottleId:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]) {
        __weak typeof(self) weakSelf = self;
        [[self getDeviceWithMac:mac]commandBGGetBottleID:^(NSNumber *bottleID) {
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                            kMAC_KEY:mac,
                                                            kACTION_KEY:kACTION_GET_BOTTLEID,
                                                            kGET_BOTTLEID:bottleID,
                                                            }];
            
        } DisposeBGErrorBlock:^(NSNumber *errorID) {
            [weakSelf sendMeasureErrorEventWithMac:mac errorId:errorID];
        }];
        
    }else{
        [self sendNoMatchedDeviceEventWithMac:mac];
    }
}

#pragma mark 开始测量
RCT_EXPORT_METHOD(startMeasure:(nonnull NSString *)mac measureType:(nonnull NSNumber *)measureType){
    
    
    if ([self getDeviceWithMac:mac]) {
        
        /* 优先判断输入参数的内容正确性 */
        if (![measureType isEqual: @(BGMeasureMode_Blood)] && ![measureType isEqual: @(BGMeasureMode_NoBlood)]) {
            //输入参数错误
            [self sendInputParameterErrorEventWithMac:mac];
            return;
        }
        
        /* 再检查setBottleMessageWithInfo方法中传入的测量模式和本次传入的一致一致性 */
        if (self.userSelectedMeasureMode != measureType.integerValue) {
            [self sendMeasureErrorEventWithMac:mac errorId:@(RNBGError_MeasureModeNotMatched)];
            return;
        }
        
        if (self.deviceSelectedOpenMode == 0) {
            [self sendMeasureErrorEventWithMac:mac errorId:@(RNBGError_FunctionCallOrderError)];
            return;
        }
        
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                                     kMAC_KEY:mac,
                                                                                     kACTION_KEY:kACTION_START_MEASURE,
                                                                                     }];
    }else{
        
        [self sendNoMatchedDeviceEventWithMac:mac];
    }
    
}

#pragma mark 获得离线数据
RCT_EXPORT_METHOD(getOfflineData:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]) {
        __weak typeof(self) weakSelf = self;
        [[self getDeviceWithMac:mac]commandTransferMemorryData:^(NSNumber *dataCount) {
            
            NSDictionary *deviceInfo = @{@"mac":mac,@"action":kACTION_GET_OFFLINEDATA_COUNT,kGET_OFFLINEDATA_COUNT:dataCount,@"type":@"BG5"};
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        } DisposeBGHistoryData:^(NSDictionary *historyDataDic) {
            
            NSArray *historyArr = [NSArray arrayWithArray:[historyDataDic objectForKey:@"ResultList"]];
            NSMutableArray * tempArr = [[NSMutableArray alloc]init];
            
            for(NSDictionary *history in historyArr) {
                NSDate *tempDate = [history objectForKey:@"Date"];
                
                //将时间格式转化成字符串，适配plugin和react native
                NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
                [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSString *dateStr = [mydateFormatter stringFromDate:tempDate];
                
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dateStr,@"date",[history objectForKey:@"Result"],@"value",[history objectForKey:@"dataID"],@"dataID", nil];
                
                [tempArr addObject:dic];
            }
            
            NSDictionary*hisDic=[NSDictionary dictionaryWithObjectsAndKeys:tempArr,@"history", nil];
            
            
            NSDictionary *deviceInfo = @{@"mac":mac,@"action":kACTION_GET_OFFLINEDATA,kGET_OFFLINEDATA:hisDic,@"type":@"BG5"};
            
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        } DisposeBGErrorBlock:^(NSNumber *errorID) {
            [weakSelf sendMeasureErrorEventWithMac:mac errorId:errorID];
        }];
    }else{
        [self sendNoMatchedDeviceEventWithMac:mac];
    }
}

#pragma mark 删除离线数据
RCT_EXPORT_METHOD(deleteOfflineData:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]) {
        
        [[self getDeviceWithMac:mac] commandDeleteMemorryData:^(BOOL deleteOk) {
            
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                                     kMAC_KEY:mac,
                                                                                     kACTION_KEY:kACTION_DELETE_OFFLINEDATA,
                                                                                     }];
            
        } DisposeBGErrorBlock:^(NSNumber *errorID) {
            
        }];
        
       
    }else{
        [self sendNoMatchedDeviceEventWithMac:mac];
    }
}

#pragma mark 发Code信息方法
RCT_EXPORT_METHOD(setBottleMessageWithInfo:(nonnull NSString *)mac codeMode:(nonnull NSNumber *)codeType measureMode:(nonnull NSNumber *)testType qrCode:(nonnull NSString *)qrCode stripNum:(nonnull NSNumber *)stripNum overDate:(nonnull NSString *)overDate){
    
    
    if ([self getDeviceWithMac:mac]) {
        // 检查输入参数是否合法，交给SDK的方法去做，不在原生模块中校验,但是SDK中发码方法没有校验，所以先在RN模块中校验
        if ((codeType.integerValue == BGCodeMode_GOD) || (codeType.integerValue == BGCodeMode_GDH)) {
            
        } else {
            [self sendInputParameterErrorEventWithMac:mac];
            return;
        }
        self.userSelectedMeasureMode = testType.integerValue;
        //code的截止时期是东八区的时间,String 转 Date
        NSDateFormatter *dongBaFormatter = [[NSDateFormatter alloc] init];
        NSTimeZone *dongBaTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*60*60];
        [dongBaFormatter setTimeZone:dongBaTimeZone];
        [dongBaFormatter setDateFormat:@"yyyy-MM-dd"];
        NSCalendar *canlendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [dongBaFormatter setCalendar:canlendar];
        NSDate *dueDate = [dongBaFormatter dateFromString:overDate];//过期时间
        
        NSDictionary *codeDic = [[self getDeviceWithMac:mac]codeStripStrAnalysis:qrCode];
        NSNumber *bottleID = [codeDic objectForKey:@"BottleID"];
        
        __weak typeof(self) weakSelf = self;
        [[self getDeviceWithMac:mac]commandSendBGCodeWithMeasureType:(BGMeasureMode)testType.integerValue
                                                            CodeType:(BGCodeMode)codeType.integerValue
                                                          CodeString:qrCode
                                                           validDate:dueDate
                                                           remainNum:stripNum
                                              DisposeBGSendCodeBlock:^(BOOL sendOk) {
                                                  // 发码成功，发送事件
                                                  [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                                                                               kMAC_KEY:mac,
                                                                                                                               kACTION_KEY:kACTION_SET_BOTTLEMESSAGE,
                                                                                                                               }];
                                              } DisposeBGStartModel:^(BGOpenMode mode) {
                                                  weakSelf.deviceSelectedOpenMode = mode;
                                                  if (mode == BGOpenMode_Strip) {
                                                      [[weakSelf getDeviceWithMac:mac]commandCreateBGtestStripInBlock:^{
                                                          [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                                                                                       kMAC_KEY:mac,
                                                                                                                                       kACTION_KEY:kACTION_STRIP_IN,
                                                                                                                                       }];
                                                      } DisposeBGBloodBlock:^{
                                                          [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                                                                                       kMAC_KEY:mac,
                                                                                                                                       kACTION_KEY:kACTION_GET_BLOOD,
                                                                                                                                       }];
                                                      } DisposeBGResultBlock:^(NSDictionary *result) {
                                                          [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                                                                                       kMAC_KEY:mac,
                                                                                                                                       kACTION_KEY:kACTION_ONLINE_RESULT_BG,
                                                                                                                                       kONLINE_RESULT_BG:[result objectForKey:@"Result"],
                                                                                                                                       kDATA_ID:[result objectForKey:@"dataID"],
                                                                                                                                       }];

                                                      } DisposeBGErrorBlock:^(NSNumber *errorID) {
                                                          [weakSelf sendMeasureErrorEventWithMac:mac errorId:errorID];
                                                      }];
                                                  } else {
                                                      [[weakSelf getDeviceWithMac:mac]commandCreateBGtestModel:(BGMeasureMode)testType.integerValue DisposeBGStripInBlock:^{
                                                          [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                                                                                       kMAC_KEY:mac,
                                                                                                                                       kACTION_KEY:kACTION_STRIP_IN,
                                                                                                                                       }];
                                                      } DisposeBGBloodBlock:^{
                                                          [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                                                                                       kMAC_KEY:mac,
                                                                                                                                       kACTION_KEY:kACTION_GET_BLOOD,
                                                                                                                                       }];
                                                      } DisposeBGResultBlock:^(NSDictionary *result) {
                                                          [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                                                                                       kMAC_KEY:mac,
                                                                                                                                       kACTION_KEY:kACTION_ONLINE_RESULT_BG,
                                                                                                                                       kONLINE_RESULT_BG:[result objectForKey:@"Result"],
                                                                                                                                       kDATA_ID:[result objectForKey:@"dataID"],
                                                                                                                                       }];

                                                      } DisposeBGErrorBlock:^(NSNumber *errorID) {
                                                          [weakSelf sendMeasureErrorEventWithMac:mac errorId:errorID];
                                                      }];
                                                  }
                                                  
                                              } DisposeBGErrorBlock:^(NSNumber *errorID) {
                                                  [weakSelf sendMeasureErrorEventWithMac:mac errorId:errorID];
                                              }];
        
        
       
    }else{
        [self sendNoMatchedDeviceEventWithMac:mac];
    }
}

#pragma mark 读取试条信息
RCT_EXPORT_METHOD(getBottleMessage:(nonnull NSString *)mac){
    
    if ([self getDeviceWithMac:mac]) {
        __weak typeof(self) weakSelf = self;
        [[self getDeviceWithMac:mac]commandReadBGCodeDic:^(NSDictionary *codeDic) {
            
            NSDate *tempDate = [codeDic objectForKey:@"Date"];
            //将时间格式转化成字符串，适配plugin和react native
            NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
            [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSTimeZone *dongBaTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*60*60];
            [mydateFormatter setTimeZone:dongBaTimeZone];
            NSString *dateStr = [mydateFormatter stringFromDate:tempDate];
            
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:@{
                                                                                     kMAC_KEY:mac,
                                                                                     kACTION_KEY:kACTION_GET_BOTTLEMESSAGE,
                                                                                     kGET_EXPIRECTIME:dateStr,
                                                                                     kGET_USENUM:[codeDic objectForKey:@"Strips"],
                                                                                     }];
        } DisposeBGErrorBlock:^(NSNumber *errorID) {
            [weakSelf sendMeasureErrorEventWithMac:mac errorId:errorID];
        }];
        
    }else{
        
        [self sendNoMatchedDeviceEventWithMac:mac];
        
    }
    
}

#pragma mark 设置试条信息
RCT_EXPORT_METHOD(setBottleId:(nonnull NSString *)mac bottleId:(nonnull NSString *)bottleId){
    if ([self getDeviceWithMac:mac]) {
        __weak typeof(self) weakSelf = self;
        
        [[self getDeviceWithMac:mac] commandSendBottleID:bottleId.longLongValue DisposeBGSendBottleIDBlock:^(BOOL sendOk) {
            [weakSelf.bridge.eventDispatcher sendAppEventWithName:EVENT_NOTIFY body:@{
                                                                                      kMAC_KEY:mac,
                                                                                      kACTION_KEY:kACTION_SET_BOTTLEID,
                                                                                      }];
        } DisposeBGErrorBlock:^(NSNumber *errorID) {
            [weakSelf sendMeasureErrorEventWithMac:mac errorId:errorID];
        }];
    } else {
        [self sendNoMatchedDeviceEventWithMac:mac];
    }
}

#pragma mark 断开连接
RCT_EXPORT_METHOD(disConnect:(nonnull NSString *)mac){
    [self sendMeasureErrorEventWithMac:mac errorId:@(RNBGError_DisconnectFunctionNotSupportIniOSPlatform)];
}

#pragma mark 二维码解析
RCT_EXPORT_METHOD(getBottleInfoFromQR:(NSString *)qrCode){
    BG5 *bg = [BG5 new];
    NSDictionary *codeDic = [bg codeStripStrAnalysis:qrCode];
    if (codeDic) {
        
        NSDate *tempDate = [codeDic objectForKey:@"DueDate"];
        
        
        NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
        [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *dateStr = [mydateFormatter stringFromDate:tempDate];
        
        [self.bridge.eventDispatcher sendAppEventWithName:EVENT_NOTIFY body:@{
                                                                              kACTION_KEY:kACTION_CODE_ANALYSIS,
                                                                              kSTRIP_NUM_BG:codeDic[@"StripNum"],
                                                                              kSTRIP_EXPIRETIME_BG:dateStr,
                                                                              kBOTTLEID_BG:[NSString stringWithFormat:@"%@",codeDic[@"BottleID"]],// String
                                                                              }];
    } else {
        [self sendMeasureErrorEventWithMac:nil errorId:@(RNBGError_getBottleInfoFromQRFunctionInpurParameterError)];
    }
    
}

@end
