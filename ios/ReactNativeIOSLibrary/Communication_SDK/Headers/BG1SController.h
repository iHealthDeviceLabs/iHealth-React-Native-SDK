//
//  BG1SController.h
//  iHealthSDKStatic
//
//  Created by jing on 2019/5/8.
//  Copyright © 2019 ihealthSDK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BG1SController : NSObject
/**
 * Initialize BG1S controller class
 */
+(BG1SController *)shareIHBG1SController;

/**
 * Get all BG1S instance,use hsInstance to call BG related communication methods.
 */
-(NSArray *)getAllCurrentBG1SInstace;
@end

NS_ASSUME_NONNULL_END
