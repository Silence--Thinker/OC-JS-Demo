//
//  NewsModel.m
//  初级模仿-网易新闻
//
//  Created by Silence on 16/3/10.
//  Copyright © 2016年 silence. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

+ (instancetype)newModelWithDictionary:(NSDictionary *)dict {
    NewsModel *newsM = [NewsModel new];
    
    newsM.title = [dict objectForKey:@""];
    newsM.digest = [dict objectForKey:@"digest"];
    newsM.imgsrc = [dict objectForKey:@"imgsrc"];
    return newsM;
}
@end
