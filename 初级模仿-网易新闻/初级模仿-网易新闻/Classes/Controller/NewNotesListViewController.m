//
//  NewNotesListViewController.m
//  初级模仿-网易新闻
//
//  Created by Silence on 16/3/10.
//  Copyright © 2016年 silence. All rights reserved.
//

#import "NewNotesListViewController.h"
#import "NewListCell.h"
#import "NewsModel.h"
#import "HttpManager.h"
#import "NewsDetailViewController.h"

static NSString * const kNewListCell = @"NewListCell";

@interface NewNotesListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *newsNoteList;

@end
@implementation NewNotesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 90.0;
    [self configTableView:^(NSArray *resultArray) {
        self.newsNoteList = resultArray;
        [self.tableView reloadData];
    }];
}

- (void)configTableView:(void(^)(NSArray *resultArray))config {
    
//    http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html? key:T1348647853363
//    http://c.3g.163.com/recommend/getSubDocPic?passport=&devId=t key:推荐
//    http://c.m.163.com/nc/article/list/T1348648517839/0-20.html key:T1348648517839
    
    [[HttpManager manager] GET:@"http://c.m.163.com/nc/article/list/T1348648517839/0-20.html" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultDict = responseObject;
        NSArray *array = [resultDict objectForKey:@"T1348648517839"];
        NSMutableArray *tempM = @[].mutableCopy;
        for (NSDictionary *dict in array) {
            [tempM addObject:[NewsModel newModelWithDictionary:dict]];
        }
        if (config) {
            config(tempM);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsNoteList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewListCell * cell = [tableView dequeueReusableCellWithIdentifier:kNewListCell];
    cell.newsM = self.newsNoteList[indexPath.row];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NewsDetailViewController *newsDetail = segue.destinationViewController;
    NSInteger row = self.tableView.indexPathForSelectedRow.row;
    newsDetail.newsModel = self.newsNoteList[row];
}
@end
