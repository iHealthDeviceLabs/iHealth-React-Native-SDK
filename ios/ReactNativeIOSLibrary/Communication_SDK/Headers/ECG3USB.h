//
//  ECG3.h
//  iHealthDemoCode
//
//  Created by daiqingquan on 15/9/15.
//  Copyright (c) 2015年 zhiwei jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECGMacroFile.h"

/**
 Sync Start
 */
typedef void (^ECG3USBSyncStartBlock)(void);

/**
 Sync Progress

 @param progress 0-100
 */
typedef void (^ECG3USBSyncProgressBlock)(NSUInteger progress);

/**
 @brief Sync Result

 @param resultArray An array contains Dictionary
 @code Dictionary format: {
 @"SampleRate":@(sampleRate),
 @"StartTime":startTimeString,
 @"EndTime":endTimeString,
 @"FileName":fileName,
 @"FilePath":path
 });
 @endcode
 @param finish YES means all data has been uploaded, NO means not all data has been uploaded because of some reasons sucn as device disconnect\communication error\iOS device's memory issue\raw data error. The reason you can get from ECG3USBErrorBlock.
 */
typedef void (^ECG3USBSyncResultBlock)(NSArray *resultArray,BOOL finish);

/**
 Sync Error

 @param errorID error ID
 */
typedef void (^ECG3USBErrorBlock)(ECG3USBError errorID);


/**
 Format SD Card Success
 */
typedef void (^ECG3FormatSDCardSuccessBlock)(void);

/**
 Format SD Card Fail
 */
typedef void (^ECG3FormatSDCardFailBlock)(ECG3USBError error);
/**
 Format Progress
 
 @param progress 0-100
 */
typedef void (^ECG3USBFormatProgressBlock)(NSUInteger progress);
/**
 ECG3USB
 */
@interface ECG3USB : NSObject
@property (strong, nonatomic) NSString *currentUUID;
@property (strong, nonatomic) NSString *serialNumber;
@property (strong, nonatomic) NSString *firmwareVersion;

/**
 Sync Data

 @param startBlock means start
 @param progressBlock 0-100
 @param resultBlock You can get filtered data from the NSDocumentDirectory path.
 
 Abnormal Point Marked by User: OBData_FileName.xml
 Filtered ECG Data: ECGAnalyseResult_FileName.dat
 Lead Off Begin Point: ECGLeadOffBegin_FileName.xml
 Lead Off End Point: ECGLeadOffEnd_FileName.xml
 ECG HR Information EveryHour: ECGHREveryHour_FileName.xml
 Abnormal Point Filtered by Algorithm: ECGOBbyFilter_FileName.xml
 ECG HR Information for Day: ECGDetail_FileName.xml
 @param errorBlock error
 
 */
- (void)syncDataWithStartBlock:(ECG3USBSyncStartBlock)startBlock
                 progressBlock:(ECG3USBSyncProgressBlock)progressBlock
                   resultBlock:(ECG3USBSyncResultBlock)resultBlock
                    errorBlock:(ECG3USBErrorBlock)errorBlock;

/**
 Format SD Card

 @param successBlock Success
 @param progressBlock 0-100
 @param failBlock Fail
 */
-(void)formatSDCard:(ECG3FormatSDCardSuccessBlock)successBlock
      progressBlock:(ECG3USBFormatProgressBlock)progressBlock
         errorBlock:(ECG3FormatSDCardFailBlock)failBlock;

/**
 Splice data
 
 @param fileNames An Array with FileName value from ECG3USBSyncResultBlock
 @param successBlock a block contains a dictionary with keys: success(@{@"DataFileName":dataFileName,@"MarkFileName":markFileName,@"StartTime":yyyyMMddHHmmss,@"EndTime":yyyyMMddHHmmss,@"FilePath":directory});
 @param errorBlock a block contains error message
 */
+ (void)spliceWithFileNames:(NSArray<NSString *>*)fileNames
               successBlock:(void(^)(NSDictionary *dic))successBlock
                 errorBlock:(void(^)(ECG3USBError error,NSString *message))errorBlock;


/**
 Get data cache

 @param block An array contains Dictionary object
 {
 @"SampleRate":@(sampleRate),
 @"StartTime":startTimeString,
 @"EndTime":endTimeString,
 @"FileName":fileName,
 @"FilePath":path
 });
 */
- (void)getCacheDataWithBlock:(void(^)(NSArray *array))block;

/**
 

 @param dic the dictionary from the success block of method ’synthesisWithFileNames:success:error:‘
 */

/**
 Filter

 @param dic the dictionary from the success block of method ’synthesisWithFileNames:success:error:‘
 @param success see ECG3USBSyncResultBlock comments
 @param error a block contains error message (If the files don't exist, no error block retrun but print error message in the console)
 */
- (void)getFilterDataWithDic:(NSDictionary *)dic success:(ECG3USBSyncResultBlock)success error:(void(^)(NSString *message))error;

@end
