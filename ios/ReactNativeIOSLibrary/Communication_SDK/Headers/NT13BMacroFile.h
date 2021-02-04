//
//  NT13BMacroFile.h
//  iHealthSDKStatic
//
//  Created by user on 2019/9/20.
//  Copyright © 2019 ihealthSDK. All rights reserved.
//

#ifndef NT13BMacroFile_h
#define NT13BMacroFile_h
#define NT13BDiscover        @"NT13BDiscover"
#define NT13BConnectFailed   @"NT13BConnectFailed"
#define NT13BConnectNoti     @"NT13BConnectNoti"
#define NT13BDisConnectNoti  @"NT13BDisConnectNoti"


/**
 TemperatureUnit
 */
typedef NS_ENUM(NSInteger, NT13BTemperatureUnit) {
    /// NotDefined
    NT13BTemperatureUnit_NotDefined = 0,
    /// Degrees Celsius
    NT13BTemperatureUnit_C,
    /// Fahrenheit
    NT13BTemperatureUnit_F,
};

typedef void (^DisposeMeasureBlock)(NSDictionary *result);

typedef void (^DisposeDisconnectBlock)(BOOL result);


#endif /* NT13BMacroFile_h */
