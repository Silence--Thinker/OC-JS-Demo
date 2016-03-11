//
//  HttpManager.m
//  初级模仿-网易新闻
//
//  Created by Silence on 16/3/11.
//  Copyright © 2016年 silence. All rights reserved.
//

#import "HttpManager.h"

@implementation HttpManager

+ (AFHTTPSessionManager *)manager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSSet *set = manager.responseSerializer.acceptableContentTypes;
    NSMutableSet *newSet = [NSMutableSet setWithSet:set];
    [newSet addObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = newSet;
    return manager;
}

@end
