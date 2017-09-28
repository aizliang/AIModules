//
//  ViewController.m
//  DSLinkageVC
//
//  Created by ai on 2017/8/29.
//  Copyright © 2017年 ai. All rights reserved.
//

#import "ViewController.h"
#import "DSLinkageVC.h"
#import "MyTableVC.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *vcs;

@property (nonatomic, strong) NSMutableArray *titles2;
@property (nonatomic, strong) NSMutableArray *vcs2;

@property (nonatomic, strong) DSLinkageVC *linkageVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = [@[@"标题1",@"标题2",@"标题3",@"标题4",@"标题5",@"标题6",@"标题7",@"标题8"] mutableCopy];
    self.vcs = [@[] mutableCopy];
    [_titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MyTableVC *myTable = [[MyTableVC alloc] init];
        myTable.title = _titles[idx];
        [_vcs addObject:myTable];
    }];
    
    self.titles2 = [@[@"标题1",@"title2"] mutableCopy];
    self.vcs2 = [@[] mutableCopy];
    [_titles2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MyTableVC *myTable = [[MyTableVC alloc] init];
        myTable.title = _titles2[idx];
        [_vcs2 addObject:myTable];
    }];
    // Do any additional setup after loading the view.
}


- (UIViewController *)creatVC {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    return vc;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showLinkage:(id)sender {
    self.linkageVC = [[DSLinkageVC alloc] initWithTitles:_titles vcs:_vcs];
    _linkageVC.contentViewFrame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
    _linkageVC.titleViewFrame = CGRectMake(0, 0, _linkageVC.contentViewFrame.size.width - 30, 40);
    [_linkageVC setTitleViewWithBackgroundColor:[UIColor orangeColor] norColor:[UIColor greenColor] selColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:16]];
    [_linkageVC setTilteTransformWithStyle:TitleColorTransformShiftColor titleScale:1.2];
    [self.navigationController pushViewController:_linkageVC animated:YES];
    
    UIButton *changeIndexButton = [[UIButton alloc] initWithFrame:CGRectMake(_linkageVC.contentViewFrame.size.width - 30, 64, 30, 40)];
    changeIndexButton.backgroundColor = [UIColor blueColor];
    [changeIndexButton addTarget:self action:@selector(changeIndex) forControlEvents:UIControlEventTouchUpInside];
    [_linkageVC.view addSubview:changeIndexButton];
}

- (IBAction)showLinkage2:(id)sender {
    DSLinkageVC *linkageVC = [[DSLinkageVC alloc] initWithTitles:_titles2 vcs:_vcs2];
    linkageVC.contentViewFrame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
    [linkageVC setTitleViewWithBackgroundColor:[UIColor orangeColor] norColor:[UIColor greenColor] selColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:16]];
    [linkageVC setTilteTransformWithStyle:TitleColorTransformShiftColor titleScale:1.2];
    [self.navigationController pushViewController:linkageVC animated:YES];
}


- (void)changeIndex {
//    _linkageVC.index = 0;
//    [_vcs removeLastObject];
    [_titles insertObject:@"添加标题" atIndex:0];
    [_vcs insertObject:[self creatVC] atIndex:0];
    [_linkageVC changeWithTitles:_titles vcs:_vcs];
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
