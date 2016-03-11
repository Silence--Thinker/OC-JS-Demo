//
//  HttpManager.h
//  初级模仿-网易新闻
//
//  Created by Silence on 16/3/11.
//  Copyright © 2016年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface HttpManager : NSObject

+ (AFHTTPSessionManager *)manager;

@end
