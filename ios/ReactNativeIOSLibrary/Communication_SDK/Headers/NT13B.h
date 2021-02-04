//
//  NT13B.h
//  iHealthSDKStatic
//
//  Created by user on 2019/9/20.
//  Copyright © 2019 ihealthSDK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NT13BMacroFile.h"
NS_ASSUME_NONNULL_BEGIN

@interface NT13B : NSObject

@property (strong, nonatomic) NSString *currentUUID;
@property (strong, nonatomic) NSString *serialNumber;

/**
 * Get Measure Data
 * @param resultBlock  result NSDictionary  key：  bodyFlag （1：Humanity 0：object）unit(1:NT13BTemperatureUnit_C  2:NT13BTemperatureUnit_F)
 */
-(void)commandStartMeasure:(DisposeMeasureBlock)resultBlock;


/**
 * Disconnect connection
 * @param disconnectBlock  yes = success, no = fail.
 */
-(void)commandDisconnect:(DisposeDisconnectBlock)disconnectBlock;

@end

NS_ASSUME_NONNULL_END
