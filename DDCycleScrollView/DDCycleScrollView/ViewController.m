//
//  ViewController.m
//  DDCycleScrollView
//
//  Created by ai on 2017/7/4.
//  Copyright © 2017年 ai. All rights reserved.
//

#import "ViewController.h"
#import "DDCycleScrollView.h"
#import "DDCycleScrollViewCell.h"
#import "DDCycleViewCell2.h"
#import "SMPageControl.h"

@interface ViewController ()
@property (nonatomic, strong) DDCycleScrollView *banner;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBanner];

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)configBanner {
    NSArray *imagesURLStrings = @[
                                  @"http://ddsc2.ddsoucai.com/common/activity/%E6%BB%A1%E5%B0%B1%E9%80%81banner.jpg",
                                  @"http://ddsc2.ddsoucai.com/common/activity/%E6%81%92%E4%B8%B0%E9%93%B6%E8%A1%8C%E5%AD%98%E7%AE%A1%E4%BB%8B%E7%BB%8D.jpg",
                                  @"http://ddsc2.ddsoucai.com/common/activity/%E6%96%B0%E6%89%8B%E6%B3%A8%E5%86%8C.jpg"
                                  ];
    self.banner = [[DDCycleScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 80) autoScroll:YES cellCount:0 cellFromClass:@"DDCycleScrollViewCell"];
    _banner.backgroundColor = [UIColor redColor];
    _banner.cellCount = imagesURLStrings.count;
    [_banner setCycleViewReuseCellFromClass:@"DDCycleScrollViewCell" nibName:nil];
    
    _banner.setCellData = ^(UICollectionViewCell *cell, NSInteger index) {
        if (![cell isMemberOfClass:[DDCycleScrollViewCell class]]) return;
        DDCycleScrollViewCell *bannerCell = (DDCycleScrollViewCell *)cell;
        bannerCell.imagePath = imagesURLStrings[index];
    };
    
    _banner.didClickCycleView = ^(NSInteger index) {
        NSLog(@"%ld",(long)index);
    };
    [self.view addSubview:_banner];
}

- (IBAction)changeImagePaths:(id)sender {
    NSArray *imageUrls = @[
                           @"http://ddsc2.ddsoucai.com/common/activity/txjhbanner.jpg",
                           @"http://ddsc2.ddsoucai.com/common/activity/%E5%AE%89%E5%85%A8%E4%BF%9D%E9%9A%9C.jpg",
                           @"http://ddsc2.b0.upaiyun.com/common/activity/%E8%BF%90%E8%90%A5%E6%8A%A5%E5%91%8Abanner.jpg"
                          ];
    
    _banner.setCellData = ^(UICollectionViewCell *cell, NSInteger index) {
        if (![cell isMemberOfClass:[DDCycleScrollViewCell class]]) return;
        DDCycleScrollViewCell *bannerCell = (DDCycleScrollViewCell *)cell;
        bannerCell.imagePath = imageUrls[index];
    };
    
    _banner.cellCount = imageUrls.count;
    _banner.timeInterval = 4.0;
    _banner.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    SMPageControl *pageCtrl = [[SMPageControl alloc] initWithFrame:CGRectMake(0 , _banner.bounds.size.height - 20, _banner.bounds.size.width, 20)];
    [pageCtrl setPageIndicatorImage:[UIImage imageNamed:@"bg_banner_navigator_xuanzhong"]];
    [pageCtrl setCurrentPageIndicatorImage:[UIImage imageNamed:@"bg_banner_navigator_weixuanzhong"]];
    pageCtrl.alignment = SMPageControlAlignmentRight;
    pageCtrl.indicatorMargin = 3.0;
    pageCtrl.indicatorDiameter = 8.0;
    pageCtrl.hidesForSinglePage = YES;
    
    _banner.pageControl = pageCtrl;
}

- (IBAction)showSingleImage:(id)sender {
    NSArray *imageUrls = @[
                           @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                          ];
    _banner.cellCount = imageUrls.count;
    _banner.setCellData = ^(UICollectionViewCell *cell, NSInteger index) {
        if (![cell isMemberOfClass:[DDCycleScrollViewCell class]]) return;
        DDCycleScrollViewCell *bannerCell = (DDCycleScrollViewCell *)cell;
        bannerCell.imagePath = imageUrls[index];
    };
}

- (IBAction)changeScrollState:(id)sender {
    _banner.autoScroll = !_banner.autoScroll;
}

- (IBAction)reloadImages:(id)sender {
    _banner.cellCount = 0;
}

- (IBAction)reloadZeroBoundsImage:(id)sender {
    _banner.frame = CGRectZero;
}


- (IBAction)resetBanner:(id)sender {
    [_banner removeFromSuperview];
    _banner = nil;
  
    [self configBanner];
}


- (IBAction)changeCellSource:(id)sender {
    [_banner setCycleViewReuseCellFromClass:nil nibName:@"DDCycleViewCell2"];
    
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    _banner.setCellData = ^(UICollectionViewCell *cell, NSInteger index) {
        DDCycleViewCell2 *cell2 = (DDCycleViewCell2 *)cell;
        cell2.imageUrl = imagesURLStrings[index];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
