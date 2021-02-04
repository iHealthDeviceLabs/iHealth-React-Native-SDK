//
//  BG1.h
//  iHealthSDKStatic
//
//  Created by soso on 2017/8/25.
//  Copyright © 2017年 ihealth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BGMacroFile.h"

/**
 BG1
 */
@interface BG1 : NSObject
@property (strong, nonatomic) NSString *mac;
@property (strong, nonatomic) NSString *firmwareVersion;


/**
 * Start connect BG1 and get the connection status.
 * @param BG1Model the BG1 type.
 * @param discover This block returns means blood glucose meter plugged in.
 * @param IDPSInfo  This block returns the IDPS of the meter, this will be operated for the first time when the app talks to the meter.
 * @param connect This block returns the connection status, the connection of the BG meter is regular , the measurement could be processed.
 * @param error block returns error codes,please refer to error codes list in BGMacroFile.
 * @Notice  Notice: Using this method should be placed kNotificationNameNeedAudioPermission callback
 */
- (void)commandBG1DeviceModel:(NSNumber *)BG1Model withDiscoverBlock:(DisposeBG1DiscoverBlock)discover withDiscoverBlock:(DisposeBG1IDPSBlock)IDPSInfo withConnectBlock:(DisposeBG1ConnectBlock)connect withErrorBlock:(DisposeBG1ErrorBlock)error;


/**
 * Establish connection and start BG measurement.(New)
 * @param measureMode Set the measure test type,BGMeasureMode_Blood is Blood Test,BGMeasureMode_NoBlood is CTL Test.
 * @param codeMode Set the code type,BGCodeMode_GOD is GOD,BGCodeMode_GDH is GDH.
 * @param codeString The code String gets by scanning the QR code.
 * @param sendCodeResult   If the QR code is accepted, yes means accepted, no means deny.
 * @param stripIn The strips slide into the BG meter.
 * @param blood  The blood drop has beed sensed from the strip.
 * @param measureResult  Returns the measurement by the unit of mg/dL, range from 20-600.
 * @param stripOut  The strip has been pulled out.
 * @param error  This block returns error codes,please refer to error codes list in BGMacroFile.
 */
- (void)commandBG1MeasureMode:(BGMeasureMode)measureMode withCodeMode:(BGCodeMode)codeMode withCodeString:(NSString *)codeString withSendCodeResultBlock:(DisposeBG1SendCodeResultBlock)sendCodeResult withStripInBlock:(DisposeBGStripInBlock)stripIn withBloodBlock:(DisposeBGBloodBlock)blood withResultBlock:(DisposeBGResultBlock)measureResult withStripOutBlock:(DisposeBGStripOutBlock)stripOut withErrorBlock:(DisposeBG1ErrorBlock)error;

/**
 Analyze code include bottleID，DueDate and the number of strips. Only Available for GOD Code
 
 @param encodeString The code String gets by scanning the QR code.
 @return return a dictionary contains keys such as @"BottleID",@"StripNum",@"DueDate"; return nil if input parameter is GDH code or code is invalid.
 */
-(NSDictionary *)codeStripStrAnalysis:(NSString *)encodeString;
@end
