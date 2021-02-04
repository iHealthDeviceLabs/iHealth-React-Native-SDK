//
//  HS2S.h
//  iHealthSDKStatic
//
//  Created by jing on 2019/5/8.
//  Copyright © 2019 ihealthSDK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSMacroFile.h"
NS_ASSUME_NONNULL_BEGIN

@interface HS2S : NSObject

@property (strong, nonatomic) NSString *serialNumber;
@property (strong, nonatomic) NSString *currentUUID;

/**
 *Get HS2S DeviceInfo (After the HS2S device is successfully connected, the interface must be called to synchronize the device time. Otherwise, the offline data measurement time error will be caused)
 
 * @param deviceInfo Contains  device IDPS info(FirmwareVersion,HardwareVersion,Manufacture,ModelNumber,ProtocolString,SerialNumber),user count ,HS2S current unit(1:Kg,2:LB,3:ST),battery
 * Example:
 * {
           Battary = 70;
           DeviceName = HS2S;
           FirmwareVersion = "0.5.4";
           HardwareVersion = "1.0.0";
           Manufacture = iHealth;
           ModelNumber = "HS2S 11070";
           ProtocolString = "com.jiuan.BFSV22";
           SerialNumber = 004D320CA04D;
           Unit = 1;
           UserCount = 1;
 * }
 * @param disposeErrorBlock  - error code
 * Error code definition：
 *  refer to “error” : HS2S error instruction.
 */
-(void)commandGetHS2SDeviceInfo:(DisposeHS2SDeviceInfo)deviceInfo DiaposeErrorBlock:(DisposeHS2SErrorBlock)disposeErrorBlock;


/**
 *Get HS2S battery
 
 * @param battary HS2Sbattery [Range:0～100]%
 * @param disposeErrorBlock  - error code
 * Error code definition：
 *  refer to “error” : HS2S error instruction.
 */
-(void)commandGetHS2SBattery:(DisposeHS2SBatteryBlock)battary DiaposeErrorBlock:(DisposeHS2SErrorBlock)disposeErrorBlock;


/**
 
 * SetUnit
 
 * Import parameter:
 * @param tempUnit  -Unit displayed on HS2S: HSUnit_Kg、HSUnit_LB、HSUnit_ST。
 * Return parameters:
 * @param result   YES:Success  NO:Failed
 * @param disposeErrorBlock  - error code
 * Error code definition：
 *  refer to “error” : HS2S error instruction.
 */

-(void)commandSetHS2SUnit:(HSUnit)tempUnit result:(DisposeHS2SResult)result  DisposeErrorBlock:(DisposeHS2SErrorBlock)disposeErrorBlock;

/**
 * Get HS2S UserInfo
 * Return parameters:
 * @param userInfo  NSDictionary type,contains: UserCount and UserInfo
 * Example:
 * {
        UserCount = 1;
        UserInfo =(
            {
              "UserInfo_Age" = 20;
              "UserInfo_Height" = 100;
              "UserInfo_CreatTS" = 1558406503;                      //User creat time
              "UserInfo_ID" = <69486561 6c746831 32333435 36373839>;
              "UserInfo_ImpedanceMark" = 1;                         //0 Don't measure 1 Measure
              "UserInfo_SEX" = 1;                                   //0 female 1 male,
              "UserInfo_Weight" = "79.5";
              "UserInfo_Fitness" = 1;                               //0:Don't fitness 1:fitness
            }
         );
 * }
 * @param disposeErrorBlock  - error code
 * Error code definition：
 *  refer to “error” : HS2S error instruction.
 */
-(void)commandGetHS2SUserInfo:(DisposeHS2SUserInfo)userInfo DiaposeErrorBlock:(DisposeHS2SErrorBlock)disposeErrorBlock;

/**
 * Create or Update HS2S UserInfo (The HS2S device only supports the creation of a maximum of 8 users)
 * Import parameter:
 * @param user (user information must be entered in accordance with the reference range, otherwise it may be impossible to measure the accurate body fat information)
 
 * contains:
 * hs2SUserID:NSData type,The user ID must be 16 bytes or the user creation fails,
 * createTS:NSInteger type,The unit of time is seconds ,
 * weight:NSNumber type,range:20-150kg,
 * age:NSNumber type,range:18-99 years,
 * height:NSNumber type,range:90-220cm
 * sex:0 female 1 male,
 * impedanceMark: 0 Don't measure 1 Measure
 * fitnessMark:0 Don't fitness 1:fitness
 * Return parameters:
 * @param result   YES:Success  NO:Failed
 * @param disposeErrorBlock  - error code
 * Error code definition：
 *  refer to “error” : HS2S error instruction.
 */
-(void)commandUpdateHS2SUserInfoWithUser:(HealthUser*)user result:(DisposeHS2SResult)result DiaposeErrorBlock:(DisposeHS2SErrorBlock)disposeErrorBlock;

/**
 *  Delete HS2S User
 * Import parameter:
 * @param userID :NSData type,The user ID must be 16 bytes or the user creation fails,
 * Return parameters:
 * @param result   YES:Success  NO:Failed
 * @param disposeErrorBlock  - error code
 * Error code definition：
 *  refer to “error” : HS2S error instruction.
 */
-(void)commandDeleteHS2SUserWithUserID:(NSData*)userID result:(DisposeHS2SResult)result DiaposeErrorBlock:(DisposeHS2SErrorBlock)disposeErrorBlock;

/**
 *  Get HS2S Memory data count
 * Import parameter:
 * @param userID :NSData type,The user ID must be 16 bytes or the user creation fails,
 * Return parameters:
 * @param count  NSNumber Type,memory count
 * @param disposeErrorBlock  - error code
 * Error code definition：
 *  refer to “error” : HS2S error instruction.
 */
-(void)commandGetHS2SMemoryDataCountWithUserID:(NSData*)userID memoryCount:(DisposeHS2SMemoryCountBlock)count DiaposeErrorBlock:(DisposeHS2SErrorBlock)disposeErrorBlock;

/**
 *  Get HS2S Memory data
 
 Lean mass calculation formula: result = weight * (1 - body fat percentage)
 BMI calculation formula: result = weight / (height * height)
 BMR calculation formula:
 If no fat is measured
 {
 For men:
 P = 13.397* weight + 4.799* height – 5.677* age + 88.362
 For women:
 P = 9.247* weight + 3.098* height – 4.330* age + 447.593
 If the user enters the sport level in the app, correct the P:
 Sport level=1, P = P*1.0
 Sport level = 2, P = P*1.05
 Sport level = 3, P = P*1.10
 }
 When fat is measured:
 {
 P=370 + 21.6*Lean mass(kg )
 }
 * Import parameter:
 * @param userID :NSData type,The user ID must be 16 bytes or the user creation fails,
 * Return parameters:
 * @param memoryData NSArray Type,memory data
 * Example:
 * (
 
          {
               DeviceMac = 004D320CA04D;                      //device mac
               HS2SBodyAge = 10;                              //body age
               HS2SBodyWaterPercentAge = "39.3";              //body moisture rate
               HS2SBoneMineral = "1.9";                       //Bone salt
               HS2SFatControl = 0;                            //Fat Control
               HS2SFatWeight = 0;                             //Fat weight
               HS2SFitness = 1;                               //0:Don't fitness 1:fitness
               HS2SImpedance = ();                            //NSArray type ,Impedance
               HS2SIsRightTS = 1;                             //0:Incorrect, unsynchronized time on measured data 1:Correct, synchronize the measured data after the time
               HS2SMeasureTS = "2019-05-18 08:56:38 +0000";
               HS2SMuscle = "13.1";                           //Muscle mass
               HS2SMuscleControl = 0;                         //Muscle Control
               HS2SProteinPercentAge = "9.8";                 //Protein rate
               HS2SResultBodyFatPercentAge = "44.2";          //Body fat rate
               HS2SBodyWeightFlag = 0;                        //0:Body fat was not measured 1:Measure body fat
               HS2SSkeletalMuscle = 0;                        //Skeletal Muscle
               HS2SStandardWeight = 0;                        //Standard Weight
               HS2SVFR = 29;                                  //Visceral fat grade
               HS2SWeightControl = 0;                         //Weight Control
               HS2SWeigthResult = "79.5";
               "UserInfo_Age" = 18;
               "UserInfo_Height" = 100;
               "UserInfo_SEX" = 1;
          }
 * )
 * @param disposeErrorBlock  - error code
 * Error code definition：
 *  refer to “error” : HS2S error instruction.
 */
-(void)commandGetHS2SMemoryDataWithUserID:(NSData*)userID memoryData:(DisposeHS2SMemoryDataBlock)memoryData DiaposeErrorBlock:(DisposeHS2SErrorBlock)disposeErrorBlock;

/**
 *  Delete HS2S Memory data
 * Import parameter:
 * @param userID :NSData type,The user ID must be 16 bytes or the user creation fails,
 * Return parameters:
 * @param result   YES:Success  NO:Failed
 * @param disposeErrorBlock  - error code
 * Error code definition：
 *  refer to “error” : HS2S error instruction.
 */
-(void)commandDeleteHS2SMemoryDataWithUserID:(NSData*)userID result:(DisposeHS2SResult)result DiaposeErrorBlock:(DisposeHS2SErrorBlock)disposeErrorBlock;

/**
 *  Get HS2S Anonymous Memory data count
 * Return parameters:
 * @param count memory count
 * @param disposeErrorBlock  - error code
 * Error code definition：
 *  refer to “error” : HS2S error instruction.
 */
-(void)commandGetHS2SAnonymousMemoryDataCount:(DisposeHS2SAnonymousMemoryCountBlock)count DiaposeErrorBlock:(DisposeHS2SErrorBlock)disposeErrorBlock;

/**
 *  Get HS2S Anonymous Memory data
 * Return parameters:
 * @param memoryData  NSArray type,Each result dictionary contains: HS2SIsRightTS(Time correctness identification,0:Incorrect, unsynchronized time on measured data 1:Correct, synchronize the measured data after the time),HS2SMeasureTS(Measure Time,NSdate type),HS2SWeigthResult(Weigth Result)
 * Example:
 * (
        {
           HS2SIsRightTS = 0;    //Time correctness identification
           HS2SMeasureTS = "2019-05-18 07:18:36 +0000";
           HS2SWeigthResult = "43.7";
        }
 * )
 * @param disposeErrorBlock  - error code
 * Error code definition：
 *  refer to “error” : HS2S error instruction.
 */
-(void)commandGetHS2SAnonymousMemoryData:(DisposeHS2SAnonymousMemoryDataBlock)memoryData DiaposeErrorBlock:(DisposeHS2SErrorBlock)disposeErrorBlock;

/**
 *  Delete HS2S Anonymous Memory data
 * Return parameters:
 * @param result   YES:Success  NO:Failed
 * @param disposeErrorBlock  - error code
 * Error code definition：
 *  refer to “error” : HS2S error instruction.
 */
-(void)commandDeleteHS2SAnonymousMemoryData:(DisposeHS2SResult)result DiaposeErrorBlock:(DisposeHS2SErrorBlock)disposeErrorBlock;


/**
 *  Measure HS2S Data
 * Import parameter:
 * @param user (user information must be entered in accordance with the reference range, otherwise it may be impossible to measure the accurate body fat information)
 
       Lean mass calculation formula: result = weight * (1 - body fat percentage)
       BMI calculation formula: result = weight / (height * height)
       BMR calculation formula:
       If no fat is measured
      {
          For men:
          P = 13.397* weight + 4.799* height – 5.677* age + 88.362
          For women:
          P = 9.247* weight + 3.098* height – 4.330* age + 447.593
          If the user enters the sport level in the app, correct the P:
          Sport level=1, P = P*1.0
          Sport level = 2, P = P*1.05
          Sport level = 3, P = P*1.10
      }
       When fat is measured:
      {
           P=370 + 21.6*Lean mass(kg )
      }
 * contains:
 * userType :  0 guest  1 normal
 * hs2SUserID:NSData type,The user ID must be 16 bytes or the user creation fails,
 * createTS:NSInteger type,The unit of time is seconds ,
 * weight:NSNumber type,range:20-150kg,
 * age:NSNumber type,range:18-99 years,
 * height:NSNumber type,range:90-220cm
 * sex:0 female 1 male,
 * impedanceMark: 0 Don't measure 1 Measure
 * fitnessMark:0 Don't fitness 1:fitness
 * Return parameters:
 * @param unStableWeight     - Current weight, (Kg) [Value Range:0~180]
 * @param stableWeight       - Stable weight, (Kg) [Value Range:0~180]
 * @param weightAndBodyInfo  Weight and body fat information   guest user not return weightAndBodyInfo
 * Example:
 * {
       DeviceMac = 004D320CA04D;                      //device mac
       HS2SBodyAge = 10;                              //body age
       HS2SBodyWaterPercentAge = "39.3";              //body moisture rate
       HS2SBoneMineral = "1.9";                       //Bone salt
       HS2SFatControl = 0;                            //Fat Control
       HS2SFatWeight = 0;                             //Fat weight
       HS2SFitness = 1;                               //0:Don't fitness 1:fitness
       HS2SImpedance = ();                            //NSArray type ,Impedance
       HS2SMeasureTS = "2019-05-18 08:56:38 +0000";
       HS2SMuscle = "13.1";                           //Muscle mass
       HS2SMuscleControl = 0;                         //Muscle Control
       HS2SProteinPercentAge = "9.8";                 //Protein rate
       HS2SResultBodyFatPercentAge = "44.2";          //Body fat rate
       HS2SBodyWeightFlag = 0;                        //0:Body fat was not measured 1:Measure body fat
       HS2SSkeletalMuscle = 0;                        //Skeletal Muscle
       HS2SStandardWeight = 0;                        //Standard Weight
       HS2SVFR = 29;                                  //Visceral fat grade
       HS2SWeightControl = 0;                         //Weight Control
       HS2SWeigthResult = "79.5";
       "UserInfo_Age" = 18;
       "UserInfo_Height" = 100;
       "UserInfo_SEX" = 1;
 * }
 * @param measureFinish  If HS2S is measuring weight, the call to the online measurement interface will fail at the beginning, and the call to the interface will succeed when the return measurement is completed.
 * @param disposeErrorBlock  - error code
 * Error code definition：
 *  refer to “error” : HS2S error instruction.
 */
-(void)commandStartHS2SMeasureWithUser:(HealthUser*)user weight:(DisposeHS2SUnStableWeight)unStableWeight stableWeight:(DisposeHS2SStableWeight)stableWeight weightAndBodyInfo:(DisposeHS2SWeightAndBodyInfo)weightAndBodyInfo  disposeHS2SMeasureFinish:(DisposeHS2SMeasureFinish)measureFinish DiaposeErrorBlock:(DisposeHS2SErrorBlock)disposeErrorBlock;


/**
 *  Reset HS2S device
 * Return parameters:
 * @param result   YES:Success  NO:Failed
 * @param disposeErrorBlock  - error code
 * Error code definition：
 *  refer to “error” : HS2S error instruction.
 */
-(void)commandResetHS2SDevice:(DisposeHS2SResult)result DiaposeErrorBlock:(DisposeHS2SErrorBlock)disposeErrorBlock;

/**
 *   HS2S BroadCastType device
 * Return parameters:
 * @param result   YES:Success  NO:Failed
 * @param disposeErrorBlock  - error code
 * Error code definition：
 *  refer to “error” : HS2S error instruction.
 */
-(void)commandBroadCastTypeHS2SDevice:(DisposeHS2SResult)result DiaposeErrorBlock:(DisposeHS2SErrorBlock)disposeErrorBlock;


/**
 Disconnect current device
 */

-(void)commandDisconnectDevice;

/**
 *   HS2S Light up bluetooth
 * Return parameters:
 * @param result   YES:Success  NO:Failed
 * @param disposeErrorBlock  - error code
 * Error code definition：
 *  refer to “error” : HS2S error instruction.
 */
-(void)commandSetHS2SDeviceLightUp:(DisposeHS2SResult)result DiaposeErrorBlock:(DisposeHS2SErrorBlock)disposeErrorBlock;




/**
 *   HS2S  Enter heart rate measurement mode
 * Return parameters:
 * @param result
 *  heartResultDic:{
    HeartValue = 0;
    ResultStatus = 1;(0: success,
                 1: failed 1, no real-time data received in 6s
                 2: Failure 2, the algorithm judges that the user is weighing down
                 3: Failure 3, calculation failed
                 4: Failure 4: 30s timeout)
  }

 * @param status  ( 1: User on the scale
                  2: User referred below
                  3: The user's heartbeat signal is detected)
 * @param disposeErrorBlock  - error code
 * Error code definition：
 *  refer to “error” : HS2S error instruction.
 */
-(void)commandEnterHS2SHeartRateMeasurementMode:(DisposeHS2SHeartResult)result measurementStatus:(DisposeHS2SMeasurementStatus)status  DiaposeErrorBlock:(DisposeHS2SErrorBlock)disposeErrorBlock;

/**
 *   HS2S  Exit heart rate measurement mode
 * Return parameters:
 * @param result   YES:Success  NO:Failed
 * @param disposeErrorBlock  - error code
 * Error code definition：
 *  refer to “error” : HS2S error instruction.
 */
-(void)commandExitHS2SHeartRateMeasurementMode:(DisposeHS2SResult)result DiaposeErrorBlock:(DisposeHS2SErrorBlock)disposeErrorBlock;


@end




NS_ASSUME_NONNULL_END
