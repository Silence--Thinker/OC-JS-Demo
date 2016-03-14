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
#import "NewsDetailImage.h"

@interface NewsDetailViewController () <UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *webView;

@property (nonatomic, strong) NewsDetailsModel *newsDetail;
@end
@implementation NewsDetailViewController

- (void)dealloc {
    NSLog(@"%s", __func__);
}

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
        [detailDict writeToFile:@"/Users/Silence/Desktop/details.plist" atomically:YES];
        
        NewsDetailsModel *detail = [NewsDetailsModel newsDetailWith:detailDict];
        NSLog(@"%zd", detail.img.count);
        weakSelf.newsDetail = detail;
        NSString *htmlStr = [weakSelf buildWebViewHTMLString];
        [weakSelf.webView loadHTMLString:htmlStr baseURL:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (NSString *)buildWebViewHTMLString {
    // 头信息
    NSMutableString *htmlStr = [NSMutableString stringWithFormat:@"<html>"];
    [htmlStr appendString:@"<head>"];
    [htmlStr appendString:@"<meta charset = \"UTF-8\">"];
    [htmlStr appendFormat:@"<link rel = \"stylesheet\" href = \"%@\">",[[NSBundle mainBundle] URLForResource:@"XJDetail.css" withExtension:nil]];
    [htmlStr appendString:@"</head>"];

    // body体
     [self buildHTMLBodyWith:htmlStr];
    
    // 作者
    [htmlStr appendFormat:@"<div class = \"author\">[责任编辑：%@]</div>", self.newsDetail.ec];
    [htmlStr appendString:@"</html>"];
    
    NSLog(@"%@", htmlStr);
    return htmlStr;
}
- (NSMutableString *)buildHTMLBodyWith:(NSMutableString *)htmlStr {
    
    [htmlStr appendString:@"<body>"];
    [htmlStr appendFormat:@"<div class = \"title\">%@</div>", self.newsDetail.title];
    [htmlStr appendFormat:@"<div class = \"time\">%@  %@</div>", self.newsDetail.ptime, self.newsDetail.source];
    [htmlStr appendString:self.newsDetail.body];
    [htmlStr appendString:@"<body>"];
    // 拼接图片
    
    for (NewsDetailImage *detailImage in self.newsDetail.img) {
        NSMutableString *temp = [NSMutableString string];
        NSLog(@"%@", detailImage.pixel);
        NSArray *array = [detailImage.pixel componentsSeparatedByString:@"*"];
        CGFloat width = [array.firstObject doubleValue];
        CGFloat height = [array.lastObject doubleValue];
        CGFloat width_r = [UIScreen mainScreen].bounds.size.width - 20;
        height = width_r / width * height;
        width = width_r;
        NSString *imageTitle = detailImage.alt.length ? [NSString stringWithFormat:@"<div class = \"imageTitle\">%@</div>",detailImage.alt] : @"";
        // 图片包装一下
        [temp appendString:@"<div class = \"image-pic\" >"];
        // 增加图片的点击方法
        NSString *clickFunction = @"this.onclick = function (){\
                            window.location.href = 'xj:' + this.src;   \
                                }";
        [temp appendFormat:@"<img onload = \"%@\" width = \"%0.2f\" height = \"%0.2f\" src = \"%@\">",clickFunction,width, height, detailImage.src];
        [temp appendString:imageTitle];
        [temp appendString:@"</div>"];

        [htmlStr replaceOccurrencesOfString:detailImage.ref withString:temp options:NSLiteralSearch range:NSMakeRange(0, htmlStr.length)];

    }
    return htmlStr;
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (webView == self.webView) {
        NSString *URLStr = request.URL.absoluteString;
        NSRange range = [URLStr rangeOfString:@"xj:"];
        if (range.length > 0) {
            NSLog(@"%@", URLStr);
            NSString *imageURL = [URLStr substringWithRange:NSMakeRange(range.location + range.length, URLStr.length-range.location-range.length)];
            NSLog(@"%@", URLStr);
            [self downImageWithImageURL:imageURL];
            return NO;
        }
        return YES;
    }
    return YES;
}

- (void)downImageWithImageURL:(NSString *)imageURL {
    NSLog(@"%@", imageURL);
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否要保存图片到相册？" preferredStyle:UIAlertControllerStyleActionSheet];
  
    [alertVc addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:nil]];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSURLCache *urlCache = [NSURLCache sharedURLCache];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]];
        NSCachedURLResponse *response = [urlCache cachedResponseForRequest:request];
        UIImage *image = [UIImage imageWithData:response.data];
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }]];
    [self presentViewController:alertVc animated:YES completion:nil];
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *message = [NSString stringWithFormat:@"图片保存%@%@",error ? @"失败" : @"成功", error];
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertVc animated:YES completion:nil];
    NSLog(@"%@q", error);
}
@end
