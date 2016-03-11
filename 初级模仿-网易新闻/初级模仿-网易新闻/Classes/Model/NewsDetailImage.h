//
//  NewsDetailImage.h
//  初级模仿-网易新闻
//
//  Created by Silence on 16/3/11.
//  Copyright © 2016年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsDetailImage : NSObject

/** PC端鼠标放上去的图片文字 */
@property (nonatomic, copy) NSString *alt;

/** 图片ID */
@property (nonatomic, copy) NSString *photosetID;

/** 图片的大小 */
@property (nonatomic, copy) NSString *pixel;

/** 图片的标记 */
@property (nonatomic, copy) NSString* ref;

/** 图片的地址 */
@property (nonatomic, copy) NSString *src;


+ (instancetype)newsDetailImageWith:(NSDictionary *)dict;
@end
