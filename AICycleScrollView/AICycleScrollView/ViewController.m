//
//  ViewController.m
//  AICycleScrollView
//
//  Created by ai on 2017/8/16.
//  Copyright © 2017年 ai. All rights reserved.
//

#import "ViewController.h"
#import "AICycleScrollView.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *imageUrls;
@property (nonatomic, strong) NSArray *imageUrls1;
@property (nonatomic, strong) NSArray *imageUrls2;
@property (nonatomic, strong) NSArray *imageUrls3;

@property (nonatomic, strong) AICycleScrollView *bannerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageUrls3 = @[@{@"imgUrl":@"http://ddsc2.ddsoucai.com/common/activity/%E6%96%B0%E6%89%8B%E6%B3%A8%E5%86%8C.jpg"},
                        @{@"imgUrl":@"http://ddsc2.ddsoucai.com/common/activity/%E6%81%92%E4%B8%B0%E9%93%B6%E8%A1%8C%E5%AD%98%E7%AE%A1%E4%BB%8B%E7%BB%8D.jpg"},
                        @{@"imgUrl":@"http://ddsc2.ddsoucai.com/common/activity/%E5%8F%91%E7%8E%B0_%E6%B5%A6%E5%8F%91%E4%BF%A1%E7%94%A8%E5%8D%A1.jpg"},
                        @{@"imgUrl":@"http://ddsc2.ddsoucai.com/common/activity/txjhbanner.jpg"}];
    
    
    self.bannerView = [[AICycleScrollView alloc] initWithFrame:CGRectMake(0, 45, self.view.bounds.size.width, 90)];
    self.bannerView.scrollViewSize = CGSizeMake(245 + 10, 85);
    self.bannerView.itemSpace = 10.0;
    self.bannerView.itemScaleHeight = 10.0;
    self.bannerView.records = self.imageUrls3;
    self.bannerView.didClickCycleView = ^(NSInteger index) {
        NSLog(@"点击了第 %ld 个cell", index);
    };
    [self.view addSubview:self.bannerView];
    // Do any additional setup after loading the view, typically from a nib.
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
