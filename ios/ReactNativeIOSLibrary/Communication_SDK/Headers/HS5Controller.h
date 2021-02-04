//
//  HS5Controller.h
//  testShareCommunication
//
//  Created by zhiwei jing on 13-10-22.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSMacroFile.h"


/**
 HS5Controller
 */
@interface HS5Controller : NSObject

/**
 * Initialize HS5 controller class
 */
+(HS5Controller *)shareIHHs5Controller;

/**
 * Get all scale instance,use hsInstance to call HS related communication methods.
 */
-(NSArray *)getAllCurrentHS5Instace;

//Acquire HS5 data from cloud
//When connected to the internet, HS5 could upload measurement to cloud to be recorded. Get data in cloud using the below API.
-(void)getDownloadDataFromCloud:(BlockDataFromCloud )dataBlock;

/*Start search HS5*/
-(void)commandStartSearchScale;

/*Stop search HS5*/
-(void)commandStopSearchScale;

@end
