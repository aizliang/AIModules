//
//  ViewController.m
//  DSShareManager
//
//  Created by ai on 2017/9/26.
//  Copyright © 2017年 ai. All rights reserved.
//

#import "ViewController.h"
#import "DSShareManager.h"
#import "WXApi.h"

@interface ViewController ()
@property (nonatomic, strong) NSData *imageData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"res5" ofType:@"jpg"];
    self.imageData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareToWXSession:(id)sender {
    DSShareModel *model = [[DSShareModel alloc] initWithTitle:@"测试" content:@"这是一个测试内容" imageData:self.imageData linkUrl:@"https://www.baidu.com/"];
    [[DSShareManager shareManager] shareWithModel:model shareType:ShareToWXSession];
}


- (IBAction)shareToWXCirle:(id)sender {
    DSShareModel *model = [[DSShareModel alloc] initWithTitle:@"测试" content:@"这是一个测试内容" imageData:self.imageData linkUrl:@"https://www.baidu.com/"];
    [[DSShareManager shareManager] shareWithModel:model shareType:ShareToWXCicle];
}


- (IBAction)shareToQQSession:(id)sender {
    DSShareModel *model = [[DSShareModel alloc] initWithTitle:@"测试" content:@"这是一个测试内容" imageData:self.imageData linkUrl:@"https://www.baidu.com/"];
    [[DSShareManager shareManager] shareWithModel:model shareType:ShareToQQSession];
}

- (IBAction)shareToQQZone:(id)sender {
    DSShareModel *model = [[DSShareModel alloc] initWithTitle:@"测试" content:@"这是一个测试内容" imageData:self.imageData linkUrl:@"https://www.baidu.com/"];
    [[DSShareManager shareManager] shareWithModel:model shareType:ShareToQQZone];
}

- (IBAction)shareToWB:(id)sender {
    DSShareModel *model = [[DSShareModel alloc] initWithTitle:@"测试" content:@"这是一个测试内容" imageData:self.imageData linkUrl:@"http://weibo.com/p/1001603849727862021333?rightmod=1&wvr=6&mod=noticeboard"];
    [[DSShareManager shareManager] shareWithModel:model shareType:ShareToWB];
}

@end
