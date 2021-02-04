//
//  THV3Controller.h
//  iHealthDemoCode
//
//  Created by Realank on 2016/12/23.
//  Copyright © 2016年 zhiwei jing. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 THV3Controller
 */
@interface THV3Controller : NSObject

@property (nonatomic,assign) NSInteger defaultIdelTime;
@property (nonatomic,assign) BOOL defaultUnitIsCelsius;
@property (nonatomic,assign) BOOL defaultTargetIsHumanBody;
@property (nonatomic,assign) BOOL defaultIsOffline;
/**
 * Initialize THV3 controller class
 */
+(THV3Controller *)sharedController;

/**
 * Get all THV3 instance,Access control class instance after receiving THV3ConnectNoti then use instance to call THV3 related communication methods.
 */
-(NSArray *)allCurrentInstance;

@end
