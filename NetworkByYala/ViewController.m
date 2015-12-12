//
//  ViewController.m
//  NetworkByYala
//
//  Created by 文兵 左 on 12/8/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#import "ViewController.h"
#import "DZTestGet.h"
#import "DZTestPost.h"
#import "DZOSChinaTest.h"

@interface ViewController () <DZRequestDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testNotification:) name:DZRequestDidFinishNotification object:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

//    DZTest *test = [DZTest new];
//    [test start];
    DZOSChinaTest *tst = [DZOSChinaTest new];
    [tst setRequestSuccessBlock:^(DZBaseRequest *request) {
        DZDebugLog(@"%@ -- %@", request.responseObject, request.error.localizedDescription);
    }];
    [tst setRequestFailureBlock:^(DZBaseRequest *request) {
        DZDebugLog(@"%@ -- %@", request.responseObject, request.error.localizedDescription);
    }];
    [tst start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sendGETRequest:(id)sender {
    DZTestGet *getTest = [DZTestGet new];
    getTest.delegate = self;
    [getTest setRequestSuccessBlock:^(DZBaseRequest *request) {
        DZDebugLog(@"%@ -- %@", request.responseObject, request.error.localizedDescription);
    }];
    [getTest setRequestFailureBlock:^(DZBaseRequest *request) {
        DZDebugLog(@"%@ -- %@", request.responseObject, request.error.localizedDescription);
    }];
    
    [getTest start];
}

- (IBAction)sendPOSTRequest:(id)sender {
    DZTestPost *postTest = [DZTestPost new];
    postTest.delegate = self;
    [postTest setRequestSuccessBlock:^(DZBaseRequest *request) {
        DZDebugLog(@"%@ -- %@", request.responseObject, request.error.localizedDescription);
    }];
    [postTest setRequestFailureBlock:^(DZBaseRequest *request) {
        DZDebugLog(@"%@ -- %@", request.responseObject, request.error.localizedDescription);
    }];
    [postTest start];
}
- (IBAction)sendPUTRequest:(id)sender {
}
- (IBAction)sendDELETERequest:(id)sender {
}



#pragma mark - DZRequestDelegate
- (void)requestDidSuccess:(DZBaseRequest *)request {
    DZDebugMethod();
}

- (void)requestDidFailure:(DZBaseRequest *)request {
    DZDebugMethod();
}

#pragma mark - NSNotification
- (void)testNotification:(NSNotification *)notification {
    
}
@end
