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
    getTest.baseURL = @"https://api-menke.dev.joinmind.org";
    getTest.requestURL = @"/v1/user/getProfile";
    getTest.responseSerializerType = DZResponseSerializerTypeHTTP;
//    getTest.loadCache = YES;
    [getTest setRequestSuccessBlock:^(DZBaseRequest *request) {
        DZDebugLog(@"%@ -- %@", request.responseObject, request.error.localizedDescription);
        NSString *str = [[NSString alloc] initWithData:request.responseObject encoding:NSUTF8StringEncoding];
        DZDebugLog(@"--> %@", str);
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


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    DZTestGet *getTest = [DZTestGet new];
    
    getTest.baseURL = @"http://www.oschina.net";
    getTest.requestURL = @"/action/api/my_information";
    
//    getTest.loadCache = NO;
    getTest.requestParameters = @{@"uid":@"2544566"};
    getTest.responseSerializerType = DZResponseSerializerTypeHTTP;
    getTest.requestSerializerType = DZRequestSerializerTypeForm;
    
    [getTest setRequestSuccessBlock:^(DZBaseRequest *request) {
        DZDebugLog(@"%@ -- %@", request.responseObject, request.error.localizedDescription);
    }];
    [getTest setRequestFailureBlock:^(DZBaseRequest *request) {
        DZDebugLog(@"%@ -- %@", request.responseObject, request.error.localizedDescription);
    }];
    
    [getTest start];
}

// XML
- (IBAction)XMLGetRequest:(id)sender {
    DZTestGet *xmlGet = [DZTestGet new];
    xmlGet.baseURL = @"http://www.oschina.net";
    xmlGet.requestURL = @"/action/api/my_information";
    xmlGet.requestParameters = @{@"uid":@"2544566"};
    
    xmlGet.requestSerializerType = DZRequestSerializerTypeForm;
    xmlGet.responseSerializerType = DZResponseSerializerTypeHTTP;
    [xmlGet startWithRequestSuccessBlock:^(DZBaseRequest *request) {
        NSString *str = [[NSString alloc] initWithData:request.responseObject encoding:NSUTF8StringEncoding];
        DZDebugLog(@"%@", str);
        
    } failureBlock:^(DZBaseRequest *request) {
        DZDebugLog(@"failure");
    }];
}

- (IBAction)XMLPostRequest:(id)sender {
    
}


@end
