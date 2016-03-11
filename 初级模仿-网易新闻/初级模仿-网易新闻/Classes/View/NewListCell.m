//
//  NewListCell.m
//  初级模仿-网易新闻
//
//  Created by Silence on 16/3/10.
//  Copyright © 2016年 silence. All rights reserved.
//

#import "NewListCell.h"
#import "UIImageView+WebCache.h"

@interface NewListCell ()

@property (nonatomic, weak) IBOutlet UIImageView *pictureView;
@property (nonatomic, weak) IBOutlet UILabel *newsTitle;
@property (nonatomic, weak) IBOutlet UILabel *newsDigest;

@end
@implementation NewListCell

- (void)awakeFromNib {
    [self.newsDigest setPreferredMaxLayoutWidth:[UIScreen mainScreen].bounds.size.width - 135];
}

- (void)setNewsM:(NewsModel *)newsM {
    _newsM = newsM;
    NSURL *imageURlL = [NSURL URLWithString:newsM.imgsrc];
    [self.pictureView sd_setImageWithURL:imageURlL];
    self.newsTitle.text = newsM.title;
    self.newsDigest.text = newsM.digest;
    
}
@end
