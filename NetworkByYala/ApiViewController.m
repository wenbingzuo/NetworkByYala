//
//  ApiViewController.m
//  NetworkByYala
//
//  Created by 文兵 左 on 12/14/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#import "ApiViewController.h"
#import "ResultViewController.h"
#import "DoubanViewController.h"

@interface ApiViewController () <DZRequestDelegate>

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation ApiViewController

- (IBAction)sendGetRequest:(id)sender {
    DZBaseRequest *request = [DZBaseRequest new];
    request.requestBaseURL = @"https://api.douban.com";
    request.requestURL = @"/v2/music/search";
    request.requestParameters = @{@"q":@"周杰伦"};
    [request startWithRequestSuccessBlock:^(DZBaseRequest *request) {
        [self handleResult:request.responseObject];
    } failureBlock:^(DZBaseRequest *request) {
        NSString *error = request.error.localizedDescription;
        if ([request.error.domain isEqualToString:DZRequestOutOfNetwork]) {
            error = @"没有网络 %>_<% ";
        }
        [self handleResult:error];
    }];
}

- (IBAction)sendPostRequest:(id)sender {
    DZBaseRequest *request = [DZBaseRequest new];
    request.requestURL = @"http://www.oschina.net/action/api/user_updaterelation";
    request.requestMethod = DZRequestMethodPOST;
    request.requestSerializerType = DZRequestSerializerTypeForm;
    request.responseSerializerType = DZResponseSerializerTypeHTTP;
    request.requestParameters = @{@"uid":@"2544566", @"hisuid":@"1181793", @"newrelation":@"1"};
    request.delegate = self;
    [request start];
}

- (IBAction)sendUploadRequest:(id)sender {
    DZBaseRequest *request = [DZBaseRequest new];
    request.requestBaseURL = @"http://www.oschina.net";
    request.requestURL = @"/action/api/portrait_update";
    request.requestMethod = DZRequestMethodPOST;
    request.responseSerializerType = DZResponseSerializerTypeHTTP;
    request.requestSerializerType = DZRequestSerializerTypeForm;
    request.requestParameters = @{@"uid":@"2544566"};
    [request setUploadProgress:^(NSProgress *progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressView.progress = progress.fractionCompleted;
        });
    }];
    request.delegate = self;
    [request setConstructionBodyBlock:^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation([UIImage imageNamed:@"images.jpeg"], 1);
        [formData appendPartWithFileData:data name:@"portrait" fileName:@"19900000" mimeType:@"image/jpeg"];
    }];
    [request start];
}

- (void)handleResult:(id)result {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ResultViewController *resultVC = [sb instantiateViewControllerWithIdentifier:@"ResultViewController"];
    resultVC.result = result;
    [self.navigationController pushViewController:resultVC animated:YES];
}

#pragma mark - DZRequestDelegate
- (void)requestWillStart:(DZBaseRequest *)request {
    DZDebugLog(@"开始请求");
}

- (void)requestDidSuccess:(DZBaseRequest *)request {
    id result = request.responseObject;
    if ([result isKindOfClass:[NSData class]]) {
        result = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    }
    [self handleResult:result];
}

- (void)requestDidFailure:(DZBaseRequest *)request {
    [self handleResult:request.error.localizedDescription];
}

@end
