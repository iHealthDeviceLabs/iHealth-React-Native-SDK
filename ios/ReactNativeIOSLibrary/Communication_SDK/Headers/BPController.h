//
//  BPController.h
//  iHealthDemoCode
//
//  Created by Realank on 2017/1/4.
//  Copyright © 2017年 ihealthSDK. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 BP Base Controller
 */
@interface BPController : NSObject{
    //区分设备
    NSString* deviceName;
    NSString* deviceProtocol;
    //发送通知
    NSString* deviceConnectNotiName;
    NSString* deviceDisconnectNotiName;
    //创建实例
    Class DeviceClass;
}


/**
 Get BPController singleton instance

 @return unique BPController instance
 */
-(instancetype) initUniqueInstance;

/**
 Get all BP instances,you can choose one instance to call BP related communication methods.

 @return all connected BP instance
 */
-(NSArray *)allConnectedInstance;

@end
