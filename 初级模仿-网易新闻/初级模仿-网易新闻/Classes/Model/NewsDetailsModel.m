//
//  NewsDetailsModel.m
//  初级模仿-网易新闻
//
//  Created by Silence on 16/3/11.
//  Copyright © 2016年 silence. All rights reserved.
//

#import "NewsDetailsModel.h"
#import "NewsDetailImage.h"

@implementation NewsDetailsModel

+ (instancetype)newsDetailWith:(NSDictionary *)dict {
    
    NewsDetailsModel *detail = [NewsDetailsModel new];
    detail.title = [dict objectForKey:@"title"];
    detail.body = [dict objectForKey:@"body"];
    detail.ptime = [dict objectForKey:@"ptime"];
    detail.source = [dict objectForKey:@"source"];
    detail.ec = [dict objectForKey:@"ec"];
    NSArray *imges = [dict objectForKey:@"img"];
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSDictionary *imageDict in imges) {
        NewsDetailImage *image = [NewsDetailImage newsDetailImageWith:imageDict];
        [arrayM addObject:image];
    }
    detail.img = arrayM;
    
    return detail;
}
@end
