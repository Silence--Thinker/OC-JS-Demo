//
//  NewsDetailImage.m
//  初级模仿-网易新闻
//
//  Created by Silence on 16/3/11.
//  Copyright © 2016年 silence. All rights reserved.
//

#import "NewsDetailImage.h"

@implementation NewsDetailImage

+ (instancetype)newsDetailImageWith:(NSDictionary *)dict {
    
    NewsDetailImage *image = [NewsDetailImage new];
    image.alt = [dict objectForKey:@"alt"];
    image.photosetID = [dict objectForKey:@"photosetID"];
    image.pixel = [dict objectForKey:@"pixel"];
    image.ref = [dict objectForKey:@"ref"];
    image.src = [dict objectForKey:@"src"];
    
    return image;
}
@end
