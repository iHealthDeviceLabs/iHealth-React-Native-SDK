//
//  HS6Module.h
//  ReactNativeIOSLibrary
//
//  Created by ihealth on 16/12/12.
//  Copyright © 2016年 daiqingquan. All rights reserved.
//

#import <Foundation/Foundation.h>


#if __has_include(<React/RCTAssert.h>)
#import <React/RCTBridgeModule.h>
#else
#import "RCTBridgeModule.h"
#endif




@interface HS6Module : NSObject<RCTBridgeModule>



@end
