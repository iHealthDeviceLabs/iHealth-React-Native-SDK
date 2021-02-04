//
//  PO1.h
//  testShareCommunication
//
//  Created by daiqingquan on 13-11-29.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "POMacroFile.h"


/**
 PO1
 */
@interface PO1 : NSObject

@property (strong, nonatomic) NSString *currentUUID;
@property (strong, nonatomic) NSString *serialNumber;
@property (strong, nonatomic) NSString *firmwareVersion;


/**
 * Get device IDPS
 * @param function  A block to return the function and states that the device supports.
 * {
     MAC = 60A4232504ED;
     accessoryName = "Pulse Oximeter";
     firmwareVersion = "1.0.0";
     hardwareVersion = "1.0.0";
     manufaturer = iHealth;
     modelNumber = "PO1 11070";
     protocol = "com.jiuan.PO1";
 }
 * @param errorBlock  A block to refer ‘error’ in ‘Establish measurement connection’ in PO1.
 */
-(void)commandFunction:(DisposePO1DeviceFunctionBlock)function DisposeErrorBlock:(DisposePO1ErrorBlock)errorBlock;

/**
 * Query power status
 * @param batteryBlock Battery，from 0～100
 * @param errorBlock Communication error codes
 */
-(void)commandPO1GetDeviceBattery:(DisposePO1BatteryBlock)batteryBlock withErrorBlock:(DisposePO1ErrorBlock)errorBlock;


/**
Measure data  Notification

 PO1NotificationMeasureData

You need to listen to this message to get real-time measurements
 
 The unit of PI is %.

Content of measurement results：
{
    PI = "5.8";
    bpm = 90;
    height = 4;
    spo2 = 98;
    wave =     (
        42,
        41,
        41,
        41,
        40
    );
}
 */


/*
 Disconnect current device
 */

-(void)commandDisconnectDevice;

@end



