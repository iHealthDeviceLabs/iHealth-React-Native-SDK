//
//  HSMacroFile.h
//  HSDemoCode
//
//  Created by zhiwei jing on 14-7-23.
//  Copyright (c) 2014年 zhiwei jing. All rights reserved.
//

#import "HealthUser.h"

#ifndef HSDemoCode_HSMacroFile_h
#define HSDemoCode_HSMacroFile_h

#define RecordLength 16



/**
 HS2 Device Error Code
 */
typedef NS_ENUM(NSInteger,HS2DeviceError){
    /// Battery level is low
    HS2DeviceLowPower = 1,
    /// The Scale failed to initialize
    HS2DeviceEr0 = 2,
    /// Maximum weight has been exceeded
    HS2DeviceEr1 = 3,
    /// The Scale can't capture a steady reading
    HS2DeviceEr2 = 4,
    /// Bluetooth connection error
    HS2DeviceEr4 = 5,
    /// Movement while measuring
    HS2DeviceEr7 = 6,
    ///Invalidate
    HS2DeviceEr8 = 7,
    /// Scale memory access error
    HS2DeviceEr9 = 8,
    /// No memory  9
    HS2DataZeor = 9,
    ///Device disconnect
    HS2DeviceDisconnect = 10,
    /// Communication error
    HS2DeviceSendTimeout = 11,
    /// DeviceRecWeightError
    HS2DeviceRecWeightError = 12,
};
/**
 HS2S Device Error Code
 */
typedef NS_ENUM(int, HS2SDeviceError) {
    HS2SDeviceError_Unknown = -1,// device send wrong error code
    HS2SDeviceError_CommunicationTimeout = 0,
    HS2SDeviceError_ReceivedCommandError,
    HS2SDeviceError_InputParameterError,
    HS2SDeviceError_MoreThanMaxNumbersOfUser,
    HS2SDeviceError_WriteFlashError,
    HS2SDeviceError_UserNotExist,
    HS2SDeviceError_StartMeasureError,
    HS2SDeviceError_MeasureTimeout,
    HS2SDeviceError_MeasureOverweight,
    HS2SDeviceError_Disconnect,
    HS2SDeviceError_Unsupported,
};


/**
 HS3 Device Error Code
 */
typedef NS_ENUM(NSInteger,HS3DeviceError){
    /// Low battery
    HS3DeviceLowPower = 1,
    /// Weight capacity is exceeded
    HS3DeviceEr2 = 2,
    /// The Scale calibration error
    HS3DeviceEr4 = 3,
    /// Movement while measuring
    HS3DeviceEr7 = 4,
    /// No memory
    HS3DataZeor = 5, //No memory
    /// Device disconnect
    HS3DeviceDisconnect = 6,
    /// Communication error
    HS3DeviceSendTimeout = 7,
};


/**
 HS4 Device Error Code
 */
typedef NS_ENUM(NSInteger,HS4DeviceError){
    /// Battery level is low
    HS4DeviceLowPower = 1, // Battery level is low
    /// The Scale failed to initialize
    HS4DeviceEr0 = 2,
    /// Maximum weight has been exceeded
    HS4DeviceEr1 = 3,
    /// The Scale can't capture a steady reading
    HS4DeviceEr2 = 4,
    /// Bluetooth connection error
    HS4DeviceEr4 = 5,
    /// Movement while measuring
    HS4DeviceEr7 = 6,
    /// Invalidate
    HS4DeviceEr8 = 7,
    /// Scale memory access error
    HS4DeviceEr9 = 8,
    /// No memory
    HS4DataZeor = 9 ,
    /// Device disconnect
    HS4DeviceDisconnect = 10,
    /// Communication error
    HS4DeviceSendTimeout = 11, // Communication error
    /// Device Recive Weight Error
    HS4DeviceRecWeightError = 12,
};

/**
 HS5 error
 */
typedef NS_ENUM(NSInteger,HS5DeviceError){
    /// Communication error
    IHSCOverTimeError = 0,
    /// Communication Error
    IHSCUserInScale=5,
    /// Make sure batteries are installed correctly, if the problem persists, replace with a new set of batteries.
    IHSCLowPower=6,
    /// Remove the batteries, wait 1 minute and then replace with a new set of batteries.
    IHSCScaleEr0=7,
    /// The current weight may be beyond the measurement range of 330 lbs/150 kg.
    IHSCScaleEr1=8,
    /// Stand still on all four electrodes with bare feet.
    IHSCScaleEr2=9,
    /// Communication Error
    IHSCScaleEr7=10,
    /// Communication Error
    IHSCScaleEr8=11,
    /// Communication Error
    IHSCScaleEr9=12,
    /// Scale is busy
    IHScaleBusy=13,
    /// No memory
    HS5DataZeor=14,// No memory
    /// Scale Create User Test Error
    IHSCScaleCreateUserTestError = 15,
    /// Device disconnect
    HS5Disconnect = 16,
    /// User verify error
    HS5UserInvalidate = 400
};

//HS6 Unit

/**
 HS6 Unit
 
 */
typedef NS_ENUM(NSInteger,IHHS6SDKUnitWeight){
    /// kg
    IHHS6SDKUnitWeight_kg = 0,
    /// lb
    IHHS6SDKUnitWeight_lbs,
    /// st
    IHHS6SDKUnitWeight_oz,
};

#pragma mark HS2  Block

/**
 Result

 @param resetSuc reset Success
 */
typedef void (^DisposeHS2Result)(BOOL resetSuc);

/**
 HS4 error

 @param errorID error number
 */
typedef void (^DisposeHS2ErrorBlock)(HS2DeviceError errorID);


/**
Start transfer Memory Dictionary(5)

 @param startDataDictionary Memory Data Dictionary
 */
typedef void (^StartHS2Transmission)(NSDictionary *startDataDictionary);

/**
 Memory transmission progress

 @param progress progress 0.0～1.0.
 */
typedef void (^DisposeHS2Progress)(NSNumber *progress);
//data including weight (kg), measurement time，coordinated key：weight，date.

/**
 historyDataArray including weight (kg), measurement time，coordinated key：weight，date.

 @param historyDataArray historyDataArray
 */
typedef void (^HS2MemorryData)(NSArray *historyDataArray);

/**
 Finish memory transmission.
 */
typedef void (^FinishHS2Transmission)(void);
//Current weight, (Kg)

/**
 Current  unstable weight, (Kg)

 @param unStableWeight unStableWeight
 */
typedef void (^HS2UnStableWeight)(NSNumber *unStableWeight);
//Stable weight, (Kg)

/**
 StableWeightDictionary  including stableweight(kg),time,dataID

 @param StableWeightDic StableWeightDictionary
 */
typedef void (^HS2StableWeight)(NSDictionary *StableWeightDic);

/**
 DisposeSendHS2DataBlock
 */
typedef void (^DisposeSendHS2DataBlock)(void);

/**
 HS2 battery

 @param battary battery
 */
typedef void (^DisposeHS2BatteryBlock)(NSNumber *battary);


#pragma mark HS3  Block
/**
 deviceID

 @param weightID deviceID
 */
typedef void(^WeightID)(NSString *weightID);
//HS3Error

/**
 HS3 Device Error

 @param errorID errorID
 */
typedef void (^DisposeHS3ErrorBlock)(HS3DeviceError errorID);

/**
 Memory Number，0～200.

 @param uploadDataNum Memory Number
 */
typedef void (^DisposeHS3UploadDataNum)(NSNumber *uploadDataNum);

/**
 Memory transmission progress，0.0～1.0.

 @param progress Transmission progress
 */
typedef void (^DisposeHS3Progress)(float progress);

/**
 historyData  including weight(kg), measure time，coordinated key：weight、date.

 @param historyDataDic historyDataDictionary
 */
typedef void (^HS3MemorryData)(NSDictionary *historyDataDic);
//Start transmission

/**
 Start transmission

 @param startTransmission YES or NO
 */
typedef void (^StartHS3Transmission)(BOOL startTransmission);

/**
 Finish memory transmission.
 */
typedef void (^FinishHS3Transmission)(void);

/**
 Stable weight (Kg)

 @param StableWeightDic StableWeightNSDictionary
 */
typedef void (^StableHS3Weight)(NSDictionary *StableWeightDic);

/**
 FinishHS3Init
 */
typedef void (^FinishHS3Init)(void);

/**
 DisposeResult

 @param resetSuc YES or NO
 */
typedef void (^DisposeResult)(BOOL resetSuc);


#pragma mark HS4  Block
/**
 DisposeResult

 @param resetSuc YES or NO
 */
typedef void (^DisposeResult)(BOOL resetSuc);

/**
 HS4 error

 @param errorID errorID
 */
typedef void (^DisposeHS4ErrorBlock)(HS4DeviceError errorID);

/**
 Start Memory transmission

 @param startDataDictionary startDataDictionary
 */
typedef void (^StartHS4Transmission)(NSDictionary *startDataDictionary);

/**
 Memory transmission progress，0.0～1.0.

 @param progress progress
 */
typedef void (^DisposeProgress)(NSNumber *progress);

/**
 historyDataArray  data including weight (kg), measurement time，coordinated key：weight，date.

 @param historyDataArray historyDataArray
 */
typedef void (^MemorryData)(NSArray *historyDataArray);

/**
 Finish memory transmission.
 */
typedef void (^FinishHS4Transmission)(void);

/**
 Current  unstableweight, (Kg)

 @param unStableWeight unStableWeight
 */
typedef void (^UnStableWeight)(NSNumber *unStableWeight);

/**
 Stable weight,(Kg)

 @param StableWeightDic StableWeightDictionary
 */
typedef void (^StableWeight)(NSDictionary *StableWeightDic);

/**
 SendHS4DataBlock
 */
typedef void (^DisposeSendHS4DataBlock)(void);


#pragma mark HS5  Block

/**
 Existing user info in HS5，including serialNub、Position of users. Related key: serialNumber、position

 @param userListDataArray userListDataArray
 */
typedef void (^MemorryUserListHS5Data)(NSArray *userListDataArray);

/**
 HS5 result

 @param resetSuc reset success
 */
typedef void (^DisposeHS5Result)(BOOL resetSuc);

/**
 HS5 error

 @param errorID errorID
 */
typedef void (^DisposeHS5ErrorBlock)(HS5DeviceError errorID);

/**
 Start memory transmission.

 @param startHS5Transmission startHS5Transmission
 */
typedef void (^StartHS5Transmission)(BOOL startHS5Transmission);

/**
 progress: Memory transmission progress，0.0～1.0.

 @param progress progress
 */
typedef void (^DisposeHS5Progress)(NSNumber *progress);

/**
 Record data，More details and key refer Measure API. Additionally add time-measure property, related key: date.

 @param historyDataDic historyDataDictionary
 */
typedef void (^MemorryHS5Data)(NSDictionary *historyDataDic);

/**
 Finish Memory Transmission

 @param finishHS5Transmission YES or NO
 */
typedef void (^FinishHS5Transmission)(BOOL finishHS5Transmission);

/**
 Current unstableweight, (kg)

 @param unStableWeight unStableWeight
 */
typedef void (^UnStableHS5Weight)(NSNumber *unStableWeight);

/**
 Stable weight, (kg)

 @param StableWeight StableWeight
 */
typedef void (^StableHS5Weight)(NSNumber *StableWeight);

/**
 Weight by impedence, (kg)

 @param ImpedanceWeight ImpedanceWeight
 */
typedef void (^ImpedanceWeight)(NSNumber*ImpedanceWeight);

/**
 body info, includes weight(kg), fat content(%), water content(%), muscle content(%), bone mass, visceral fat level, DCI(Kcal). keys: weight, weightFatValue, waterValue, muscleValue, skeletonValue, VFatLevelValue, DCIValue


 @param BodyCompositionInforDic BodyCompositionInforDictionary
 */
typedef void (^BodyCompositionMeasurements)(NSDictionary*BodyCompositionInforDic);

/**
 superPassword

 @param superPassword  superPassword
 */
typedef void (^GetScaleSuperPassword)(NSString*superPassword);

/**
 CurrentSerialNub

 @param serialNub serialNub
 */
typedef void (^CurrentSerialNub)(NSInteger serialNub);

/**
 SendHS5DataBlock
 */
typedef void (^DisposeSendHS5DataBlock)(void);


#pragma mark HS6  Block

/**
 Set HS6 wifi  success with device infomation

 @param deviceInfo deviceInfo
 */
typedef void (^DisposeHS6SuccessBlock)(NSDictionary* deviceInfo);

/**
 Set HS6 wifi  fail

 @param failmsg fail message
 */
typedef void (^DisposeHS6FailBlock)(NSString* failmsg);

/**
 Set  HS6 end

 @param deviceDic deviceDictionary
 */
typedef void (^DisposeHS6EndBlock)(NSDictionary* deviceDic);

/**
 HS6 error

 @param error  error number
 */
typedef void (^DisposeHS6ErrorBlock)(NSNumber* error);

/**
 Binding QR Device

 @param resultArray resultArray
 */
typedef void(^BinedQRDeviceBlock)(NSArray *resultArray);
/**
 Binding QR Device error

 @param errorCode errorCode
 */
typedef void(^BinedQRDeviceErrorBlock)(NSString *errorCode);

/**
 unbind  QRDevice

 @param resultArray resultArray
 */
typedef void(^DisBinedQRDeviceBlock)(NSArray *resultArray);

/**
 unbind QRDevice error

 @param errorCode errorCode
 */
typedef void(^DisBinedQRDeviceErrorBlock)(NSString *errorCode);

/**
 getOpenApi

 @param openAPIInfoDic openAPIInfoDictionary
 */
typedef void (^DisposeHS6GetOpenAPISuccessBlock)(NSDictionary* openAPIInfoDic);

/**
 GetOpenAPIError

 @param errorCode errorCode
 */
typedef void (^DisposeHS6GetOpenAPIErrorBlock)(NSDictionary *errorCode);

/**
 sync Weight Unit

 @param syncWeightUnit syncWeightUnit
 */
typedef void (^DisposeHS6SyncWeightUnitSuccessBlock)(BOOL syncWeightUnit);

/**
 Sync Weight Unit Error

 @param errorCode errorCode
 */
typedef void (^DisposeHS6SyncWeightUnitErrorBlock)(NSString *errorCode);


//typedef void (^BlockUserAuthentication)(UserAuthenResult result);

/**
 the result of userID

 @param dataArray dataArray
 */

typedef void (^BlockDataFromCloud)(NSArray *dataArray);

typedef void (^BlockHS6DataFromCloud)(NSDictionary *dataDic);

typedef void (^BlockHS6LastTSFromCloud)(NSNumber *lastTS);

#pragma mark HS2S  Block


/**
 Result
 
 @param deviceInfo deviceInfo
 */
typedef void (^DisposeHS2SDeviceInfo)(NSDictionary*deviceInfo);

/**
 HS2S error
 
 @param errorID error number
 */
typedef void (^DisposeHS2SErrorBlock)(HS2SDeviceError errorID);

/**
 HS2S battery
 
 @param battary battery
 */
typedef void (^DisposeHS2SBatteryBlock)(NSNumber *battary);

/**
 HS2S UserInfo
 
 
 @param userInfo userInfo
 */
typedef void (^DisposeHS2SUserInfo)(NSDictionary*userInfo);

/**
 Result
 
 @param result reset Success
 */
typedef void (^DisposeHS2SResult)(BOOL result);

/**
 HS2S memory count
 
 @param count count
 */
typedef void (^DisposeHS2SMemoryCountBlock)(NSNumber *count);

/**
 HS2S memory data
 
 @param data data
 */
typedef void (^DisposeHS2SMemoryDataBlock)(NSArray *data);

/**
 HS2S memory count
 
 @param count count
 */
typedef void (^DisposeHS2SAnonymousMemoryCountBlock)(NSNumber *count);

/**
 HS2S memory data
 
 @param data data
 */
typedef void (^DisposeHS2SAnonymousMemoryDataBlock)(NSArray *data);
/**
 Current  unstableweight, (Kg)
 
 @param unStableWeight unStableWeight
 */
typedef void (^DisposeHS2SUnStableWeight)(NSNumber *unStableWeight);

/**
 Stable weight,(Kg)
 
 @param stableWeight StableWeight
 */
typedef void (^DisposeHS2SStableWeight)(NSNumber *stableWeight);

/**
   weightAndBodyInfoDic
 
 @param weightAndBodyInfoDic weightAndBodyInfoDic
 */
typedef void (^DisposeHS2SWeightAndBodyInfo)(NSDictionary *weightAndBodyInfoDic);


/**
 Heart  Result
 
 @param heartResultDic
 */
typedef void (^DisposeHS2SHeartResult)(NSDictionary *heartResultDic);


/**
 MeasurementStatus
 
 @param measurementStatus
 */
typedef void (^DisposeHS2SMeasurementStatus)(NSNumber *measurementStatus);



typedef void (^DisposeHS2SMeasureFinish)(void);

#define HS3ConnectNoti @"HS3ConnectNoti"
#define HS3DisConnectNoti @"HS3DisConnectNoti"

#define HS2Discover        @"HS2Discover"
#define HS2ConnectFailed   @"HS2ConnectFailed"
#define HS2ConnectNoti    @"HS2ConnectNoti"
#define HS2DisConnectNoti @"HS2DisConnectNoti"

#define HS2SDiscover        @"HS2SDiscover"
#define HS2SConnectFailed   @"HS2SConnectFailed"
#define HS2SConnectNoti    @"HS2SConnectNoti"
#define HS2SDisConnectNoti @"HS2SDisConnectNoti"

#define HS4Discover        @"HS4Discover"
#define HS4ConnectFailed   @"HS4ConnectFailed"
#define HS4ConnectNoti    @"HS4ConnectNoti"
#define HS4DisConnectNoti @"HS4DisConnectNoti"


#define HS5ConnectNoti @"HS5ConnectNoti"
#define HS5DisConnectNoti @"HS5DisConnectNoti"

#define HSDeviceID @"ID"
#define HSSDKRightApi  @"OpenApiWeight"


#define ContinuaHSDiscover        @"ContinuaHSDiscover"
#define ContinuaHSConnectFailed   @"ContinuaHSConnectFailed"
#define ContinuaHSConnectNoti @"ContinuaHSConnectNoti"
#define ContinuaHSDisConnectNoti @"ContinuaHSDisConnectNoti"


#endif
