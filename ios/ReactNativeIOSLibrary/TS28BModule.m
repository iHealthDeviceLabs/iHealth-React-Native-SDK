//
//  TS28BModule.m
//  ReactNativeIOSLibrary
//
//  Created by user on 2019/11/12.
//  Copyright © 2019 daiqingquan. All rights reserved.
//

#import "TS28BModule.h"
#import "TS28BHeader.h"

#define EVENT_NOTIFY    @"event_notify_ts28b"
#define kMAC_KEY        @"mac"
#define kACTION_KEY     @"action"

@interface TS28BModule()<TS28BControllerDelegate>

@property (strong, nonatomic) TS28BController *ts28bController;



@end

@implementation TS28BModule


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


RCT_EXPORT_METHOD(getAllConnectedDevices){
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getAllTS28BConnectedDevices" object:self];
}

RCT_EXPORT_METHOD(measure:(nonnull NSString *)mac){
    
    
    self.ts28bController = [TS28BController sharedController];
           
   self.ts28bController.delegate = self;
    
//     if ([self getDeviceWithMac:mac] != nil) {
//
//         [[self getDeviceWithMac:mac] commandStartMeasure:^(NSDictionary *result) {
//
//             NSDictionary* deviceInfo = @{kACTION_KEY:@"ACTION_GET_MEASURE",@"bodyFlag":[result objectForKey:@"bodyFlag"],@"unit":[result objectForKey:@"unit"],@"result":[result objectForKey:@"result"]};
//
//                [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
//
//
//
//         }];
//
//       }
    
}

//断开连接
RCT_EXPORT_METHOD(disconnect:(nonnull NSString *)mac){
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disconnectTS28B" object:self];
}

#pragma mark - TS28B delegate

- (void)controller:(TS28BController *)controller didDiscoverDevice:(TS28B *)device{
    NSLog(@"搜索到设备的代理");
    
   
    
}
- (void)controller:(TS28BController *)controller didConnectSuccessDevice:(TS28B *)device{
    NSLog(@"连接成功的代理");
//    self.connectedDevice = device;
//    NSLog(@"%@",[NSString stringWithFormat:@"连接成功：%@ \nSerial Number:%@\nModel Number%@\nFirmware:%@\nHardware:%@\nSoftware:%@\nManufacture:%@\nSystemID:%@",device.peripheral.name,device.serialNumber,device.modelNumber,device.firmwareVersion,device.hardwareVersion,device.softwareVersion,device.manufacturerName,device.systemID]);
    
   
}
- (void)controller:(TS28BController *)controller didConnectFailDevice:(TS28B *)device{
    NSLog(@"连接失败的代理");
//    self.recordTextView.text = @"连接失败";
   
}
- (void)controller:(TS28BController *)controller didDisconnectDevice:(TS28B *)device{
    NSLog(@"断开连接的代理");
//    self.recordTextView.text = @"连接断开";
}
- (void)controller:(TS28BController *)controller device:(TS28B *)device didUpdateTemperature:(float)value temperatureUnit:(TemperatureUnit)unit measureDate:(NSDate *)date measureLocation:(TemperatureType)type{
    
//    self.valueLabel.text = [NSString stringWithFormat:@"%.1f %@",value,(unit == TemperatureUnit_C)?@"C":@"F"];
    
     NSDictionary* deviceInfo = @{kACTION_KEY:@"ACTION_GET_MEASURE",@"bodyFlag":[NSNumber numberWithInt:type],@"unit":[NSNumber numberWithInt:unit],@"result":[NSNumber numberWithFloat:value]};
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
}


@end
