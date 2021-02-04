//
//  HS4Controller.h
//  testShareCommunication
//
//  Created by daiqingquan on 13-12-2.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 HS4Controller
 */
@interface HS4Controller : NSObject

/**
 * Initialize HS4 controller class
 */
+(HS4Controller *)shareIHHs4Controller;

/**
 * Get all scale instance,use hsInstance to call HS related communication methods.
 */
-(NSArray *)getAllCurrentHS4Instace;

@end
