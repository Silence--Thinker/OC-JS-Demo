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
#import <AFNetworking.h>


static NSString * const kNewListCell = @"NewListCell";

@interface NewNotesListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *newsNoteList;

@end
@implementation NewNotesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableView:^(NSArray *resultArray) {
        self.newsNoteList = resultArray;
        [self.tableView reloadData];
    }];
}

- (void)configTableView:(void(^)(NSArray *resultArray))config {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSSet *set = manager.responseSerializer.acceptableContentTypes;
    NSMutableSet *newSet = [NSMutableSet setWithSet:set];
    [newSet addObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = newSet;
    
    [manager GET:@"http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html?" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultDict = responseObject;
        NSArray *array = [resultDict objectForKey:@"T1348647853363"];
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
@end
