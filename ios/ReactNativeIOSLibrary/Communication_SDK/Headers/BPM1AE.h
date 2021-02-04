//
//  BPM1AE.h
//  iHealthDemoCode
//
//  Created by XuJianbo on 16/8/18.
//  Copyright © 2016年 zhiwei jing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WifiSetWifiError) {
    WifiDidDisconnect=0,//下位机断开
    WifiOverTimeError,//超时
    WifiParameterInputWrong=400,//输入参数错误
};


typedef void(^BlockWifiError)(WifiSetWifiError error);
typedef void(^BlockWifiSetSuccess)(NSNumber *waitFlg);
typedef void(^BlockWifiConnectState)(void);
typedef void(^BlockWifiInfoDictionary) (NSDictionary *dict);


#define Wifi_SSID @"Wifi_SSID"
#define Wifi_Channel @"Wifi_Channel"
#define Wifi_Security @"Wifi_Security"
#define Wifi_RSSI @"Wifi_RSSI"



/**
 BPM1AE device class
 */
@interface BPM1AE : NSObject


/**
 *Start search the UDP access point device.
 * @param wifiIDPSDic   A block return the IDPS of the connected wifi Device.
 * @param error This block will be invoked when error occurs.
 * Specification:
 *   1.  WifiDidDisconnect: Socket connection disconnected.
 *   2.  WifiOverTimeError:  Command time out.
 *   3.  WifiParameterInputWrong:  Input wrong parameter(s).
 */
-(void)commandStartSearchDeviceGetIDPS:(BlockWifiInfoDictionary)wifiIDPSDic  blockError:(BlockWifiError)error;
/**
 *Start search the UDP access point device.
 * @param blockWifiArrayDic The block return a dictionary which contains the wifi list and the wifi count that the device scan.
 * @param error This block will be invoked when error occurs.
 * Specification:
 *   1.  WifiDidDisconnect: Socket connection disconnected.
 *   2.  WifiOverTimeError:  Command time out.
 *   3.  WifiParameterInputWrong:  Input wrong parameter(s).
 */
-(void)commandGetWifiArrayDictionary:(BlockWifiInfoDictionary)blockWifiArrayDic blockError:(BlockWifiError)error;

/**
 *Send wifi name and password to the device and return the connect status of the device.
 * @param wifiName  wifiname
 * @param password  wifiName，password are the information of the wifi that selected to connect.
 * @param phoneIDStr The unique device ID of the current iPhone,iTouch or iPad.
 * @param urlStr   a service URL, to where the AP device send the wifi connect status.
 * @param setResult The block return means set success, containing a flg to show whether need to wait the 'stepAndStateDic', @1 means need，@0 means not.
 * @param stepAndStateDic The block return a dictionary which contains the connection step and the connection status.
 * @param error This block will be invoked when error occurs.
 * Specification:
 *   1.  WifiDidDisconnect: Socket connection disconnected.
 *   2.  WifiOverTimeError:  Command time out.
 *   3.  WifiParameterInputWrong:  Input wrong parameter(s).
 */
-(void)commandSendWifiName:(NSString*)wifiName password:(NSString *) password phoneID:(NSString *)phoneIDStr withURL:(NSString *)urlStr setResult:(BlockWifiSetSuccess)setResult blockConnectState:(BlockWifiInfoDictionary)stepAndStateDic blockError:(BlockWifiError)error;


/**
 Disconnect current socket
 */
- (void)disconnect;

@end
