//
//  NewsModel.h
//  初级模仿-网易新闻
//
//  Created by Silence on 16/3/10.
//  Copyright © 2016年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
/** 新闻的id*/
@property (nonatomic, copy) NSString *docid;

/** 新闻标题 */
@property (nonatomic, copy) NSString *title;

/** 新闻摘要 */
@property (nonatomic, copy) NSString *digest;

/** 新闻的图片 */
@property (nonatomic, copy) NSString *imgsrc;

/** 新闻URL 手机版本 */
@property (nonatomic, copy) NSString *url;

/** 新闻URL PC版本 */
@property (nonatomic, copy) NSString *url_3w;


+ (instancetype)newModelWithDictionary:(NSDictionary *)dict;
@end
