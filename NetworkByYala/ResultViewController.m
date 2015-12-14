//
//  ResultViewController.m
//  NetworkByYala
//
//  Created by 文兵 左 on 12/14/15.
//  Copyright © 2015 文兵 左. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.text = [NSString stringWithFormat:@"%@", self.result];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
