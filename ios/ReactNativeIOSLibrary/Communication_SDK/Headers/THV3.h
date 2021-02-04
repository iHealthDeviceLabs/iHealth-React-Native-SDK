//
//  THV3.h
//  iHealthDemoCode
//
//  Created by Realank on 2016/12/23.
//  Copyright © 2016年 zhiwei jing. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 THV3RcvDataType
 */
typedef NS_ENUM(NSUInteger, THV3RcvDataType) {
    /// recieve real time temperature
    THV3RcvDataRT,
    /// recieve button event
    THV3RcvDataButtonStatus,
};

/**
 THV3RcvButtonType
 */
typedef NS_ENUM(NSUInteger, THV3RcvButtonType) {
    /// placeholder
    THV3RcvBtnNone,
    /// power button
    THV3RcvBtnPower,
    /// audio button
    THV3RcvBtnAudio,
    /// M button
    THV3RcvBtnMemory,
    /// unit button
    THV3RcvBtnCF
    
};

/**
 THV3Status
 */
typedef NS_ENUM(NSUInteger, THV3Status) {
    /// not init
    THV3StatusUnInit,
    /// init time
    THV3StatusInitTime,
    /// init configuration
    THV3StatusInitConfig,
    /// working
    THV3StatusWorking,
};

@interface THV3HistoryData : NSObject 
@property (nonatomic, strong) NSDate* measureDate;
@property (nonatomic, assign) float temperature;
@property (nonatomic, assign) BOOL isHumanBody;
@end

/**
 ReceiveHistoryBlock

 @param dataArray THV3HistoryData object's array
 */
typedef void(^ReceiveHistoryBlock)(NSArray<THV3HistoryData*>* dataArray);

/**
 ConfigResultBlock

 @param success YES:success NO:fail
 */
typedef void(^ConfigResultBlock)(BOOL success);

@interface THV3 : NSObject

@property (nonatomic, assign) THV3Status status;//status to flag whether device is ready
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *currentUUID;
//‘serialNumber’ is for separating different device when multiple device have been connected.
@property (strong, nonatomic) NSString *serialNumber;//MAC
@property (strong, nonatomic) NSTimer *firmwareVersion;

@property (nonatomic, assign) THV3RcvDataType rtDataType;
@property (nonatomic, strong) THV3HistoryData* rtTemperature;// for temperature
@property (nonatomic, assign) BOOL voltIsNormal;// for battary
@property (nonatomic, assign) THV3RcvButtonType buttonType;//for button use
@property (nonatomic, assign) BOOL isButtonOn;//for button use

//status
@property (nonatomic, assign) NSInteger idleTimeInterval;
@property (nonatomic, assign) BOOL isUnitCelsius;
@property (nonatomic, assign) BOOL isTargetHuman;
@property (nonatomic, assign) BOOL isOfflineMode;

- (void)readHistoryDataWithResultBlock:(ReceiveHistoryBlock)receivedDataBlock;

- (void)configIdleTime:(NSUInteger)timeInterval withResultBlock:(ConfigResultBlock)resultBlock;
- (void)configTemperUnit:(BOOL)isCelsius withResultBlock:(ConfigResultBlock)resultBlock;
- (void)configMeasureTarget:(BOOL)isHumanBody withResultBlock:(ConfigResultBlock)resultBlock;
- (void)configOfflineMode:(BOOL)isOffline withResultBlock:(ConfigResultBlock)resultBlock;

/**
 Disconnect device. If this method is called immediately after "readHistoryDataWithResultBlock:" method, the history data will not be cleared automatically.
 */
- (void)commandDisconnectDevice;
@end
