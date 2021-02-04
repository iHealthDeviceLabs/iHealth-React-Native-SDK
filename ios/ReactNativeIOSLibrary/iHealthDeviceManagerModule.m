//
//  iHealthDeviceManagerModule.m
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2016/11/23.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import "iHealthDeviceManagerModule.h"
#import "AMHeader.h"
#import "BPHeader.h"
#import "HSHeader.h"
#import "BGHeader.h"
#import "POHeader.h"
#import "ECGHeader.h"
#import "TS28BHeader.h"
#import "NT13BHeader.h"
#import "BGMacroFile.h"
#import "ECGMacroFile.h"
#import "THV3Macro.h"
#import "NT13BMacroFile.h"
#import "IHSDKCloudUser.h"
#import "ManageDeviceController.h"
#import "ScanDeviceController.h"
#import "ConnectDeviceController.h"
#import <MediaPlayer/MediaPlayer.h>

#import "TS28BModule.h"

#import "BG1S.h"

#import "BG1SController.h"

#import "PO1.h"

#import "PO1Controller.h"

#import "PO1ProfileModule.h"

#import "PT3SBT.h"

#import "PT3SBTController.h"

#import "PT3SBTMacroFile.h"

#define FetchUserInfo @"com.rn.ihealth.dm.userinfo"

#define kEvent_Scan_Device              @"event_scan_device"
#define kEvent_Scan_Finish              @"event_scan_finish"
#define kEvent_Device_Connected         @"event_device_connected"
#define kEvent_Device_Connect_Failed    @"event_device_connect_failed"
#define kEvent_Device_Disconnect        @"event_device_disconnect"
#define kEvent_Authenticate_Result      @"event_authenticate_result"

#define kType_AM3S @"AM3S"
#define kType_AM4 @"AM4"
#define kType_PO3 @"PO3"
#define kType_BP5 @"BP5"
#define kType_BP7 @"BP7"
#define kType_BP3L @"BP3L"
#define kType_BP5S @"BP5S"
#define kType_BP7S @"BP7S"
#define kType_KN550 @"KN550"
#define kType_HS4 @"HS4"
#define kType_HS4S @"HS4S"
#define kType_HS2 @"HS2"
#define kType_BG1 @"BG1"
#define kType_BG5 @"BG5"
#define kType_BG5S @"BG5S"
#define kType_ECG3 @"ECG3"
#define kType_ECG3USB @"ECG3USB"
#define kType_BTM @"FDIR_V3"
#define kType_TS28B @"TS28B"
#define kType_NT13B @"NT13B"
#define kType_BG1S @"BG1S"
#define kType_HS2S @"HS2S"
#define kType_PO1 @"PO1"
#define kType_PT3SBT @"PT3SBT"


@interface iHealthDeviceManagerModule()<TS28BControllerDelegate>


@property (strong, nonatomic) TS28BController *ts28bController;

@property (strong, nonatomic) TS28B *ts28b;

@end

@implementation iHealthDeviceManagerModule

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE()

#pragma mark - constantsToExport

- (NSDictionary *)constantsToExport{
    return @{
             @"AM3S" :kType_AM3S,
             @"AM4" :kType_AM4,
             @"PO3":kType_PO3,
             @"PO3M":kType_PO3,
             @"BP5":kType_BP5,
             @"BP7":kType_BP7,
             @"BP3L" :kType_BP3L,
             @"BP5S" : kType_BP5S,
             @"BP7S" : kType_BP7S,
             @"KN550":kType_KN550,
             @"HS4S" :kType_HS4,
             @"HS4" :kType_HS4,
             @"HS2" :kType_HS2,
             @"BG1":kType_BG1,
             @"BG5":kType_BG5,
             @"BG5S":kType_BG5S,
             @"ECG3":kType_ECG3,
             @"ECG3USB":kType_ECG3USB,
             @"BTM":kType_BTM,
             @"NT13B":kType_NT13B,
             @"TS28B":kType_TS28B,
             @"BG1S":kType_BG1S,
             @"HS2S":kType_HS2S,
             @"PO1":kType_PO1,
             @"PT3SBT":kType_PT3SBT,
             @"Event_Scan_Device":kEvent_Scan_Device,
             @"Event_Scan_Finish":kEvent_Scan_Finish,
             @"Event_Device_Connected":kEvent_Device_Connected,
             @"Event_Device_Connect_Failed":kEvent_Device_Connect_Failed,
             @"Event_Device_Disconnect":kEvent_Device_Disconnect,
             @"Event_Authenticate_Result":kEvent_Authenticate_Result,
             };
};

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}
#pragma mark
#pragma mark - Init
-(id)init{
    if (self = [super init]){
        
        [ScanDeviceController commandGetInstance];
        // AM3S
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDiscover:) name:AM3SDiscover object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnectFailed:) name:AM3SConnectFailed object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnect:) name:AM3SConnectNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDisconnect:) name:AM3SDisConnectNoti object:nil];
        // AM4
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDiscover:) name:AM4Discover object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnectFailed:) name:AM4ConnectFailed object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnect:) name:AM4ConnectNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDisconnect:) name:AM4DisConnectNoti object:nil];
        // PO3
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDiscover:) name:PO3Discover object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnectFailed:) name:PO3ConnectFailed object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnect:) name:PO3ConnectNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDisconnect:) name:PO3DisConnectNoti object:nil];
        // BP5
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnect:) name:BP5ConnectNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDisconnect:) name:BP5DisConnectNoti object:nil];
        // BP7
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnect:) name:BP7ConnectNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDisconnect:) name:BP7DisConnectNoti object:nil];
        //BP3L
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDiscover:) name:BP3LDiscover object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnectFailed:) name:BP3LConnectFailed object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnect:) name:BP3LConnectNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDisconnect:) name:BP3LDisConnectNoti object:nil];
        
        //BP5S
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDiscover:) name:BP5SDiscover object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnectFailed:) name:BP5SConnectFailed object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnect:) name:BP5SConnectNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDisconnect:) name:BP5SDisConnectNoti object:nil];
        
        //BP7S
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDiscover:) name:BP7SDiscover object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnect:) name:BP7SConnectNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDisconnect:) name:BP7SDisConnectNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnectFailed:) name:BP7SConnectFailed object:nil];
        
        //KN550BT
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDiscover:) name:KN550BTDiscover object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnect:) name:KN550BTConnectNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDisconnect:) name:KN550BTDisConnectNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnectFailed:) name:KN550BTConnectFailed object:nil];
        // HS4S
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDiscover:) name:HS4Discover object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnectFailed:) name:HS4ConnectFailed object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnect:) name:HS4ConnectNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDisconnect:) name:HS4DisConnectNoti object:nil];
        // HS2
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDiscover:) name:HS2Discover object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnectFailed:) name:HS2ConnectFailed object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnect:) name:HS2ConnectNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDisconnect:) name:HS2DisConnectNoti object:nil];
        
        
        // HS2S
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDiscover:) name:HS2SDiscover object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnectFailed:) name:HS2SConnectFailed object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnect:) name:HS2SConnectNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDisconnect:) name:HS2SDisConnectNoti object:nil];
        
        //BG1
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(bg1Discover:) name:kNotificationNameNeedAudioPermission object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(bg1Connect:) name:kNotificationNameAudioDeviceInsert object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceBG1Disconnect:) name:kNotificationNameBG1DidDisConnect object:nil];
        //BG5
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnect:) name:BG5ConnectNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDisconnect:) name:BG5DisConnectNoti object:nil];
        
        // BG5S
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDiscover:) name:kNotificationNameBG5SDidDiscover object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnectFailed:) name:kNotificationNameBG5SConnectFail object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnect:) name:kNotificationNameBG5SConnectSuccess object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDisconnect:) name:kNotificationNameBG5SDidDisConnect object:nil];
        
        //ECG3
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDiscover:) name:ECG3Discover object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnectFailed:) name:ECG3ConnectFailed object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnect:) name:ECG3ConnectNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDisconnect:) name:ECG3DisConnectNoti object:nil];
        
        //ECG3USB
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnect:) name:ECGUSBConnectNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDisconnect:) name:ECGUSBDisConnectNoti object:nil];
        
        //BTM(THV3)
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDiscover:) name:THV3Discover object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnectFailed:) name:THV3ConnectFailed object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnect:) name:THV3ConnectNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDisconnect:) name:THV3DisConnectNoti object:nil];
        //NT13B
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDiscover:) name:NT13BDiscover object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnectFailed:) name:NT13BConnectFailed object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnect:) name:NT13BConnectNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDisconnect:) name:NT13BDisConnectNoti object:nil];
        
        //TS28B
        
        
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(disconnectTS28B) name:@"disconnectTS28B" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getAllTS28BConnectedDevices) name:@"getAllTS28BConnectedDevices" object:nil];
        
        
        //BG1S
               
               [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDiscover:) name:BG1SDiscover object:nil];
               [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnectFailed:) name:BG1SConnectFailed object:nil];
               [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnect:) name:BG1SConnectNoti object:nil];
               [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDisconnect:) name:BG1SDisConnectNoti object:nil];
        // PO1
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDiscover:) name:PO1Discover object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnectFailed:) name:PO1ConnectFailed object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnect:) name:PO1ConnectNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDisconnect:) name:PO1DisConnectNoti object:nil];
        // PT3SBT
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDiscover:) name:PT3SBTDiscover object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnectFailed:) name:PT3SBTConnectFailed object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnect:) name:PT3SBTConnectNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceDisconnect:) name:PT3SBTDisConnectNoti object:nil];
       
        [AM3Controller shareIHAM3Controller];
        [AM3SController_V2 shareIHAM3SController];
        [AM4Controller shareIHAM4Controller];
        [BP3LController shareBP3LController];
        [BP5Controller shareBP5Controller];
        [BP7Controller shareBP7Controller];
        [BP5SController sharedController];
        [BG5Controller shareIHBg5Controller];
        [BG5SController sharedController];
        [ECG3Controller shareECG3Controller];
        [ECG3USBController shareECG3USBController];
        [HS4Controller shareIHHs4Controller];
        [HS2Controller shareIHHs2Controller];
        [HS2SController shareIHHS2SController];
        [THV3Controller sharedController];
        [NT13BController shareIHNT13BController];
        [BG1SController shareIHBG1SController];
        [PO1Controller shareIHPO1Controller];
        [PT3SBTController shareIHPT3SBTController];
        
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -

-(void)disconnectTS28B{
    
    [self.ts28bController disconnectDevice:self.ts28b];
    
}
-(void)getAllTS28BConnectedDevices{
    
    if (self.ts28b==nil) {
        return;
    }
    
      NSDictionary* deviceInfo = @{@"event_notify_ts28b":@"ACTION_GET_ALL_CONNECTED_DEVICES",@"devices":self.ts28b.serialNumber};
       
       [self.bridge.eventDispatcher sendDeviceEventWithName:@"event_notify_ts28b" body:deviceInfo];
}

- (NSString*)serialNumebr:(NSDictionary*)userInfo{
    if (!userInfo){
        return nil;
    }
    NSString* serialNumber = userInfo[@"SerialNumber"];
    NSString* deviceId = userInfo[@"ID"];
    if (serialNumber && serialNumber.length > 0){
        return serialNumber;
    } else if (deviceId && deviceId.length > 0){
        return deviceId;
    }
    return nil;
}

#pragma mark - Notification

#pragma mark - BG1
-(void)bg1Discover:(NSNotification*)info {
    
    
    //    NSDictionary* deviceInfo = @{@"mac":@"",@"type":@"BG1"};
    //    [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Scan_Device body:deviceInfo];
    
}

-(void)bg1Connect:(NSNotification*)info {
    
    [[MPMusicPlayerController applicationMusicPlayer] setVolume:1.0f];
    NSDictionary* deviceInfo = @{@"mac":@"",@"type":@"BG1"};
    [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Scan_Device body:deviceInfo];
    
    
    //    NSDictionary* deviceInfo = @{@"mac":@"",@"type":@"BG1"};
    //    [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Device_Connected body:deviceInfo];
    
    BG1*myBG1=[[BG1Controller shareBG1Controller] getCurrentBG1Instance];
    
    [myBG1 commandBG1DeviceModel:@0 withDiscoverBlock:^{
        
    } withDiscoverBlock:^(NSDictionary *idpsDic) {
        
        bg1IdpsDic = [NSDictionary dictionaryWithDictionary:idpsDic];
        
    } withConnectBlock:^{
        
        NSString *bg1Mac = @"";
        if (bg1IdpsDic[@"SerialNumber"] != nil) {
            bg1Mac = bg1IdpsDic[@"SerialNumber"];
        }
        NSDictionary* deviceInfo = @{@"mac":bg1Mac,@"type":@"BG1"};
        [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Device_Connected body:deviceInfo];
        
    } withErrorBlock:^(BG1Error errorID) {
        
        NSDictionary* deviceInfo = @{@"mac":@"",@"action":@"action_measure_error_for_bg1",@"action_measure_error_for_bg1":[NSNumber numberWithInt:errorID]};
        [self.bridge.eventDispatcher sendDeviceEventWithName:@"event_notify_bg1" body:deviceInfo];
        
    }];
    
}

-(void)deviceBG1Disconnect:(NSNotification*)info {
    
    NSDictionary* deviceInfo = @{@"mac":@"",@"type":kType_BG1};
    [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Device_Disconnect body:deviceInfo];
}

#pragma mark - 发现BLE设备
-(void)deviceDiscover:(NSNotification*)info {
    
    NSLog(@"Native: device discover %@", info);
    
    NSDictionary* userInfo = [info userInfo];
    NSString* deviceName = userInfo[@"DeviceName"];
    
    NSDictionary *deviceNameForType = @{
                                        @"AM3S" :kType_AM3S,
                                        @"AM4" :kType_AM4,
                                        @"PO3":kType_PO3,
                                        @"PO3M":kType_PO3,
                                        @"BP3L" :kType_BP3L,
                                        @"BP5S" : kType_BP5S,
                                        @"BP7S" : kType_BP7S,
                                        @"KN-550BT":kType_KN550,
                                        @"KN550":kType_KN550,
                                        @"HS4S" :kType_HS4,
                                        @"HS4" :kType_HS4,
                                        @"HS2" :kType_HS2,
                                        @"ECG3":kType_ECG3,
                                        @"FDTH":kType_BTM,
                                        @"BG5S":kType_BG5S,
                                        @"NT13B":kType_NT13B,
                                        @"TS28B":kType_TS28B,
                                        @"BG1S":kType_BG1S,
                                        @"HS2S":kType_HS2S,
                                        @"PO1":kType_PO1,
                                        @"PT3SBT":kType_PT3SBT,
                                        };
    
    if (deviceNameForType[deviceName] && [self serialNumebr:userInfo]){
        NSString *sn = [self serialNumebr:userInfo];
        [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Scan_Device body:@{@"mac":sn,@"type":deviceNameForType[deviceName]}];
    }
}

#pragma mark 连接成功 BT\BLE都用这个通知
- (BOOL)isIAPDevice:(NSString*)deviceName{
    NSArray *array = @[@"BP5",@"BP7",@"BG5",@"ECG"];
    if (deviceName && [array containsObject:deviceName]){
        return YES;
    } else {
        return NO;
    }
}
-(void)deviceConnect:(NSNotification*)info {
    
    NSDictionary* userInfo = [info userInfo];
    NSLog(@"连接成功：%@",userInfo);
    NSString* deviceName = userInfo[@"DeviceName"];
    
    NSString* protocolString = userInfo[@"ProtocolString"];
    
    if ([protocolString isEqualToString:@"NT13B_Protocol"]) {
        deviceName=@"NT13B";
    }
    
    NSDictionary *deviceNameForType = @{
                                        @"AM3S" :kType_AM3S,
                                        @"AM4" :kType_AM4,
                                        @"PO3":kType_PO3,
                                        @"PO3M":kType_PO3,
                                        @"BP3L" :kType_BP3L,
                                        @"BP5S" : kType_BP5S,
                                        @"BP7S" : kType_BP7S,
                                        @"KN-550BT":kType_KN550,
                                        @"KN550":kType_KN550,
                                        @"HS4S" :kType_HS4,
                                        @"HS4" :kType_HS4,
                                        @"HS2" :kType_HS2,
                                        @"FDTH":kType_BTM,
                                        @"BP5":kType_BP5,
                                        @"BP7":kType_BP7,
                                        @"BG5":kType_BG5,
                                        @"BG5S":kType_BG5S,
                                        @"ECG3":kType_ECG3,
                                        @"ECG":kType_ECG3USB,// ECG3USB的连接通知里使用的设备名称是ECG，
                                        @"NT13B":kType_NT13B,
                                        @"TS28B":kType_TS28B,
                                        @"BG1S":kType_BG1S,
                                        @"HS2S":kType_HS2S,
                                        @"PO1":kType_PO1,
                                        @"PT3SBT":kType_PT3SBT,
                                        };
    
    if (deviceNameForType[deviceName] && [self serialNumebr:userInfo]){
        NSString *sn = [self serialNumebr:userInfo];
        if ([self isIAPDevice:deviceName]){
            [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Scan_Device body:@{@"mac":sn,@"type":deviceNameForType[deviceName]}];
        }
        [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Device_Connected body:@{@"mac":sn,@"type":deviceNameForType[deviceName]}];
    }
}
#pragma mark 连接断开 BT\BLE都用这个通知
-(void)deviceDisconnect:(NSNotification*)info {
    NSDictionary* userInfo = [info userInfo];
    NSString* deviceName = userInfo[@"DeviceName"];
    
    NSString* protocolString = userInfo[@"ProtocolString"];
    
    if ([protocolString isEqualToString:@"NT13B_Protocol"]) {
        deviceName=@"NT13B";
    }
    
    if ([protocolString isEqualToString:@"com.jiuan.PO1"]) {
        deviceName=@"PO1";
    }
    
    NSDictionary *deviceNameForType = @{
                                        @"AM3S" :kType_AM3S,
                                        @"AM4" :kType_AM4,
                                        @"PO3":kType_PO3,
                                        @"PO3M":kType_PO3,
                                        @"BP3L" :kType_BP3L,
                                        @"BP5S" : kType_BP5S,
                                        @"BP7S" : kType_BP7S,
                                        @"KN-550BT":kType_KN550,
                                        @"KN550":kType_KN550,
                                        @"HS4S" :kType_HS4,
                                        @"HS4" :kType_HS4,
                                        @"HS2" :kType_HS2,
                                        @"FDTH":kType_BTM,
                                        @"BP5":kType_BP5,
                                        @"BP7":kType_BP7,
                                        @"BG5":kType_BG5,
                                        @"BG5S":kType_BG5S,
                                        @"ECG3":kType_ECG3,
                                        @"ECG":kType_ECG3USB,// ECG3USB的连接通知里使用的设备名称是ECG，
                                        @"NT13B":kType_NT13B,
                                        @"TS28B":kType_TS28B,
                                        @"BG1S":kType_BG1S,
                                        @"HS2S":kType_HS2S,
                                        @"PO1":kType_PO1,
                                        @"PT3SBT":kType_PT3SBT,
                                        };
    
    if (deviceNameForType[deviceName] && [self serialNumebr:userInfo]){
        NSString *sn = [self serialNumebr:userInfo];
        [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Device_Disconnect body:@{@"mac":sn,@"type":deviceNameForType[deviceName]}];
    }
}
#pragma mark - 连接失败，BLE设备
-(void)deviceConnectFailed:(NSNotification*)info {
    NSDictionary* userInfo = [info userInfo];
    NSString* deviceName = userInfo[@"DeviceName"];
    
    NSString* protocolString = userInfo[@"ProtocolString"];
    
    if ([protocolString isEqualToString:@"NT13B_Protocol"]) {
        deviceName=@"NT13B";
    }
    
    NSDictionary *deviceNameForType = @{
                                        @"AM3S" :kType_AM3S,
                                        @"AM4" :kType_AM4,
                                        @"PO3":kType_PO3,
                                        @"PO3M":kType_PO3,
                                        @"BP3L" :kType_BP3L,
                                        @"BP5S" : kType_BP5S,
                                        @"BG5S" :kType_BG5S,
                                        @"BP7S" : kType_BP7S,
                                        @"KN-550BT":kType_KN550,
                                        @"KN550":kType_KN550,
                                        @"HS4S" :kType_HS4,
                                        @"HS4" :kType_HS4,
                                        @"HS2" :kType_HS2,
                                        @"FDTH":kType_BTM,
                                        @"ECG3":kType_ECG3,
                                        @"NT13B":kType_NT13B,
                                        @"TS28B":kType_TS28B,
                                        @"BG1S":kType_BG1S,
                                        @"HS2S":kType_HS2S,
                                        @"PO1":kType_PO1,
                                        @"PT3SBT":kType_PT3SBT,
                                        };
    
    if (deviceNameForType[deviceName] && [self serialNumebr:userInfo]){
        NSString *sn = [self serialNumebr:userInfo];
        [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Device_Connect_Failed body:@{@"mac":sn,@"type":deviceNameForType[deviceName]}];
    }
}

#pragma mark - Method

RCT_EXPORT_METHOD(sdkAuthWithLicense:(nonnull NSString *)license){
    
    
    NSArray * arr = [license componentsSeparatedByString:@"."];
    
    
    NSString*licenseName=[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:licenseName ofType:@"pem"];
    
   
    NSData*data = [NSData dataWithContentsOfFile:filePath];
    

    
    if (data!=nil) {
        
        [[IHSDKCloudUser commandGetSDKUserInstance] commandSDKUserValidationWithLicense:data UserDeviceAccess:^(NSArray *DeviceAccessArray) {
            
            NSLog(@"DeviceAccessArray :%@",DeviceAccessArray);
            
        } UserValidationSuccess:^(UserAuthenResult result) {
            
            if (result==UserAuthen_LoginSuccess || result==UserAuthen_RegisterSuccess|| result==UserAuthen_TrySuccess ) {
                 [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Authenticate_Result body:@{@"access":@1}];
            }else{
                
                 [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Authenticate_Result body:@{@"access":@0}];
                
            }
            
        } DisposeErrorBlock:^(UserAuthenResult errorID) {
            
             [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Authenticate_Result body:@{@"access":@0}];
            
           
            
           
            
        }];
        
    }else{
        
        
        [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Authenticate_Result body:@{@"access":@0}];
        
    }
    
   

    
}

RCT_EXPORT_METHOD(startDiscovery:(nonnull NSString *)deviceType){
    if ([deviceType isEqualToString:kType_BP5]){
        
        NSArray*bp5array = [[BP5Controller shareBP5Controller] getAllCurrentBP5Instace];
        if (bp5array.count) {
            for (int i=0; i<bp5array.count; i++) {
                BP5*mybp5=[bp5array objectAtIndex:i];
                NSDictionary* deviceInfo = [[NSDictionary alloc]init];
                deviceInfo = @{@"mac":mybp5.serialNumber,@"type":kType_BP5};
                [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Scan_Device body:deviceInfo];
            }
        }
    }else if ([deviceType isEqualToString:kType_BP7]){
        
        NSArray*bp7array = [[BP7Controller shareBP7Controller] getAllCurrentBP7Instace];
        if (bp7array.count) {
            for (int i=0; i<bp7array.count; i++) {
                BP7*mybp7=[bp7array objectAtIndex:i];
                NSDictionary* deviceInfo = [[NSDictionary alloc]init];
                deviceInfo = @{@"mac":mybp7.serialNumber,@"type":kType_BP7};
                [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Scan_Device body:deviceInfo];
            }
        }
    } else if ([deviceType isEqualToString:kType_BG1]){
        
        [[BG1Controller shareBG1Controller] initBGAudioModule];
    } else if ([deviceType isEqualToString:kType_BG5]){
        
        NSArray*bg5array = [[BG5Controller shareIHBg5Controller] getAllCurrentBG5Instace];
        if (bg5array.count) {
            for (int i=0; i<bg5array.count; i++) {
                BG5*mybg5=[bg5array objectAtIndex:i];
                NSDictionary* deviceInfo = [[NSDictionary alloc]init];
                deviceInfo = @{@"mac":mybg5.serialNumber,@"type":kType_BG5};
                [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Scan_Device body:deviceInfo];
            }
        }
    } else if ([deviceType isEqualToString:kType_ECG3USB]){
        
        ECG3USB*myecg3 = [[ECG3USBController shareECG3USBController] getCurrentECG3USBInstace];
        if (myecg3!=nil) {
            NSDictionary* deviceInfo = [[NSDictionary alloc]init];
            deviceInfo = @{@"mac":myecg3.serialNumber,@"type":kType_ECG3USB};
            [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Scan_Device body:deviceInfo];
        }
    } else if ([deviceType isEqualToString:kType_AM3S]){
        
        [[ScanDeviceController commandGetInstance] commandScanDeviceType:HealthDeviceType_AM3S];
    } else if ([deviceType isEqualToString:kType_AM4]){
        
        [[ScanDeviceController commandGetInstance] commandScanDeviceType:HealthDeviceType_AM4];
        
    } else if ([deviceType isEqualToString:kType_BP3L]){
        
        [[ScanDeviceController commandGetInstance] commandScanDeviceType:HealthDeviceType_BP3L];
    } else if ([deviceType isEqualToString:kType_BP5S]){
        
        [[ScanDeviceController commandGetInstance] commandScanDeviceType:HealthDeviceType_BP5S];
    } else if ([deviceType isEqualToString:kType_BP7S]){
        
        [[ScanDeviceController commandGetInstance] commandScanDeviceType:HealthDeviceType_BP7S];
    } else if ([deviceType isEqualToString:kType_KN550]){
        
        [[ScanDeviceController commandGetInstance] commandScanDeviceType:HealthDeviceType_KN550BT];
    } else if ([deviceType isEqualToString:kType_HS4] ||[deviceType isEqualToString:kType_HS4S]){
        
        [[ScanDeviceController commandGetInstance] commandScanDeviceType:HealthDeviceType_HS4];
    }  else if ([deviceType isEqualToString:kType_HS2]){
        
        [[ScanDeviceController commandGetInstance] commandScanDeviceType:HealthDeviceType_HS2];
    }else if ([deviceType isEqualToString:kType_PO3]){
        
        [[ScanDeviceController commandGetInstance] commandScanDeviceType:HealthDeviceType_PO3];
        
    } else if ([deviceType isEqualToString:kType_BTM]){
        
        [[ScanDeviceController commandGetInstance] commandScanDeviceType:HealthDeviceType_THV3];
        
    }else if ([deviceType isEqualToString:kType_ECG3]){
        
        [[ScanDeviceController commandGetInstance] commandScanDeviceType:HealthDeviceType_ECG3];
        
    }else if ([deviceType isEqualToString:kType_BG5S]){
        
        [[ScanDeviceController commandGetInstance] commandScanDeviceType:HealthDeviceType_BG5S];
        
    }
    else if ([deviceType isEqualToString:kType_NT13B]){
        
        [[ScanDeviceController commandGetInstance] commandScanDeviceType:HealthDeviceType_NT13B];
        
    }else if ([deviceType isEqualToString:kType_BG1S]){
        
        [[ScanDeviceController commandGetInstance] commandScanDeviceType:HealthDeviceType_BG1S];
        
    }else if ([deviceType isEqualToString:kType_HS2S]){
        
        [[ScanDeviceController commandGetInstance] commandScanDeviceType:HealthDeviceType_HS2S];
        
    }
    
    else if ([deviceType isEqualToString:kType_TS28B]){
        
       self.ts28bController = [TS28BController sharedController];
        self.ts28bController.delegate = self;
        [self.ts28bController startScan];
        
    }else if ([deviceType isEqualToString:kType_PO1]){
        
        [[ScanDeviceController commandGetInstance] commandScanDeviceType:HealthDeviceType_PO1];
        
    }else if ([deviceType isEqualToString:kType_PT3SBT]){
        
        [[ScanDeviceController commandGetInstance] commandScanDeviceType:HealthDeviceType_PT3SBT];
        
    }
    
    
    
}


#pragma mark - TS28B delegate

- (void)controller:(TS28BController *)controller didDiscoverDevice:(TS28B *)device{
    NSLog(@"搜索到设备的代理");
    
   [self.ts28bController connectDevice:device];
    
   [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Scan_Device body:@{@"mac":device.serialNumber,@"type":@"TS28B"}];
    
    
    
}
- (void)controller:(TS28BController *)controller didConnectSuccessDevice:(TS28B *)device{
    NSLog(@"连接成功的代理");
//    self.connectedDevice = device;
//    NSLog(@"%@",[NSString stringWithFormat:@"连接成功：%@ \nSerial Number:%@\nModel Number%@\nFirmware:%@\nHardware:%@\nSoftware:%@\nManufacture:%@\nSystemID:%@",device.peripheral.name,device.serialNumber,device.modelNumber,device.firmwareVersion,device.hardwareVersion,device.softwareVersion,device.manufacturerName,device.systemID]);
    
    self.ts28b=device;
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Device_Connected body:@{@"mac":device.serialNumber,@"type":@"TS28B"}];
}
- (void)controller:(TS28BController *)controller didConnectFailDevice:(TS28B *)device{
    NSLog(@"连接失败的代理");
//    self.recordTextView.text = @"连接失败";
     [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Device_Connect_Failed body:@{@"mac":device.peripheral.identifier,@"type":@"TS28B"}];
}
- (void)controller:(TS28BController *)controller didDisconnectDevice:(TS28B *)device{
    NSLog(@"断开连接的代理");
//    self.recordTextView.text = @"连接断开";
    
    
     [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Device_Disconnect body:@{@"mac":device.serialNumber,@"type":@"TS28B"}];
}
- (void)controller:(TS28BController *)controller device:(TS28B *)device didUpdateTemperature:(float)value temperatureUnit:(TemperatureUnit)unit measureDate:(NSDate *)date measureLocation:(TemperatureType)type{
    
//    self.valueLabel.text = [NSString stringWithFormat:@"%.1f %@",value,(unit == TemperatureUnit_C)?@"C":@"F"];
}



RCT_EXPORT_METHOD(stopDiscovery){
    
    [[ScanDeviceController commandGetInstance] commandStopScanDeviceType:HealthDeviceType_AM3S];
    
    [[ScanDeviceController commandGetInstance] commandStopScanDeviceType:HealthDeviceType_AM4];
    
    [[ScanDeviceController commandGetInstance] commandStopScanDeviceType:HealthDeviceType_BP3L];
    
    [[ScanDeviceController commandGetInstance] commandStopScanDeviceType:HealthDeviceType_BP5S];
    
    [[ScanDeviceController commandGetInstance] commandStopScanDeviceType:HealthDeviceType_BP7S];
    
    [[ScanDeviceController commandGetInstance] commandStopScanDeviceType:HealthDeviceType_KN550BT];
    
    [[ScanDeviceController commandGetInstance] commandStopScanDeviceType:HealthDeviceType_PO3];
    
    [[ScanDeviceController commandGetInstance] commandStopScanDeviceType:HealthDeviceType_HS4];
    
     [[ScanDeviceController commandGetInstance] commandStopScanDeviceType:HealthDeviceType_HS2];
    
    [[ScanDeviceController commandGetInstance] commandStopScanDeviceType:HealthDeviceType_ECG3];
    
    [[ScanDeviceController commandGetInstance] commandStopScanDeviceType:HealthDeviceType_ECG3];
    
    [[ScanDeviceController commandGetInstance] commandStopScanDeviceType:HealthDeviceType_THV3];
    
    [[ScanDeviceController commandGetInstance] commandStopScanDeviceType:HealthDeviceType_BG5S];
    
    [[ScanDeviceController commandGetInstance] commandStopScanDeviceType:HealthDeviceType_NT13B];
    
    [[ScanDeviceController commandGetInstance] commandStopScanDeviceType:HealthDeviceType_BG1S];
    
    
     [[ScanDeviceController commandGetInstance] commandStopScanDeviceType:HealthDeviceType_HS2S];
    
    [[ScanDeviceController commandGetInstance] commandStopScanDeviceType:HealthDeviceType_PO1];
    
    [[ScanDeviceController commandGetInstance] commandStopScanDeviceType:HealthDeviceType_PT3SBT];
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Scan_Finish body:nil];
}

RCT_EXPORT_METHOD(connectDevice:(nonnull NSString *)mac type:(nonnull NSString *)deviceType){
    if ([deviceType isEqualToString:kType_BP5]){
        
        NSArray*bp5array = [[BP5Controller shareBP5Controller] getAllCurrentBP5Instace];
        if (bp5array.count) {
            for (int i=0; i<bp5array.count; i++) {
                BP5*mybp5=[bp5array objectAtIndex:i];
                NSDictionary* deviceInfo = @{@"mac":mybp5.serialNumber,@"type":kType_BP5};
                [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Device_Connected body:deviceInfo];
            }
        }
        
    }else if ([deviceType isEqualToString:kType_BP7]){
        
        NSArray*bp7array = [[BP7Controller shareBP7Controller] getAllCurrentBP7Instace];
        if (bp7array.count) {
            for (int i=0; i<bp7array.count; i++) {
                BP7*mybp7=[bp7array objectAtIndex:i];
                NSDictionary* deviceInfo = @{@"mac":mybp7.serialNumber,@"type":kType_BP7};
                [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Device_Connected body:deviceInfo];
            }
        }
        
        
    } else if ([deviceType isEqualToString:kType_BG1]){
        
        BG1*myBG1=[[BG1Controller shareBG1Controller] getCurrentBG1Instance];
        
        [myBG1 commandBG1DeviceModel:@0 withDiscoverBlock:^{
            
        } withDiscoverBlock:^(NSDictionary *idpsDic) {
            
            bg1IdpsDic = [NSDictionary dictionaryWithDictionary:idpsDic];
            
            NSString *bg1Mac = @"";
            if (bg1IdpsDic[@"SerialNumber"] != nil) {
                bg1Mac = bg1IdpsDic[@"SerialNumber"];
            }
            NSDictionary*idpsDics=[[NSDictionary alloc] initWithObjectsAndKeys:[bg1IdpsDic valueForKey:@"FW"],@"FirmWare",[bg1IdpsDic valueForKey:@"HD"],@"HardWare",[bg1IdpsDic valueForKey:@"SerialNumber"],@"DeviceId",nil];
            NSDictionary* deviceInfo = @{@"mac":bg1Mac,@"type":@"BG1",@"description":@"Success.",@"connect_result_for_bg1":@0,@"idps":idpsDics};
            [self.bridge.eventDispatcher sendDeviceEventWithName:@"action_connect_result_for_bg1" body:deviceInfo];
            
        } withConnectBlock:^{
            
            NSString *bg1Mac = @"";
            if (bg1IdpsDic[@"SerialNumber"] != nil) {
                bg1Mac = bg1IdpsDic[@"SerialNumber"];
            }
            NSDictionary* deviceInfo = @{@"mac":bg1Mac,@"type":@"BG1"};
            [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Device_Connected body:deviceInfo];
            
        } withErrorBlock:^(BG1Error errorID) {
            
            NSString *bg1Mac = @"";
            if (bg1IdpsDic[@"SerialNumber"] != nil) {
                bg1Mac = bg1IdpsDic[@"SerialNumber"];
            }
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
            
            NSDictionary* deviceInfo = @{@"mac":bg1Mac,@"action":@"action_measure_error_for_bg1",@"action_measure_error_for_bg1":[NSNumber numberWithInt:errorID],@"description":descriptionStr};
            [self.bridge.eventDispatcher sendDeviceEventWithName:@"event_notify_bg1" body:deviceInfo];
            
        }];
        
    } else if ([deviceType isEqualToString:kType_BG5]){
        
        NSArray*bg5array = [[BG5Controller shareIHBg5Controller] getAllCurrentBG5Instace];
        if (bg5array.count) {
            for (int i=0; i<bg5array.count; i++) {
                BG5*mybg5=[bg5array objectAtIndex:i];
                NSDictionary* deviceInfo = [[NSDictionary alloc]init];
                deviceInfo = @{@"mac":mybg5.serialNumber,@"type":kType_BG5};
                [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Device_Connected body:deviceInfo];
            }
            
            
        }
    } else if ([deviceType isEqualToString:kType_AM3S]){
        
        [[ConnectDeviceController commandGetInstance] commandContectDeviceWithDeviceType:HealthDeviceType_AM3S andSerialNub:mac];
    }else if ([deviceType isEqualToString:kType_AM4]){
        
        [[ConnectDeviceController commandGetInstance] commandContectDeviceWithDeviceType:HealthDeviceType_AM4 andSerialNub:mac];
        
    }else if ([deviceType isEqualToString:kType_BP3L]){
        
        [[ConnectDeviceController commandGetInstance] commandContectDeviceWithDeviceType:HealthDeviceType_BP3L andSerialNub:mac];
    }else if ([deviceType isEqualToString:kType_BP5S]){
        
        [[ConnectDeviceController commandGetInstance] commandContectDeviceWithDeviceType:HealthDeviceType_BP5S andSerialNub:mac];
    }else if ([deviceType isEqualToString:kType_BP7S]){
        
        [[ConnectDeviceController commandGetInstance] commandContectDeviceWithDeviceType:HealthDeviceType_BP7S andSerialNub:mac];
    }else if ([deviceType isEqualToString:kType_KN550]){
        
        [[ConnectDeviceController commandGetInstance] commandContectDeviceWithDeviceType:HealthDeviceType_KN550BT andSerialNub:mac];
    }else if ([deviceType isEqualToString:kType_HS4]||[deviceType isEqualToString:kType_HS4S]){
        
        [[ConnectDeviceController commandGetInstance] commandContectDeviceWithDeviceType:HealthDeviceType_HS4 andSerialNub:mac];
    }else if ([deviceType isEqualToString:kType_HS2]){
        
        [[ConnectDeviceController commandGetInstance] commandContectDeviceWithDeviceType:HealthDeviceType_HS2 andSerialNub:mac];
    }else if ([deviceType isEqualToString:kType_PO3]){
        
        [[ConnectDeviceController commandGetInstance] commandContectDeviceWithDeviceType:HealthDeviceType_PO3 andSerialNub:mac];
        
    }else if ([deviceType isEqualToString:kType_BTM]){
        
        [[ConnectDeviceController commandGetInstance] commandContectDeviceWithDeviceType:HealthDeviceType_THV3 andSerialNub:mac];
        
    }else if ([deviceType isEqualToString:kType_ECG3]){
        
        [[ConnectDeviceController commandGetInstance] commandContectDeviceWithDeviceType:HealthDeviceType_ECG3 andSerialNub:mac];
        
    }else if ([deviceType isEqualToString:kType_ECG3USB]) {
        
        ECG3USB*myecg3 = [[ECG3USBController shareECG3USBController] getCurrentECG3USBInstace];
        if (myecg3!=nil) {
            
            NSDictionary* deviceInfo = @{@"mac":myecg3.serialNumber,@"type":kType_ECG3USB};
            [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Device_Connected body:deviceInfo];
        }
    }else if ([deviceType isEqualToString:kType_BG5S]){
        
        [[ConnectDeviceController commandGetInstance] commandContectDeviceWithDeviceType:HealthDeviceType_BG5S andSerialNub:mac];
        
    }else if ([deviceType isEqualToString:kType_NT13B]){
        
        [[ConnectDeviceController commandGetInstance] commandContectDeviceWithDeviceType:HealthDeviceType_NT13B andSerialNub:mac];
        
    }else if ([deviceType isEqualToString:kType_TS28B]){
        
       [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Device_Connected body:@{@"mac":self.ts28b.serialNumber,@"type":@"TS28B"}];
        
    }else if ([deviceType isEqualToString:kType_BG1S]){
        
        [[ConnectDeviceController commandGetInstance] commandContectDeviceWithDeviceType:HealthDeviceType_BG1S andSerialNub:mac];
        
    }else if ([deviceType isEqualToString:kType_HS2S]){
        
        [[ConnectDeviceController commandGetInstance] commandContectDeviceWithDeviceType:HealthDeviceType_HS2S andSerialNub:mac];
    }else if ([deviceType isEqualToString:kType_PO1]){
        
        [[ConnectDeviceController commandGetInstance] commandContectDeviceWithDeviceType:HealthDeviceType_PO1 andSerialNub:mac];
        
    }else if ([deviceType isEqualToString:kType_PT3SBT]){
        
        [[ConnectDeviceController commandGetInstance] commandContectDeviceWithDeviceType:HealthDeviceType_PO1 andSerialNub:mac];
        
    }
    
}


RCT_EXPORT_METHOD(getDevicesIDPS:(nonnull NSString *)mac callback:(RCTResponseSenderBlock)callback){
    
    
//    {
//        BTFirmwareVersion = "1.0.4";
//        DeviceName = HS4S;
//        FirmwareVersion = "1.0.2";
//        HardwareVersion = "5.0.1";
//        ID = "97FB0E73-7CE7-4B27-A7CE-EB76E9770002";
//        Manufacture = iHealth;
//        ModelNumber = "HS4S 11070";
//        ProtocolString = "com.jiuan.BWSV01";
//        SerialNumber = 8CDE529FD9DA;
//        Type = 2;
//    }
//    
    // {"protocolstring":"com.jiuan.AMV12","accessoryname":"AM4","firmwareversion":"138","hardwareversion":"100","manufacture":"iHealth","serialnumber":"004D32079148","modenumber":"AM4 11070"}
    
    NSArray*deviceArray=[[ManageDeviceController commandGetInstance] commandGetAllConnectDeviceArray];
    
    if(deviceArray.count){
        
        for (int i=0; i<deviceArray.count; i++) {
            
            if ([mac isEqualToString:[[deviceArray objectAtIndex:i] valueForKey:@"SerialNumber"]]) {
                
                NSDictionary*deviceDic=[deviceArray objectAtIndex:i];
                
                NSMutableDictionary*dic=[[NSMutableDictionary alloc] init];
                
                [dic setObject:[deviceDic objectForKey:@"ProtocolString"] forKey:@"protocolstring"];
                
                [dic setObject:[deviceDic objectForKey:@"DeviceName"] forKey:@"accessoryname"];
                
                [dic setObject:[deviceDic objectForKey:@"FirmwareVersion"] forKey:@"firmwareversion"];
                
                [dic setObject:[deviceDic objectForKey:@"HardwareVersion"] forKey:@"hardwareversion"];
                
                if(![[deviceDic objectForKey:@"DeviceName"] isEqualToString:@"BP5"] && ![[deviceDic objectForKey:@"DeviceName"] isEqualToString:@"BP7"]){
                
                    [dic setObject:[deviceDic objectForKey:@"Manufacture"] forKey:@"manufacture"];
                }
                
                
                [dic setObject:[deviceDic objectForKey:@"SerialNumber"] forKey:@"serialNumber"];
                
                [dic setObject:[deviceDic objectForKey:@"ModelNumber"] forKey:@"modenumber"];
                
                
                callback(@[dic]);
                
            }
            
        }
        
    }else{
        
        
        
    }
    
    
    
}

RCT_EXPORT_METHOD(authenConfigureInfo:(NSString *)userID clientID:(NSString *)clientID clientSecret:(NSString *)clientSecret){
    
    HealthUser *currentUser = [[HealthUser alloc]init];
    currentUser.userAccount = userID;
    currentUser.clientID = clientID;
    currentUser.clientSecret = clientSecret;
    
    [[IHSDKCloudUser commandGetSDKUserInstance]commandSDKUserValidation:currentUser UserDeviceAccess:^(NSArray *DeviceAccessArray) {
        
    } UserValidationSuccess:^(UserAuthenResult result) {
        [self authenResult:result userID:userID clientID:clientID clientSecret:clientSecret];

    } UserValidationReturn:^(NSString *userID) {
        
    } DisposeErrorBlock:^(UserAuthenResult errorID) {
        if (errorID == UserAuthen_UserInvalidateRight) {
            [self authenResult:UserAuthen_LoginSuccess userID:userID clientID:clientID clientSecret:clientSecret];
        }else{
            [self authenResult:errorID userID:userID clientID:clientID clientSecret:clientSecret];
        }

    }];

}

- (void)authenResult:(UserAuthenResult)result userID:(NSString*)userID clientID:(NSString*)clientID clientSecret:(NSString*)clientSecret{
    if (result <= UserAuthen_TrySuccess) {
        NSArray* userInfo = @[userID,clientID,clientSecret];
        [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:FetchUserInfo];
    }else{
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:FetchUserInfo];
    }
    [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Authenticate_Result body:@{@"authen":@(result)}];
}

RCT_EXPORT_METHOD(authenAppSecret:(NSString *)appSecret){
    
    
    [[IHSDKCloudUser commandGetSDKUserInstance] commandSDKUserValidationWithAppSecret:appSecret UserValidationSuccess:^(UserAuthenResult result) {
        
        [self.bridge.eventDispatcher sendDeviceEventWithName:kEvent_Authenticate_Result body:@{@"authen":@(result)}];
        
    } DisposeErrorBlock:^(UserAuthenResult errorID) {
        
    }];
    
}

RCT_EXPORT_METHOD(disconnectDevice:(NSString*)mac type:(NSString*)type){
    NSLog(@"API disconnectDevice is not avaliable in iOS platform, please the specific device's disconnect API.");
}

+ (NSArray*)userInfos{
    NSArray* userInfos = [[NSUserDefaults standardUserDefaults] objectForKey:FetchUserInfo];
    if (userInfos.count == 3) {
        return userInfos;
    }else{
        return nil;
    }
}

+ (NSString*)autherizedUserID{
    return [[self userInfos] objectAtIndex:0];
}

+ (NSString*)autherizedClientID{
    return [[self userInfos] objectAtIndex:1];
}

+ (NSString*)autherizedClientSecret{
    return [[self userInfos] objectAtIndex:2];
}


@end
