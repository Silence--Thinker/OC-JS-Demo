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

}


- (void)setNewsM:(NewsModel *)newsM {
    _newsM = newsM;
    [self.pictureView sd_setImageWithURL:newsM.imgsrc];
    self.newsTitle = newsM.title;
    self.newsDigest = newsM.digest;
    
}
@end
