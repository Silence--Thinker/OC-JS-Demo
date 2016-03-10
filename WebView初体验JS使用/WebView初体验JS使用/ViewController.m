//
//  ViewController.m
//  WebView初体验JS使用
//
//  Created by Silence on 16/3/9.
//  Copyright © 2016年 silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *webView;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 牛逼这一句
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    self.webView.delegate = self;
    NSURL *url = [NSURL URLWithString:@"http://v3.bootcss.com/"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate 
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *jsStr = [self demo3];
    NSString *result = [webView stringByEvaluatingJavaScriptFromString:jsStr];
    
    NSLog(@"%@", result);
}

- (NSString *)demo1 {
    NSString *jsStr = @"document.getElementsByTagName('footer')[0].remove();";
    return jsStr;
}

/** JS交互得到JS的返回值 */
- (NSString *)demo2 {
    NSString *jsStr = @"var name = 'Tom', age = 10;"
                       "'2016 ' + name + ' '+age + 'years old';";
    return jsStr;
}

/** 得到网页所有源码 */
- (NSString *)demo3 {
    NSString *jsStr = @"document.body.outerHTML";
    return jsStr;
}

@end
