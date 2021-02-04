//
//  HS2SController.h
//  iHealthSDKStatic
//
//  Created by jing on 2019/4/30.
//  Copyright © 2019 ihealthSDK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 HS2SController
 */
@interface HS2SController : NSObject
/**
 * Initialize HS2S controller class
 */
+(HS2SController *)shareIHHS2SController;

/**
 * Get all scale instance,use hsInstance to call HS related communication methods.
 */
-(NSArray *)getAllCurrentHS2SInstace;
@end

NS_ASSUME_NONNULL_END
