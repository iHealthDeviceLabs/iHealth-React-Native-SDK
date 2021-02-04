//
//  BG1S.h
//  iHealthSDKStatic
//
//  Created by jing on 2019/5/8.
//  Copyright © 2019 ihealthSDK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BGMacroFile.h"
NS_ASSUME_NONNULL_BEGIN

@interface BG1S : NSObject
@property (strong, nonatomic) NSString *serialNumber;
@property (strong, nonatomic) NSString *currentUUID;

/**
 * Get device battary
 * @param function  A block to return the function and states that the device supports.
 * @param disposeBGErrorBlock  A block to refer ‘error’ in ‘Establish measurement connection’ in BG1S.
 */
-(void)commandFunction:(BlockBG1SDeviceFunction)function DisposeBGErrorBlock:(BlockBG1SError)disposeBGErrorBlock;

/**
 * Button-pressing booting mode
 * @param testMode  Set the measurement mode,must be the same as the testType in send code method, BGMeasureMode_Blood means blood measurement mode, BGMeasureMode_NoBlood means control solution measurement mode.
 * @param disposeBGStripInBlock  This block returns yes means strip slides in.
 * @param disposeBGBloodBlock This block returns yes means the blood drop has beed sensed from the strip.
 * @param disposeBGResultBlock  This block returns the measurement by the unit of mg/dL, range from 20-600.
 * @param disposeBGErrorBlock   This block returns error codes,please refer to error codes list in BGMacroFile.
 */
-(void)commandCreateBG1STestModel:(BGMeasureMode)testMode
          DisposeBGStripInBlock:(DisposeBG1SStripInBlock)disposeBGStripInBlock
            DisposeBGBloodBlock:(DisposeBGBloodBlock)disposeBGBloodBlock
           DisposeBGResultBlock:(DisposeBGResultBlock)disposeBGResultBlock
            DisposeBGErrorBlock:(BlockBG1SError)disposeBGErrorBlock;

/**
* Read the information of the strip from the BG meter
* @param  disposeBGCodeDic  This block returns the information of the strip, Strips means the number of strips which has been used, Date means expired date.
* @param  disposeBGErrorBlock  This block returns error codes,please refer to error codes list in BGMacroFile.
*/
-(void)commandReadBGCodeDic:(DisposeBGCodeDic)disposeBGCodeDic
        DisposeBGErrorBlock:(BlockBG1SError)disposeBGErrorBlock;

/**
 * Send code

 * @param encodeString  The code String gets by scanning the QR code. Only used when codetype is GOD
 
 * @param disposeBGSendCodeBlock  YES means success, NO means fail.

 * @param disposeBGErrorBlock This block returns error codes,please refer to error codes list in BGMacroFile.
 */
-(void)commandSendBGCodeWithCodeString:(NSString*)encodeString DisposeBGSendCodeBlock:(DisposeBGSendCodeBlock)disposeBGSendCodeBlock DisposeBGErrorBlock:(BlockBG1SError)disposeBGErrorBlock;
/**
 * Disconnect current device
 */
-(void)commandDisconnectDevice;


@end

NS_ASSUME_NONNULL_END
