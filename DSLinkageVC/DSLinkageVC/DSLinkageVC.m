//
//  DSLinkageVC.m
//  DSLinkageVC
//
//  Created by ai on 2017/8/29.
//  Copyright © 2017年 ai. All rights reserved.
//

#import "DSLinkageVC.h"
#import "DSLinkageLabel.h"

#define kViewWidth self.contentView.bounds.size.width
#define kViewHeight self.contentView.bounds.size.height

//默认标题间距
static float const kTitleLabelSpace = 20.0;

@interface DSLinkageVC ()<UICollectionViewDelegate, UICollectionViewDataSource>
//主要视图
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIScrollView *titleView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;


//数据源
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, copy) NSArray *vcs;


//标题栏样式
@property (nonatomic, strong) UIColor *titleViewBgColor;
@property (nonatomic, strong) UIFont *titileFont;
@property (nonatomic, strong) UIColor *norColor;
@property (nonatomic, strong) UIColor *selColor;
@property (nonatomic, assign) float titleScale;
@property (nonatomic, assign) TitleColorTransformStyle titleTransformStyle;

//中间数据
@property (nonatomic, strong) NSMutableArray *titleLabelWidths;
@property (nonatomic, strong) NSMutableArray *titileLabels;
@property (nonatomic, assign) float titleLabelTotalWidth;
@property (nonatomic, assign) float titleSpace;
@property (nonatomic, assign) BOOL isReloadingData;


/**
 当前页面下标，从0开始
 */
@property (nonatomic, assign) int currentIndex;
@property (nonatomic, assign) int lastIndex;
@end

@implementation DSLinkageVC

@synthesize index = _index;

- (instancetype)initWithTitles:(NSArray *)titles vcs:(NSArray *)vcs {
    self = [super init];
    if (self) {
        self.titles = titles;
        self.vcs = vcs;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
    [self checkDataSource];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 懒加载
- (UIScrollView *)titleView {
    if (!_titleView) {
        _titleView = [[UIScrollView alloc] init];
        _titleView.bounces = NO;
        _titleView.clipsToBounds = NO;
        _titleView.backgroundColor = self.titleViewBgColor;
        [self.contentView addSubview:_titleView];
    }
    
    return _titleView;
}


- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        [self.view addSubview:_contentView];
    }
    
    return _contentView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [_contentView addSubview:_collectionView];
    }
    
    return _collectionView;
}


- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    
    return _flowLayout;
}

- (UIFont *)titileFont {
    if (!_titileFont) {
        _titileFont = [UIFont systemFontOfSize:15];
    }
    
    return _titileFont;
}

- (UIColor *)norColor {
    if (!_norColor) {
        _norColor = [UIColor blackColor];
    }
    
    return _norColor;
}

- (UIColor *)selColor {
    if (!_selColor) {
        _selColor = [UIColor redColor];
    }
    
    return _selColor;
}


- (float)titleScale {
    if (!_titleScale) {
        _titleScale = 1.0;
    }
    return _titleScale;
}


- (UIColor *)titleViewBgColor {
    if (!_titleViewBgColor) {
        _titleViewBgColor = [UIColor whiteColor];
    }
    return _titleViewBgColor;
}

- (int)index {
    return (int)_currentIndex;
}

#pragma mark - 设置方法
- (void)setTitleViewFrame:(CGRect)titleViewFrame {
    if (titleViewFrame.size.height == 0) return;
    _titleViewFrame = titleViewFrame;
    
}

- (void)setContentViewFrame:(CGRect)contentViewFrame {
    if (contentViewFrame.size.height == 0) return;
    _contentViewFrame = contentViewFrame;
}

- (void)setCurrentIndex:(int)currentIndex {
    _lastIndex = _isReloadingData ? 0 : _currentIndex;
    _currentIndex = currentIndex;
    [self didChangeIndex];
}


- (void)setIndex:(int)index {
    _index = index;
    [_collectionView setContentOffset:CGPointMake(_index * kViewWidth, 0) animated:NO];
}

#pragma mark - 界面样式
- (void)configView {
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.contentView.frame = _contentViewFrame.size.height > 0 ? _contentViewFrame : self.view.bounds;
    self.titleView.frame = _titleViewFrame.size.height > 0 ? _titleViewFrame : CGRectMake(0, 0, kViewWidth, 40);
    self.collectionView.frame = CGRectMake(0, CGRectGetMaxY(_titleView.frame), _contentView.frame.size.width, _contentView.frame.size.height - _titleView.frame.size.height);
    self.flowLayout.itemSize = _collectionView.frame.size;
    self.titleLabelWidths = [@[] mutableCopy];
    self.titileLabels = [@[] mutableCopy];
}


- (void)checkDataSource {
    if (_titles.count == 0 || _vcs.count == 0) return;
    
    if (_titles.count != _vcs.count) {
        NSUInteger count = MIN(_titles.count, _vcs.count);
        _titles = [_titles subarrayWithRange:NSMakeRange(0, count)];
        _vcs = [_vcs subarrayWithRange:NSMakeRange(0, count)];
    }
    [self refreshView];
}


- (void)refreshView {
    [self refreshTilteLables];
    [self refreshCollectionView];
    self.currentIndex = 0;
    self.isReloadingData = NO;
}


- (void)refreshTilteLables {
    if (_titleView.subviews.count > 0) {
        _titleLabelTotalWidth = 0.0;
        [_titileLabels removeAllObjects];
        [_titleLabelWidths removeAllObjects];
        [_titleView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    
    CGRect __block titleBounds = CGRectZero;
    [_titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *title = obj;
        DSLinkageLabel *titleLabel = [[DSLinkageLabel alloc] init];
        titleLabel.tag = idx;
        titleLabel.font = self.titileFont;
        titleLabel.textColor = self.norColor;
        titleLabel.text = title;
        [_titileLabels addObject:titleLabel];
        
        titleBounds = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.titileFont} context:nil];
        float titleLabelWidth = titleBounds.size.width + kTitleLabelSpace;
        [_titleLabelWidths addObject:@(titleLabelWidth)];
        _titleLabelTotalWidth += titleLabelWidth;
        [_titleView addSubview:titleLabel];
        
        UITapGestureRecognizer *tapGessure = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickTitleLabel:)];
        [titleLabel addGestureRecognizer:tapGessure];
    }];
    
    float __block lastX = 0.0;
    if (_titleLabelTotalWidth >= _titleView.bounds.size.width) {
        lastX = kTitleLabelSpace / 2.0;
        [_titileLabels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[DSLinkageLabel class]]) {
                DSLinkageLabel *titleLabel = obj;
                titleLabel.frame = CGRectMake(lastX, 0, [_titleLabelWidths[idx] floatValue], _titleView.bounds.size.height);
                lastX = CGRectGetMaxX(titleLabel.frame);
            }
        }];
        
        _titleView.contentSize = CGSizeMake(lastX + kTitleLabelSpace / 2.0, _titleView.bounds.size.height);
        
    } else {
        float additionWidth = (_titleView.bounds.size.width - _titleLabelTotalWidth) / _titles.count;
        [_titileLabels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[DSLinkageLabel class]]) {
                DSLinkageLabel *titleLabel = obj;
                titleLabel.frame = CGRectMake(lastX, 0, [_titleLabelWidths[idx] floatValue] + additionWidth, _titleView.bounds.size.height);
                lastX = CGRectGetMaxX(titleLabel.frame);
            }
        }];
        
        _titleView.contentSize = _titleView.bounds.size;
    }
}

- (void)refreshCollectionView {
    [_collectionView setContentOffset:CGPointZero animated:NO];
    _collectionView.contentSize = CGSizeMake(_vcs.count * kViewWidth, _collectionView.bounds.size.height);
    [_collectionView reloadData];
}


#pragma mark - 更改展示页面
- (void)didClickTitleLabel:(UITapGestureRecognizer *)tapGesture {
    DSLinkageLabel *titleLabel = (DSLinkageLabel *)tapGesture.view;
    [_collectionView setContentOffset:CGPointMake(titleLabel.tag * kViewWidth, 0) animated:NO];
}


- (void)didChangeIndex {
    DSLinkageLabel *lastTitleLabel = _titileLabels[_lastIndex];
    lastTitleLabel.font = self.titileFont;
    lastTitleLabel.textColor = self.norColor;
    lastTitleLabel.fillColor = self.norColor;
    
    DSLinkageLabel *titleLabel = _titileLabels[_currentIndex];
    titleLabel.font = [UIFont systemFontOfSize:(self.titileFont.pointSize * self.titleScale)];
    titleLabel.textColor = self.selColor;
    titleLabel.fillColor = self.selColor;
    
    
    if (_titleLabelTotalWidth > _titleView.bounds.size.width) {
        if (titleLabel.center.x > _titleView.bounds.size.width / 2.0) {
            
            if ((titleLabel.center.x + _titleView.bounds.size.width / 2.0) <= _titleView.contentSize.width) {
                [_titleView setContentOffset:CGPointMake(titleLabel.center.x - _titleView.bounds.size.width / 2.0, 0) animated:YES];
            } else {
                [_titleView setContentOffset:CGPointMake(_titleView.contentSize.width - _titleView.bounds.size.width, 0) animated:YES];
            }
            
        } else {
            [_titleView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
    
    
    if (_lastIndex == _currentIndex) return;
    
    
    [_vcs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (abs((int)idx - _currentIndex) > 1) {
            UIViewController *vc = obj;
            if (vc.view.superview != nil) {
                [vc.view removeFromSuperview];
                [vc removeFromParentViewController];
            }
        }
    }];
    
    [_collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:_currentIndex inSection:0]]];
}


- (void)changeWithTitles:(NSArray *)titles vcs:(NSArray *)vcs {
    if (titles.count == 0 || vcs.count == 0) return;
    if ([_titles isEqualToArray:titles] && [_vcs isEqualToArray:vcs]) return;
    
    _titles = titles;
    _vcs = vcs;
    _isReloadingData = YES;
    
    [self checkDataSource];
}

#pragma mark - 设置标题栏样式
- (void)setTitleViewWithBackgroundColor:(UIColor *)backgroundColor norColor:(UIColor *)norColor selColor:(UIColor *)selColor titleFont:(UIFont *)titleFont {
    _titleViewBgColor = backgroundColor;
    _norColor = norColor;
    _selColor = selColor;
    _titileFont = titleFont;
}

- (void)setTilteTransformWithStyle:(TitleColorTransformStyle)titleTransformStyle titleScale:(float)titleScale {
    _titleScale = titleScale;
    _titleTransformStyle = titleTransformStyle;
}


#pragma mark - 标题栏渐变样式
- (void)titleViewScaleWithWithPageOffetX:(CGFloat)pageOffsetX currentLabelScale:(float)currentLabelScale nextLabelScale:(float)nextLabelScale {
    DSLinkageLabel *currentLabel = _titileLabels[_currentIndex];
    DSLinkageLabel *nextLabel = _titileLabels[pageOffsetX > 0 ? _currentIndex + 1 : _currentIndex - 1];

    float nextFont = ((_titleScale - 1) * nextLabelScale + 1) * _titileFont.pointSize;
    nextLabel.font = [UIFont systemFontOfSize:nextFont];
    
    
    float currentFont = ((_titleScale - 1) * currentLabelScale + 1) * _titileFont.pointSize;
    currentLabel.font = [UIFont systemFontOfSize:currentFont];
}


- (void)titleViewColorChangeWithPageOffetX:(CGFloat)pageOffsetX currentLabelScale:(float)currentLabelScale nextLabelScale:(float)nextLabelScale {
    DSLinkageLabel *currentLabel = _titileLabels[_currentIndex];
    DSLinkageLabel *nextLabel = _titileLabels[pageOffsetX > 0 ? _currentIndex + 1 : _currentIndex - 1];
    
    if (self.titleTransformStyle == TitleColorTransformShiftLocation) {
        if (pageOffsetX > 0) {
            nextLabel.textColor = _norColor;
            nextLabel.fillColor = _selColor;
            nextLabel.progress = nextLabelScale;
            
            currentLabel.textColor = _selColor;
            currentLabel.fillColor = _norColor;
            currentLabel.progress = nextLabelScale;
            
        } else {
            nextLabel.textColor = _selColor;
            nextLabel.fillColor = _norColor;
            nextLabel.progress = currentLabelScale;
            
            currentLabel.textColor = _norColor;
            currentLabel.fillColor = _selColor;
            currentLabel.progress = currentLabelScale;
        }
    }
    
    
    if (self.titleTransformStyle == TitleColorTransformShiftColor) {
        CGFloat startRGB[3];
        [self getRGBComponents:startRGB forColor:_norColor];
        CGFloat startR = startRGB[0];
        CGFloat startG = startRGB[1];
        CGFloat startB = startRGB[2];
        
        CGFloat endRGB[3];
        [self getRGBComponents:endRGB forColor:_selColor];
        CGFloat endR = endRGB[0];
        CGFloat endG = endRGB[1];
        CGFloat endB = endRGB[2];
        
        CGFloat distanceR = endR - startR;
        CGFloat distanceG = endG - startG;
        CGFloat distanceB = endB - startB;
        
        
        currentLabel.textColor = [UIColor colorWithRed:(startR + currentLabelScale * distanceR) green:(startG + currentLabelScale * distanceG) blue:(startB + currentLabelScale * distanceB) alpha:1];
        nextLabel.textColor = [UIColor colorWithRed:(startR + nextLabelScale * distanceR) green:(startG + nextLabelScale * distanceG) blue:(startB + nextLabelScale * distanceB) alpha:1];
    }
}

#pragma mark - collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _vcs.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UIViewController *vc = _vcs[indexPath.row];
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(kViewWidth * indexPath.row, 0, kViewWidth, collectionView.bounds.size.height);
    [collectionView addSubview:vc.view];
    
    return cell;
}


#pragma mark - scrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView != _collectionView) return;
    
    float pageOffsetX = _collectionView.contentOffset.x - _currentIndex * kViewWidth;
    float absPageOffsetX = fabs(pageOffsetX);
    
    if (absPageOffsetX == 0) return;
    
    //直接点击的标题栏
    if (absPageOffsetX >= kViewWidth) {
        self.currentIndex = (_collectionView.contentOffset.x + kViewWidth / 2.0) / kViewWidth;
        return;
    }
    
    
    float nextLabelScale = absPageOffsetX / kViewWidth;
    float currentLabelScale = 1 - nextLabelScale;
    
    if (_titleTransformStyle != TitleColorTransformShiftNone) {
        [self titleViewColorChangeWithPageOffetX:pageOffsetX currentLabelScale:currentLabelScale nextLabelScale:nextLabelScale];
    }

    if (_titleScale > 1) {
        [self titleViewScaleWithWithPageOffetX:pageOffsetX currentLabelScale:currentLabelScale nextLabelScale:nextLabelScale];
    }


    if (nextLabelScale > 0.999) {
        self.currentIndex = (_collectionView.contentOffset.x + kViewWidth / 2.0) / kViewWidth;
    }
}



#pragma mark - 工具方法
/**
 *  指定颜色，获取颜色的RGB值
 *
 *  @param components RGB数组
 *  @param color      颜色
 */
- (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color {
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 rgbColorSpace,
                                                 1);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component] / 255.0f;
    }
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
