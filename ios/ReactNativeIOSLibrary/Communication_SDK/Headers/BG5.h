//
//  BG5.h
//  testShareCommunication
//
//  Created by daiqingquan on 14-1-16.
//  Copyright (c) 2014年 my. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BGMacroFile.h"


/**
 BG5
 */
@interface BG5 : BGDevice

/**
 Set Time
 @param disposeBGSetTime The block return YES means set success, NO means set fail.
 @param disposeBGErrorBlock This block returns error codes,please refer to error codes list in BGMacroFile.
 @note  Time is local time
 */
-(void)commandBGSetTime:(DisposeBGSetTime)disposeBGSetTime
    DisposeBGErrorBlock:(DisposeBGErrorBlock)disposeBGErrorBlock;

/**
 * Set Unit displayed in BG5's screen
 * @param unitState The block return YES means set success, NO means set fail.
 * @param disposeBGSetUnitResult YES:success NO:fail
 * @param disposeBGErrorBlock This block returns error codes,please refer to error codes list in BGMacroFile.
 */
-(void)commandBGSetUnit:(BGUnit )unitState
   DisposeSetUnitResult:(DisposeBGSetUnit)disposeBGSetUnitResult
    DisposeBGErrorBlock:(DisposeBGErrorBlock)disposeBGErrorBlock;

/**
 * Query battery remaining energy
 * @param disposeBatteryBlock  A block to return the device battery remaining energy percentage, ‘80’ stands for 80%. 255 means device in charging.
 * @param disposeErrorBlock   This block returns error codes,please refer to error codes list in BGMacroFile.
 */
-(void)commandQueryBattery:(DisposeBGBatteryBlock)disposeBatteryBlock
         DisposeErrorBlock:(DisposeBGErrorBlock)disposeErrorBlock;

/**
 Tranfer offline history records. 
 For BG5 V3.0, after calling this method, you should call commandDeleteMemorryData: method. Otherwise, the measure date may be wrong.

 @param disposeBGDataCount The number of the records in the meter memory.
 @param disposeBGHistoryData The offline history records detail, result means result, date means the measurement time.
 @param disposeBGErrorBlock This block returns error codes,please refer to error codes list in BGMacroFile.
 */
-(void)commandTransferMemorryData:(DisposeBGDataCount)disposeBGDataCount
             DisposeBGHistoryData:(DisposeBGHistoryData)disposeBGHistoryData
              DisposeBGErrorBlock:(DisposeBGErrorBlock)disposeBGErrorBlock;

/**
 Delete offline history records

 @param DisposeBGDeleteData deleteOk YES or NO
 @param disposeBGErrorBlock This block returns error codes,please refer to error codes list in BGMacroFile.
 */
-(void)commandDeleteMemorryData:(DisposeBGDeleteData)DisposeBGDeleteData
            DisposeBGErrorBlock:(DisposeBGErrorBlock)disposeBGErrorBlock;

/**
 * Send code with type (Note: After you got the CTL test results, you need to send the blood Code again.)
 * @param testType Set the measure test type,@1 is Blood Test,@2 is CTL Test.
 * @param codeType Set the code type,@1 is GOD,@2 is GDH.
 * @param encodeString  The code String gets by scanning the QR code. Only used when codetype is GOD
 * @param date  The strip expired date. support Jan 1,2000 to Dec 31, 2099. If other value, return BG5Error_InputParametersError.
 * @param num  the number of remaining strips,ranging from 1-255.
 * @param disposeBGSendCodeBlock  YES means success, NO means fail.
 * @param disposeBGStartModel  The boot mode of the BG meter, BGOpenMode_Strip means booting the meter by sliding the strip, BGOpenMode_Hand means booting the meter by pressing the on/off button. commandCreateBGtestStripInBlock should be called after recieving BGOpenMode_Strip, commandCreateBGtestModel should be called after recieving BGOpenMode_Hand.
 * @param disposeBGErrorBlock This block returns error codes,please refer to error codes list in BGMacroFile.
 */
-(void)commandSendBGCodeWithMeasureType:(BGMeasureMode)testType
                               CodeType:(BGCodeMode)codeType
                             CodeString:(NSString*)encodeString
                              validDate:(NSDate*)date
                              remainNum:(NSNumber*)num
                 DisposeBGSendCodeBlock:(DisposeBGSendCodeBlock)disposeBGSendCodeBlock
                    DisposeBGStartModel:(DisposeBGStartModel)disposeBGStartModel
                    DisposeBGErrorBlock:(DisposeBGErrorBlock)disposeBGErrorBlock;

/**
 * Read the information of the strip from the BG meter
 * @param  disposeBGCodeDic  This block returns the information of the strip, Strips means the number of strips which has been used, Date means expired date.
 * @param  disposeBGErrorBlock  This block returns error codes,please refer to error codes list in BGMacroFile.
 */
-(void)commandReadBGCodeDic:(DisposeBGCodeDic)disposeBGCodeDic
        DisposeBGErrorBlock:(DisposeBGErrorBlock)disposeBGErrorBlock;

/**
 *Send BottleID to the BG meter
 *@param bottleID  bottleID, 4 bytes,0x00000000-0xFFFFFFFF
 *@param disposeBGSendBottleIDBlock The block return YES means set success, NO means set fail.
 *@param disposeBGErrorBlock  This block returns error codes,please refer to error codes list in BGMacroFile.
 */
-(void)commandSendBottleID:(long long)bottleID
DisposeBGSendBottleIDBlock:(DisposeBGSendBottleIDBlock)disposeBGSendBottleIDBlock
       DisposeBGErrorBlock:(DisposeBGErrorBlock)disposeBGErrorBlock;

/**
 * Get the bottleID stored in the BG meter
 * @param disposeBGBottleID  This block returns the ID which is stored in the BG meter, to verify if the strip that has been used is from the same bottle of the registered one. if not match, the app will notify the user need scan the new bottle; If match, the app can get the number of used strips and expire date.
 * @param disposeBGErrorBlock This block returns error codes,please refer to error codes list in BGMacroFile.
 */

-(void)commandBGGetBottleID:(DisposeBGBottleID)disposeBGBottleID
        DisposeBGErrorBlock:(DisposeBGErrorBlock)disposeBGErrorBlock;

/**
 Strip-Sliding booting mode

 @param disposeBGStripInBlock This block returns yes means strip slides in.
 @param disposeBGBloodBlock This block returns yes means the blood drop has beed sensed from the strip.
 @param disposeBGResultBlock This block returns the measurement by the unit of mg/dL, range from 20-600.
 @param disposeBGErrorBlock This block returns error codes,please refer to error codes list in BGMacroFile.

 */
-(void)commandCreateBGtestStripInBlock:(DisposeBGStripInBlock)disposeBGStripInBlock
                   DisposeBGBloodBlock:(DisposeBGBloodBlock)disposeBGBloodBlock
                  DisposeBGResultBlock:(DisposeBGResultBlock)disposeBGResultBlock
                   DisposeBGErrorBlock:(DisposeBGErrorBlock)disposeBGErrorBlock;


/**
 * Button-pressing booting mode
 * @param testMode  Set the measurement mode,must be the same as the testType in send code method, BGMeasureMode_Blood means blood measurement mode, BGMeasureMode_NoBlood means control solution measurement mode.
 * @param disposeBGStripInBlock  This block returns yes means strip slides in.
 * @param disposeBGBloodBlock This block returns yes means the blood drop has beed sensed from the strip.
 * @param disposeBGResultBlock  This block returns the measurement by the unit of mg/dL, range from 20-600.
 * @param disposeBGErrorBlock   This block returns error codes,please refer to error codes list in BGMacroFile.
 */
-(void)commandCreateBGtestModel:(BGMeasureMode)testMode
          DisposeBGStripInBlock:(DisposeBGStripInBlock)disposeBGStripInBlock
            DisposeBGBloodBlock:(DisposeBGBloodBlock)disposeBGBloodBlock
           DisposeBGResultBlock:(DisposeBGResultBlock)disposeBGResultBlock
            DisposeBGErrorBlock:(DisposeBGErrorBlock)disposeBGErrorBlock;

/**
 * Keep the connection to enable enough time for operation such as scan code, insert strip and drop blood.
 * @param disposeBG5KeepConnectBlock A block returns the result of the keeping connection order,'YES' means setting success,'NO' means fail.
 * @param disposeErrorBlock   This block returns error codes,please refer to error codes list in BGMacroFile.
 */
-(void)commandKeepConnect:(DisposeBG5KeepConnectBlock)disposeBG5KeepConnectBlock
        DisposeErrorBlock:(DisposeBGErrorBlock)disposeErrorBlock;

/**
 Analyze code include bottleID，DueDate and the number of strips. Only Available for GOD Code
 
 @param encodeString The code String gets by scanning the QR code.
 @return return a dictionary contains keys such as @"BottleID",@"StripNum",@"DueDate"; return nil if input parameter is GDH code or code is invalid.
 */
-(NSDictionary *)codeStripStrAnalysis:(NSString *)encodeString;

@end
