//
//  ECGUSBModule.m
//  ReactNativeIOSLibrary
//
//  Created by daiqingquan on 2018/1/5.
//  Copyright © 2018年 daiqingquan. All rights reserved.
//

#import "ECGUSBModule.h"
#import "ECGHeader.h"
#import "ECGProfileModule.h"

#define EVENT_NOTIFY @"event_notify_ecgusb"

@implementation ECGUSBModule

@synthesize bridge = _bridge;


RCT_EXPORT_MODULE()


#pragma mark
#pragma mark - constantsToExport
- (NSDictionary *)constantsToExport
{
    return @{@"Event_Notify": EVENT_NOTIFY };
    
}
+ (BOOL)requiresMainQueueSetup
{
    return YES;
}
#pragma mark
#pragma mark - Method

RCT_EXPORT_METHOD(getAllConnectedDevices){
    
    ECG3USB *ecg=[[ECG3USBController shareECG3USBController] getCurrentECG3USBInstace];
    
    if (ecg!=nil) {
        
        NSDictionary* deviceInfo = @{kACTION:kACTION_GET_ALL_CONNECTED_DEVICES,kDEVICES:ecg.serialNumber};
        [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
    }
   
    
}
RCT_EXPORT_METHOD(getIdps){
    
    
    NSMutableDictionary*deviceInfo=[NSMutableDictionary dictionary];

    [deviceInfo setValue:@(404) forKey:kERROR_NUM_ECGUSB];
    
    [deviceInfo setValue:@"This method iOS is not supported" forKey:kERROR_DESCRIPTION_ECGUSB];
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
}
/**
 Sync Data
 
 @param startBlock means start
 @param progressBlock 0-100
 @param resultBlock You can get filtered data from the NSDocumentDirectory path.
 Abnormal Point Marked by User: OBData_FileName.txt
 Filtered ECG Data: ECGAnalyseResult_FileName.txt
 Lead Off Begin Point: ECGLeadOffBegin_FileName.txt
 Lead Off End Point: ECGLeadOffEnd_FileName.txt
 ECG HR Information EveryHour: ECGHREveryHour_FileName.txt
 Abnormal Point Filtered by Algorithm: ECGOBbyFilter_FileName.txt
 ECG HR Information for Day: ECGDetail_FileName.txt
 @param errorBlock error
 */

RCT_EXPORT_METHOD(syncData){
    
    ECG3USB *device = [[ECG3USBController shareECG3USBController] getCurrentECG3USBInstace];
    if (device) {
        __weak typeof(self) weakSelf = self;
        [device syncDataWithStartBlock:^{
            
            NSDictionary* deviceInfo = @{kACTION:kACTION_STARTSYNCDATA_ECGUSB,kMAC:device.serialNumber,kType:@"ECG3USB"};
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } progressBlock:^(NSUInteger progress) {
            
            NSDictionary* deviceInfo = @{kACTION:kACTION_SYNCDATAPROGRESS_ECGUSB,kPROGRESS:@(progress),kMAC:device.serialNumber,kType:@"ECG3USB"};
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } resultBlock:^(NSArray *resultArray, BOOL finish) {
            
            NSDictionary* deviceInfo = @{kACTION:kACTION_SYNCDATAINFO_ECGUSB,kDATAINFO:resultArray,kMAC:device.serialNumber,kType:@"ECG3USB"};
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            
        } errorBlock:^(ECG3USBError errorID) {
            
            [weakSelf commandReturnECGUSBError:errorID MAC:device.serialNumber];
        }];
        
    }else{
        [self commandReturnECGUSBError:ECG3USBError_DeviceDisconnect MAC:@""];
    }
}

-(void)commandReturnECGUSBError:(ECG3USBError)errorID MAC:(NSString*)mac{
    
    
    NSMutableDictionary*deviceInfo=[NSMutableDictionary dictionary];
    [deviceInfo setValue:@"ECG3USB" forKey:kType];
    if (mac) {
        [deviceInfo setValue:mac forKey:kMAC];
    }
    [deviceInfo setValue:@"ACTION_ERROR_ECGUSB" forKey:kACTION];
    
    NSString*errorDes=[NSString string];
    
    switch (errorID) {
        case ECG3USBError_QuerySDCardInfoTimeout:
            errorDes=@"Query command timeout";
            break;
        case ECG3USBError_SDCardInfoError:
            errorDes=@"Received SD card info is wrong";
            break;
        case ECG3USBError_SDCardError:
            errorDes=@"Receive devce's error log: SD card error";
            break;
        case ECG3USBError_iOSDeviceFlashNotEnough:
            errorDes=@"There is not enough space for ECG's offline data";
            break;
        case ECG3USBError_AFilePackageIndexNotMatch:
            errorDes=@"Receive wrong data";
            break;
        case ECG3USBError_BFilePackageIndexNotMatch:
            errorDes=@"Receive wrong data";
            break;
        case ECG3USBError_ReceiveDataTimeout:
            errorDes=@"Receive data timeout";
            break;
        case ECG3USBError_SaveFileError:
            errorDes=@"Save file error";
            break;
        case ECG3USBError_DeviceDisconnect:
            errorDes=@"Device is disconnected";
            break;
        case ECG3USBError_DeviceReplyFormatFail:
            errorDes=@"Format fail";
            break;
        case ECG3USBError_DeviceFormatTimeout:
            errorDes=@"Format command timeout.";
            break;
        case ECG3USBError_CommandTimeout:
            errorDes=@"Command timeout";
            break;
            
        default:
            break;
    }
    
    [deviceInfo setValue:@(errorID) forKey:kERROR_NUM_ECGUSB];
    
    [deviceInfo setValue:errorDes forKey:kERROR_DESCRIPTION_ECGUSB];
    
    [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
}

/**
 Format SD Card
 
 @param successBlock Success
 @param progressBlock 0-100
 @param failBlock Fail
 */

RCT_EXPORT_METHOD(deleteData){
    
    ECG3USB *device = [[ECG3USBController shareECG3USBController] getCurrentECG3USBInstace];
    if (device) {
        __weak typeof(self) weakSelf = self;
        [device formatSDCard:^{
            NSDictionary* deviceInfo = @{kACTION:kACTION_DELETEDATA_ECGUSB,kType:@"ECG3USB",kMAC:device.serialNumber};
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        } progressBlock:^(NSUInteger progress) {
            
        } errorBlock:^(ECG3USBError error) {
            [weakSelf commandReturnECGUSBError:error MAC:device.serialNumber];
        }];
        
    }else{
        [self commandReturnECGUSBError:ECG3USBError_DeviceDisconnect MAC:@""];
    }
}

/**
 Splice data
 
 @param fileNames An Array with FileName value from ECG3USBSyncResultBlock
 @param success a block contains a dictionary with two keys: success(@{@"DataFileName":dataFileName,@"MarkFileName":markFileName});
 @param error a block contains error message
 */
RCT_EXPORT_METHOD(spliceData:(nonnull NSArray*)array){
    __weak typeof(self) weakSelf = self;
    [ECG3USB spliceWithFileNames:array successBlock:^(NSDictionary *dic) {
        NSDictionary* deviceInfo = @{kACTION:kACTION_SPLICE,kSPLICE_DATA:dic,kType:@"ECG3USB",kMAC:@""};
        [weakSelf.bridge.eventDispatcher sendAppEventWithName:EVENT_NOTIFY body:deviceInfo];
    } errorBlock:^(ECG3USBError error, NSString *message) {
        NSDictionary* deviceInfo = @{kACTION:kACTION_SPLICE,kSPLICE_ERROR_DESCRIPTION:message,kType:@"ECG3USB",kMAC:@""};
        [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
    }];
}

RCT_EXPORT_METHOD(getCache){
    ECG3USB *device = [[ECG3USBController shareECG3USBController] getCurrentECG3USBInstace];
    if (device) {
        __weak typeof(self) weakSelf = self;
        [device getCacheDataWithBlock:^(NSArray *array) {
            NSDictionary* deviceInfo = @{kACTION:kACTION_GET_CACHE,kGET_CACHE_DATA:array,kMAC:device.serialNumber,kType:@"ECG3USB"};
            [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        }];
    }else{
        [self commandReturnECGUSBError:ECG3USBError_DeviceDisconnect MAC:@""];
    }
}

RCT_EXPORT_METHOD(getFilterDataByFileName:(nonnull NSString*)dataFileName markName:(nonnull NSString *)markFileName){
    ECG3USB *device = [[ECG3USBController shareECG3USBController] getCurrentECG3USBInstace];
    if (device) {
        if (!dataFileName || !markFileName){
            NSString *message = @"input parameter cannot be null";
            NSDictionary* deviceInfo = @{kACTION:kACTION_SPLICE,kFILTER_ERROR_DESCRIPTION:message,kType:@"ECG3USB",kMAC:device.serialNumber};
            [self.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
        } else {
            __weak typeof(self) weakSelf = self;
            [device getFilterDataWithDic:@{@"MarkFileName":markFileName,@"DataFileName":dataFileName} success:^(NSArray *resultArray, BOOL finish) {
                NSDictionary* deviceInfo = @{kACTION:kACTION_FILTER,kFILTER_DATA:resultArray,kMAC:device.serialNumber,kType:@"ECG3USB"};
                [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
            } error:^(NSString *message) {
                NSDictionary* deviceInfo = @{kACTION:kACTION_SPLICE,kFILTER_ERROR_DESCRIPTION:message,kType:@"ECG3USB",kMAC:device.serialNumber};
                [weakSelf.bridge.eventDispatcher sendDeviceEventWithName:EVENT_NOTIFY body:deviceInfo];
                
            }];
        }
        
        
        
    }else{
        [self commandReturnECGUSBError:ECG3USBError_DeviceDisconnect MAC:@""];
    }
}

@end
