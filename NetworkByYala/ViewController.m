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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

//    DZTest *test = [DZTest new];
//    [test start];
    DZOSChinaTest *tst = [DZOSChinaTest new];
    [tst start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sendGETRequest:(id)sender {
    DZTestGet *getTest = [DZTestGet new];
    [getTest start];
}

- (IBAction)sendPOSTRequest:(id)sender {
    DZTestPost *postTest = [DZTestPost new];
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

@end
