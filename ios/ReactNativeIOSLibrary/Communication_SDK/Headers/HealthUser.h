//
//  HealthUser.h
//  iHealthDemoCode
//
//  Created by jing on 16/5/13.
//  Copyright © 2016年 zhiwei jing. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum{
    UserAuthen_RegisterSuccess = 1,//New-user registration succeeded
    UserAuthen_LoginSuccess,// User login succeeded
    UserAuthen_CombinedSuccess,// The user is iHealth user as well, measurement via SDK has been activated, and the data from the measurement belongs to the user
    UserAuthen_TrySuccess,//Testing without Internet connection succeeded
    UserAuthen_InvalidateUserInfo,//Userid/clientID/clientSecret verification failed
    UserAuthen_SDKInvalidateRight,//SDK has not been authorized
    UserAuthen_UserInvalidateRight,//User has not been authorized
    UserAuthen_InternetError,//Internet error, verification failed
    UserAuthen_AppSecretVerifySuccess, // appsecrect is right
    UserAuthen_AppSecretVerifyFailed, //appsecrect error
    UserAuthen_InputError, //Input error
    UserAuthen_CertificateExpired,  //Certificate expired
    UserAuthen_InvalidCertificate,  //Invalid certificate
}UserAuthenResult;

//User
typedef enum{
    LengthUnit_Mile = 0,
    LengthUnit_Kilometer,
}LengthUnit;

typedef enum{
    UserSex_Female = 0,
    UserSex_Male,
}UserSex;

typedef enum{
    UserType_Guest = 0,
    UserType_Normal,
}HS2SUserType;
typedef enum{
    HS2SImpedanceMark_NO = 0,
    HS2SImpedanceMark_YES,
}HS2SImpedanceMark;
typedef enum{
    HS2SFitnessMark_NO = 0,
    HS2SFitnessMark_YES,
}HS2SFitnessMark;

typedef enum{
    HSUnit_Kg = 1, //kg
    HSUnit_LB,     //lb
    HSUnit_ST      //st
}HSUnit;

typedef enum{
    UserIsAthelete_No = 0, //No athelete
    UserIsAthelete_Yes     //athelete
}UserIsAthelete;


typedef enum{
    AppSecretVerifySucess = 1,
    AppSecretVerifyFailed
}AppSecretVerifyStatus;

typedef enum{
    iHealthSDK_BP= 0,
    iHealthSDK_BG,
    iHealthSDK_HS,
    iHealthSDK_PO,
    iHealthSDK_AM,
    iHealthSDK_ECG,
    iHealthSDK_TH,
    iHealthSDK_All
}SDKDeviceAccessType;

typedef void(^DisposeSDKUserDeviceAccess)(NSArray*DeviceAccessArray);

typedef void(^DisposeSDKUserValidationSuccess)(UserAuthenResult result);

typedef void(^DisposeSDKUserValidationReturn)(NSString *userID);

typedef void (^DisposeSDKUserValidationErrorBlock)(UserAuthenResult errorID);



@interface HealthUser : NSObject


@property (nonatomic, strong) NSString * clientID;
@property (nonatomic, strong) NSString * clientSecret;
@property (nonatomic, strong) NSString * userID;
@property (nonatomic, strong) NSString * userAccount;
@property (nonatomic, strong) NSString * certificatePath;
@property (nonatomic, strong) NSString * certificateSecret;

@property (nonatomic, strong) NSNumber * serialNub;
@property (nonatomic, strong) NSDate *birthday;
@property (nonatomic, strong) NSNumber *age;

//unit:cm
@property (nonatomic, strong) NSNumber * height;
//kg
@property (strong, nonatomic)NSNumber *weight;
//invalidate
@property (strong, nonatomic)NSNumber *bmr;
//activityLevel=1, Sedentary,spend most of day sitting.
//activityLevel=2, Active,spend a good part of day doing some physical activity.
//activityLevel=3, Very Active,spend most of day doing heavy physical activity.
@property (strong, nonatomic)NSNumber *activityLevel;

@property UserIsAthelete isAthlete;
@property UserSex sex;
@property LengthUnit lengthUnit;

@property HS2SUserType userType;
@property HS2SImpedanceMark  impedanceMark;
@property HS2SFitnessMark  fitnessMark;
@property NSInteger newDevice;
@property NSInteger createTS;
@property (nonatomic, strong) NSData * hs2SUserID;

@end
