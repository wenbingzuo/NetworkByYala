//
//  DoubanViewController.m
//  NetworkByYala
//
//  Created by 文兵 左 on 12/14/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#import "DoubanViewController.h"
#import <MJRefresh.h>
#import "DoubanRequest.h"
#import "DoubanCell.h"

@interface DoubanViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) DoubanRequest *request;

@property (nonatomic, strong) NSArray *songs;

@end

@implementation DoubanViewController

- (DoubanRequest *)request {
    if (!_request) {
        _request = [DoubanRequest new];
        _request.requestBaseURL = @"http://api.douban.com/";
        _request.requestURL = @"/v2/music/search";
        _request.requestParameters = @{@"q":@"周杰伦"};
        _request.cacheTimeInterval = 10;
        _request.switching = NO;
        __weak typeof(self) weakSelf = self;
        [_request setRequestSuccessBlock:^(DZBaseRequest *request) {
            NSArray *musics = request.responseObject[@"musics"];
            NSMutableArray *data = [NSMutableArray array];
            for (NSDictionary *dic in musics) {
                [data addObject:dic[@"title"]];
            }
            weakSelf.songs = data;
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_header endRefreshing];
        }];
        [_request setRequestFailureBlock:^(DZBaseRequest *request) {
            [weakSelf.tableView.mj_header endRefreshing];
        }];
    }
    return _request;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
}

- (void)loadData {
    if (!self.request.switching) {
        [self.request startNotToggleWillStartTag];
    }
    self.request.switching = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    __weak typeof(self) weakSelf = self;
    [self.request setRequestStartBlock:^(DZBaseRequest *request) {
        weakSelf.request.switching = YES;
        [weakSelf.tableView.mj_header beginRefreshing];
    }];
    [self.request start];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kDoubanCellIdentifier = @"DoubanCellIdentifier";
    DoubanCell *cell = [tableView dequeueReusableCellWithIdentifier:kDoubanCellIdentifier forIndexPath:indexPath];
    
    cell.mainTitle.text = self.songs[indexPath.row];
    return cell;
}

- (void)dealloc {
    DZDebugLog(@"%@ dealloc", [self class]);
}
@end
