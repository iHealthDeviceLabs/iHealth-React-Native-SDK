//
//  HS3Controller.h
//  testShareCommunication
//
//  Created by daiqingquan on 13-10-10.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 HS3Controller
 */
@interface HS3Controller : NSObject{
    
    NSMutableArray *hs3Array;
}

/**
 * Initialize HS3 controller class
 */

+(HS3Controller *)shareIHHs3Controller;

/**
 * Get all scale instance,use hsInstance to call HS related communication methods.
 */
-(NSArray *)getAllCurrentHS3Instace;


@end
