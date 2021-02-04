//
//  HealthHeader.h
//  iHealthDemoCode
//
//  Created by zhiwei jing on 1/25/16.
//  Copyright © 2016 zhiwei jing. All rights reserved.
//

#ifndef HealthHeader_h
#define HealthHeader_h

typedef NS_ENUM(NSUInteger, HealthDeviceType) {
    //AM
    HealthDeviceType_AM3,
    HealthDeviceType_AM3S,
    HealthDeviceType_AM4,
    //BP
    HealthDeviceType_BP3L,
    HealthDeviceType_BP5SRW,
    HealthDeviceType_BP5S,
    HealthDeviceType_BP7S,
    HealthDeviceType_KN550BT,
    HealthDeviceType_KD926,
    HealthDeviceType_KD723,
    HealthDeviceType_ABPM,
    //PO
    HealthDeviceType_PO3,
    //HS
    HealthDeviceType_HS4,
    HealthDeviceType_HS2,
    //ECG
    HealthDeviceType_ECG3,
    //BG
    HealthDeviceType_BG5S,
    //HTS
    HealthDeviceType_TS28B,
    HealthDeviceType_CONTINUA_BP,
    HealthDeviceType_CONTINUA_BG,
    HealthDeviceType_CONTINUA_PO,
    HealthDeviceType_CONTINUA_HS,
    HealthDeviceType_THV3,
    //BLE Device
    HealthDeviceType_HS3,
    HealthDeviceType_HS5,
    HealthDeviceType_BP3,
    HealthDeviceType_BP5,
    HealthDeviceType_BP7,
    HealthDeviceType_ABI,
    HealthDeviceType_BG1,
    HealthDeviceType_BG3,
    HealthDeviceType_BG5,
    HealthDeviceType_USBECG,
    HealthDeviceType_HS6,
    HealthDeviceType_AM5,
    HealthDeviceType_BP5C,
    HealthDeviceType_HS2S,
    HealthDeviceType_BG1S,
    HealthDeviceType_NT13B,
    HealthDeviceType_PT3SBT,
    HealthDeviceType_PO1,
};

#import "ScanDeviceController.h"
#import "ConnectDeviceController.h"


#endif /* HealthHeader_h */
