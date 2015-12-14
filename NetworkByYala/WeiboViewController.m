//
//  WeiboViewController.m
//  NetworkByYala
//
//  Created by 文兵 左 on 12/14/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#import "WeiboViewController.h"
#import <MJRefresh.h>
#import "WeiboCacheRequest.h"

@interface WeiboViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) WeiboCacheRequest *request;

@end

@implementation WeiboViewController

- (WeiboCacheRequest *)request {
    if (!_request) {
        _request = [WeiboCacheRequest new];
        _request.baseURL = @"https://api-menke.dev.joinmind.org";
        _request.requestURL = @"/v1/user/getProfile";
        _request.responseSerializerType = DZResponseSerializerTypeJSON;
        [_request setRequestSuccessBlock:^(DZBaseRequest *request) {
            DZDebugLog(@"%@ -- %@", request.responseObject, request.error.localizedDescription);
        }];
        [_request setRequestFailureBlock:^(DZBaseRequest *request) {
            DZDebugLog(@"%@ -- %@", request.responseObject, request.error.localizedDescription);
        }];
    }
    return _request;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self headerRefresh];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotification:) name:DZRequestDidFinishNotification object:nil];
}

- (void)didReceiveNotification:(NSNotification *)notification {
    [self.tableView.mj_header endRefreshing];
}

- (void)headerRefresh {
    
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    __weak typeof(self) weakSelf = self;
    [self.request setRequestStartBlock:^(DZBaseRequest *request) {
        [weakSelf.tableView.mj_header beginRefreshing];
    }];
    [self.request start];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}


@end
