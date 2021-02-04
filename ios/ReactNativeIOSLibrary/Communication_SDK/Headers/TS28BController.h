//
//  TS28BController.h
//  iHealthSDKStatic
//
//  Created by Lei Bao on 2017/6/13.
//  Copyright © 2017年 daiqingquan. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 TemperatureType
 */
typedef NS_ENUM(NSInteger, TemperatureType) {
    /// NotDefined
    TemperatureType_NotDefined = 0,
    /// Armpit
    TemperatureType_Armpit,
    /// Body
    TemperatureType_Body,
    /// Ear
    TemperatureType_Ear,
    /// Finger
    TemperatureType_Finger,
    /// GastroIntestinalTract
    TemperatureType_GastroIntestinalTract,
    /// Mouth
    TemperatureType_Mouth,
    /// Rectum
    TemperatureType_Rectum,
    /// Toe
    TemperatureType_Toe,
    /// Tympanum
    TemperatureType_Tympanum,
};

/**
 TemperatureUnit
 */
typedef NS_ENUM(NSInteger, TemperatureUnit) {
    /// NotDefined
    TemperatureUnit_NotDefined = 0,
    /// Degrees Celsius
    TemperatureUnit_C,
    /// Fahrenheit
    TemperatureUnit_F,
};

@class TS28B;
@class TS28BController;

/**
 TS28BControllerDelegate
 */
@protocol TS28BControllerDelegate <NSObject>

@optional

/**
 Discover device.

 @param controller who calls this method
 @param device Discovered device
 */
- (void)controller:(TS28BController *)controller didDiscoverDevice:(TS28B *)device;

/**
 Connect device successfully.After connect and read Device Information, this method will be called.

 @param controller who calls this method
 @param device Connected device
 */
- (void)controller:(TS28BController *)controller didConnectSuccessDevice:(TS28B *)device;

/**
 Connect device Fail.

 @param controller who calls this method
 @param device The spectific device
 */
- (void)controller:(TS28BController *)controller didConnectFailDevice:(TS28B *)device;

/**
 Device is disconnected.    If you turn off your phone’s Bluetooth, please listen for the notification: @"BTLEPowerOff"

 @param controller who calls this method
 @param device The spectific device
 */
- (void)controller:(TS28BController *)controller didDisconnectDevice:(TS28B *)device;

/**
 Temperature is uploaded.

 @param controller who calls this method
 @param device The spectific device
 @param value temperature value. 
 @param unit temperature unit.TemperatureUnit type, reference: https://www.bluetooth.com/specifications/gatt/viewer?attributeXmlFile=org.bluetooth.characteristic.temperature_measurement.xml
 @param date measure date
 @param type measure location. TemperatureType type, reference: https://www.bluetooth.com/specifications/gatt/viewer?attributeXmlFile=org.bluetooth.characteristic.temperature_type.xml
 */
- (void)controller:(TS28BController *)controller device:(TS28B *)device didUpdateTemperature:(float)value temperatureUnit:(TemperatureUnit)unit measureDate:(NSDate *)date measureLocation:(TemperatureType)type;

@end

/**
 TS28BController
 */
@interface TS28BController : NSObject

@property (weak, nonatomic) id<TS28BControllerDelegate> delegate;

/**
 Initialize TS28BController class

 @return TS28BController class object
 */
+ (TS28BController *)sharedController;
/**
 Star to scan TS28B device
 */
- (void)startScan;

/**
 Stop scanning
 */
- (void)stopScan;

/**
 Connect with spectific device

 @param device TS28B object. You can get it from - (void)controller:(TS28BController *)controller didDiscoverDevice:(TS28B *)device;
 */
- (void)connectDevice:(TS28B *)device;

/**
 Connect with spectific device

 @param device TS28B object. You can get it from - (void)controller:(TS28BController *)controller didConnectSuccessDevice:(TS28B *)device;
 */
- (void)disconnectDevice:(TS28B *)device;

@end
