//
//  PT3SBT.h
//  iHealthSDKStatic
//
//  Created by user on 2020/9/7.
//  Copyright © 2020 ihealthSDK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PT3SBTMacroFile.h"
NS_ASSUME_NONNULL_BEGIN

@interface PT3SBT : NSObject

@property (strong, nonatomic) NSString *serialNumber;
@property (strong, nonatomic) NSString *currentUUID;

/**
 * Get device IDPS (After the PT3SBT device is successfully connected, the interface must be called to synchronize the device time. Otherwise, the offline data measurement time error will be caused)
 * @param function  A block to return the function and states that the device supports.
 * {
     MAC = D379D238F6B3;
     accessoryName = PT;
     firmwareVersion = "1.1.0";
     hardwareVersion = "1.0.0";
     manufaturer = iHealth;
     modelNumber = PT3SBT;
     protocol = "com.jiuan.PT3SBT";
 }
 * @param disposeErrorBlock  A block to refer ‘error’ in ‘Establish measurement connection’ in PT3SBT.
 */
-(void)commandFunction:(DisposePT3SBTDeviceFunctionBlock)function DisposeErrorBlock:(DisposePT3SBTErrorBlock)disposeErrorBlock;

/**
 *Get  Battery

 * @param battery  [Range:0～100]%
 * @param disposeErrorBlock error code
 */
-(void)commandGetPT3SBTBattery:(DisposePT3SBTBatteryBlock)battery DiaposeErrorBlock:(DisposePT3SBTErrorBlock)disposeErrorBlock;


/**
 * Set Unit
 * @param unitState
 * /// Degrees Celsius
    PT3SBTTemperatureUnit_C=1,
    /// Fahrenheit
    PT3SBTTemperatureUnit_F,
 * @param disposeSetUnitResult YES:success NO:fail
 * @param disposeErrorBlock This block returns error codes,please refer to error codes list in PT3SBTMacroFile.
 */
-(void)commandPT3SBTSetUnit:(PT3SBTTemperatureUnit)unitState
   DisposeSetUnitResult:(DisposePT3SBTSetUnit)disposeSetUnitResult
    DisposeErrorBlock:(DisposePT3SBTErrorBlock)disposeErrorBlock;

/**
 * Get Unit
 * @param disposeGetUnitResult  PT3SBTTemperatureUnit
 * @param disposeErrorBlock This block returns error codes,please refer to error codes list in PT3SBTMacroFile.
 */
-(void)commandPT3SBTGetUnit:(DisposePT3SBTGetUnit)disposeGetUnitResult
    DisposeErrorBlock:(DisposePT3SBTErrorBlock)disposeErrorBlock;

/**
 * Get memory data count
 * @param disposeMemoryCount  count
 * @param disposeErrorBlock This block returns error codes,please refer to error codes list in PT3SBTMacroFile.
 */
-(void)commandPT3SBTGetMemoryCount:(DisposePT3SBTGetMemoryCount)disposeMemoryCount
    DisposeErrorBlock:(DisposePT3SBTErrorBlock)disposeErrorBlock;

/**
 Tranfer offline history records.
 For PT3SBT, after calling this method, you should call commandDeleteMemorryData: method. Otherwise, the measure date may be wrong.
 [
 {
     Distance = 1783;
     TS = 1600064558;
     Tamb = 274;
     Tbody = 3520;
     Tex = 268;
     Tobj = 273;
     Vbat = 282;
 }
]
 @param disposeMemoryData The offline history records detail, result means result, date means the measurement time.
 @param disposeErrorBlock This block returns error codes,please refer to error codes list in PT3SBTMacroFile.
 */
-(void)commandGetMemorryData:(DisposePT3SBTMemoryData)disposeMemoryData
              DisposeErrorBlock:(DisposePT3SBTErrorBlock)disposeErrorBlock;

/**
 Delete offline history records

 @param disposeDeleteData  YES or NO
 @param disposeErrorBlock This block returns error codes,please refer to error codes list in PT3SBTMacroFile.
 */
-(void)commandDeleteMemorryData:(DisposePT3SBTDeleteData)disposeDeleteData
            DisposeErrorBlock:(DisposePT3SBTErrorBlock)disposeErrorBlock;

/**
 Measure data  Notification

  PT3SBTNotificationGetResult
 
 You need to listen to this message to get real-time measurements
 
 Content of measurement results：
 {
     Distance = 1663;
     Tamb = 275;
     Tbody = 3521;
     Tex = 269;
     Tobj = 274;
     Vbat = 281;
 }
*/

/**
 PT3SBT unit  change  Notification

  PT3SBTNotificationDeviceUnitChange
 
 If the PT3SBT unit changes, you will receive this notification
 
   /// Degrees Celsius
    PT3SBTTemperatureUnit_C=1,
    /// Fahrenheit
    PT3SBTTemperatureUnit_F,
 
 Content of PT3SBTNotificationDeviceUnitChange  results：
 {
     unit=1;
 }
*/

/**
 Get Device Info

 @param disposeDeviceInfo   device info
 {
     "Amb16_OBJ37_Temp" = 4209;
     "Amb25_ByCb2" = 2459;
     "Amb25_NtcR25" = 10028;
     "Check_AmbTemp" = 2438;
     "Corr16_AmbTemp" = 1807;
     "Corr25_AmbTemp" = 2484;
     "Corr_k1_Value" = 10336;
     "Corr_k2_Value" = 9896;
     "Distance_CorrValue" = 284;
     Version = 1112;
     VersionDate = 200904;
 }
 @param disposeErrorBlock This block returns error codes,please refer to error codes list in PT3SBTMacroFile.
 */
-(void)commandGetDeviceInfo:(DisposePT3SBTDeviceInfo)disposeDeviceInfo
            DisposeErrorBlock:(DisposePT3SBTErrorBlock)disposeErrorBlock;

/**
 * Disconnect current device
 */
-(void)commandDisconnectDevice;

@end

NS_ASSUME_NONNULL_END
