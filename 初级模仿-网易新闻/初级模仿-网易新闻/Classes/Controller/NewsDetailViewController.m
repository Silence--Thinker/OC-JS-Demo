//
//  NewsDetailViewController.m
//  初级模仿-网易新闻
//
//  Created by Silence on 16/3/11.
//  Copyright © 2016年 silence. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "HttpManager.h"
#import "NewsModel.h"
#import "NewsDetailsModel.h"

@interface NewsDetailViewController () <UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *webView;

@property (nonatomic, strong) NewsDetailsModel *newsDetail;
@end
@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    [self buildNewsDetailInfo];
}

- (void)buildNewsDetailInfo {
    
    __weak typeof(self) weakSelf = self;
    
    NSString *newsDetail = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.newsModel.docid];
    [[HttpManager manager] GET:newsDetail parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *detailDict = [responseObject objectForKey:weakSelf.newsModel.docid];
        NewsDetailsModel *detail = [NewsDetailsModel newsDetailWith:detailDict];
        NSLog(@"%zd", detail.img.count);
        weakSelf.newsDetail = detail;
        [weakSelf buildWebViewHTMLString];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)buildWebViewHTMLString {
    
    [self.webView loadHTMLString:self.newsDetail.body baseURL:nil];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"完成");
}

@end
