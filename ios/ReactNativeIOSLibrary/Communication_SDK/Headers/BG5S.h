//
//  BG5S.h
//  iHealthSDKStatic
//
//  Created by Lei Bao on 2017/6/30.
//  Copyright © 2017年 daiqingquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BGMacroFile.h"

// --------------- DELEGATE ---------------
@class BG5S;

/**
 BG5SDelegate
 */
@protocol BG5SDelegate <NSObject>
@required

/**
 Device sends an error

 @param device active device
 @param error error number
 @param errorDescription error message
 */
- (void)device:(BG5S *)device occurError:(BG5SError)error errorDescription:(NSString *)errorDescription;

/**
 Device sends strip state message
 @note Only after startMeasure: method is called, does the device send strip state message.
 If you insert strip before calling startMeasure: method, the device doesn't send strip state(Insert or Pull off) until startMeasure: method is called.
 @param device active device
 @param state BG5SStripState enum
 */
- (void)device:(BG5S *)device stripStateDidUpdate:(BG5SStripState)state;

/**
 Device sends drop blood or ctl message
 @note After reciving this message, you should not call any method until you recive result. If called, the method may be timeout.
 @param device active device
 */
- (void)deviceDropBlood:(BG5S *)device;

/**
 Device sends result

 @param device active device
 @param dataID data identifier (Only for SDK users)
 @param result blood glucose value with mg/dL unit
 */
- (void)device:(BG5S *)device dataID:(NSString *)dataID measureReult:(NSInteger)result;

/**
 Device sends charging state
 @note Only state changes, is the message sent.
 @param device active device
 @param state BG5SChargeState object
 */
- (void)device:(BG5S *)device chargeStateDidUpdate:(BG5SChargeState)state;
@end

/**
 state information of BG5S when call "queryStateInfoWithSuccess:"
 */
@interface BG5SStateInfo : NSObject

/**
 0-100 means battery percent, 255 means charging
 */
@property (assign, nonatomic, readonly) NSInteger batteryValue;

/**
 device date (UTC)
 */
@property (copy, nonatomic, readonly) NSDate *deviceDate;

/**
 device timezon -12.00 to 14.00. Without setting, default timezone is 0.00
 */
@property (assign, nonatomic, readonly) float deviceTimeZone;

/**
 quantity of strip used in measurement.range:[0,65535]. If value is 65535, there may be something wrong with BG5S. Because 65535 is very large number for true user.
 */
@property (assign, nonatomic, readonly) NSInteger stripUsedValue;

/**
 quantity of record measuring without connecting to APP.range:[0,500]. If value is 65535, there may be something wrong with BG5S.
 */
@property (assign, nonatomic, readonly) NSInteger offlineDataQuantity;

/**
 blood code version (0-255)
 */
@property (assign, nonatomic, readonly) NSInteger bloodCodeVersion;

/**
 ctl code version (0-255)
 */
@property (assign, nonatomic, readonly) NSInteger ctlCodeVersion;

/**
 measure unit (BGUnit_Unknown means that BG5S has never been set unit from App,BGUnit_mmolPL stands for mmol/L,BGUnit_mgPmL stands for mg/dL)
 */
@property (assign, nonatomic, readonly) BGUnit unit;

@end

/**
 Offline data model of BG5S
 */
@interface BG5SRecordModel : NSObject

/**
 Data ID (Only for SDK users)
 */
@property (copy, nonatomic, readonly) NSString *dataID;

/**
 Measure Date (UTC)
 */
@property (copy, nonatomic, readonly) NSDate *measureDate;

/**
 Time zone
 */
@property (assign, nonatomic, readonly) float timeZone;

/**
 BG Value with mg/dL unit
 */
@property (assign, nonatomic, readonly) NSInteger value;

/**
 Correct Flag, YES:can be corrected, NO:cannot be corrected
 */
@property (assign, nonatomic, readonly) BOOL canCorrect;

@end

/**
 Modified offline data model of BG5S
 */
@interface BG5SRecordModifiedModel : NSObject

/**
 Data ID (Only for SDK users)
 */
@property (copy, nonatomic) NSString *dataID;

/**
 Measure Date (UTC)
 */
@property (copy, nonatomic) NSDate *measureDate;

/**
 Time zone
 */
@property (assign, nonatomic,) float timeZone;

/**
 BG Value with mg/dL unit
 */
@property (assign, nonatomic) NSInteger value;

@end

/**
 BG5S
 */
@interface BG5S : BGDevice

@property (weak, nonatomic) id<BG5SDelegate> delegate;

/**
 Query BG5S state information including battery value,device date, device timezone, strip used, quantity of offline data, blood code version, CTL code version, unit.

 @param stateInfoBlock BG5SStateInfo object
 @param errorBlock the block means fail. You can get error from this block
 @note  If analysis occurs error, BG5SStateInfo object maybe nil or some of its property are nil.
 */
- (void)queryStateInfoWithSuccess:(BG5SStateInfoBlock)stateInfoBlock
                       errorBlock:(BG5SSDKErrorBlock)errorBlock;

/**
 Set time

 @param date the date you want to set should be an UTC time. valid range:Jan. 1,2000 - Dec. 31,2099. If date is nil, use [NSdate date] and system time zone
 @param timezone the timezone you want to set should be from -12.00 to 14.00; step length = 0.25
 @param successBlock the block means success
 @param errorBlock the block means fail. You can get error from this block
 @note  If date is out of reange, BG5SError_InputParametersError will be returned by block. 
        If date and timezone are invalid , use input parameters; otherwise use [NSdate date] and system time zone;
 */
- (void)setTimeWithDate:(NSDate *)date
               timezone:(float)timezone
           successBlock:(BG5SSuccessBlock)successBlock
             errorBlock:(BG5SSDKErrorBlock)errorBlock;

/**
 Set unit

 @param unit the unit you want to set (BGUnit_mmolPL stands for mmol/L,BGUnit_mgPmL stands for mg/dL)
 @param successBlock the block means success
 @param errorBlock the block means fail. You can get error from this block
 */
- (void)setUnit:(BGUnit)unit
   successBlock:(BG5SSuccessBlock)successBlock
      errorBlock:(BG5SSDKErrorBlock)errorBlock;

/**
 Delete strip used info (the quantity of strip used is set to 0)

 @param successBlock the block means success
 @param errorBlock the block means fail. You can get error from this block
 */
- (void)deleteStripUsedInfoWithSuccessBlock:(BG5SSuccessBlock)successBlock
                                  errorBlock:(BG5SSDKErrorBlock)errorBlock;

/**
 Query record data stored in BG5S

 @param successBlock the block means success; if has record, return non-empty array (BG5SRecordModel object); if no record, return empty array
 @param errorBlock the block means fail. You can get error from this block
 */
- (void)queryRecordWithSuccessBlock:(BG5SRecordBlock)successBlock
                          errorBlock:(BG5SSDKErrorBlock)errorBlock;


/**
 Delete record data stored in BG5S
 
 @param successBlock the block means success
 @param errorBlock the block means fail. You can get error from this block
 */
- (void)deleteRecordWithSuccessBlock:(BG5SSuccessBlock)successBlock
                          errorBlock:(BG5SSDKErrorBlock)errorBlock;

/**
 Start online measurement with specific measure mode. 
 
 @note  If you don't call this method, BG5S use blood mode by default. 
 
 If CTL mode is sent, BG5S use CTL mode and BG5S can't be set to use blood mode until next connection.
 @param measureMode Blood or CTL
 @param successBlock the block means success
 @param errorBlock the block means fail. You can get error from this block
 */
- (void)startMeasure:(BGMeasureMode)measureMode
    withSuccessBlock:(BG5SSuccessBlock)successBlock
           errorBlock:(BG5SSDKErrorBlock)errorBlock;

/**
 Disconnect device
 */
- (void)disconnectDevice;

/**
 Correct Measure Date if canCorrect is YES in BG5SRecordModel

 @param array BG5SRecordModel objects
 @param deviceDate This date should be read before set time method called.
 @return BG5SRecordModifiedModel objects; return empty array means input parameters is wrong.
 */
- (NSArray *)processData:(NSArray<BG5SRecordModel*> *)array deviceDate:(NSDate *)deviceDate;


/**
 
 Is offline measurement allowed
 
 @param isOffline  Is offline measurement allowed    0:allowed  1:Offline measurement is not allowed
 @param successBlock the block means success
 @param errorBlock the block means fail. You can get error from this block
 */
- (void)setIsOfflineMeasurementAllowed:(BOOL)isOffline
successBlock:(BG5SSuccessBlock)successBlock
                          errorBlock:(BG5SSDKErrorBlock)errorBlock;


- (void)setCodeWithMeasureMode:(BGMeasureMode)mode
                   resultBlock:(BG5SSetCodeResultBlock)resultBlock
                    errorBlock:(BG5SSDKErrorBlock)errorBlock;

- (void)readDeviceInfoWithSuccessBlock:(BG5SDeviceInfoBlock)deviceInfoBlock
 errorBlock:(BG5SSDKErrorBlock)errorBlock;

@end
