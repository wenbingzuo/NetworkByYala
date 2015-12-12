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
#import "DZTestUpload.h"

@interface ViewController () <DZRequestDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testNotification:) name:DZRequestDidFinishNotification object:nil];
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

// POST
- (IBAction)sendPOSTRequest:(id)sender {
    DZTestPost *postTest = [DZTestPost new];
    DZDebugLog(@"%@", NSHomeDirectory());
    
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
- (IBAction)sendDownloadRequest:(id)sender {
    DZTestUpload *testDownload = [DZTestUpload new];
    
    [testDownload setRequestSuccessBlock:^(DZBaseRequest *request) {
        DZDebugLog(@"%@", request.responseObject);
    }];
    [testDownload setRequestFailureBlock:^(DZBaseRequest *request) {
        DZDebugLog(@"%@", request.error.localizedDescription);
    }];
    
    [testDownload start];
}



//#pragma mark - DZRequestDelegate
//- (void)requestDidSuccess:(DZBaseRequest *)request {
//    DZDebugMethod();
//}
//
//- (void)requestDidFailure:(DZBaseRequest *)request {
//    DZDebugMethod();
//}
//
//#pragma mark - NSNotification
//- (void)testNotification:(NSNotification *)notification {
//    
//}
@end
