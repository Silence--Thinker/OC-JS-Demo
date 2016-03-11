//
//  NewsDetailsModel.h
//  初级模仿-网易新闻
//
//  Created by Silence on 16/3/11.
//  Copyright © 2016年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsDetailsModel : NSObject

/** HTML body 体 */
@property (nonatomic, copy) NSString *body;

/** 责任编辑 */
@property (nonatomic, copy) NSString *ec;

/** 新闻标题 */
@property (nonatomic, copy) NSString *title;

/** 新闻所有图片 */
@property (nonatomic, copy) NSArray *img;

/** 新闻时间 */
@property (nonatomic, copy) NSString *ptime;

/** 新闻来源 */
@property (nonatomic, copy) NSString *source;




+ (instancetype)newsDetailWith:(NSDictionary *)dict;


@end
