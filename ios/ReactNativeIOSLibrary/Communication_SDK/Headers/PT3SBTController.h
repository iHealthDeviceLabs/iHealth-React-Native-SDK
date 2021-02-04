//
//  PT3SBTController.h
//  iHealthSDKStatic
//
//  Created by user on 2020/9/7.
//  Copyright © 2020 ihealthSDK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PT3SBTController : NSObject

/**
 * Initialize PT3SBT controller class
 */
+(PT3SBTController *)shareIHPT3SBTController;

/**
 * Get all scale instance,use hsInstance to call PT3SBT related communication methods.
 */
-(NSArray *)getAllCurrentPT3SBTInstace;

@end

NS_ASSUME_NONNULL_END
