//
//  DDCycleScrollView.m
//  DDCycleScrollView
//
//  Created by ai on 2017/7/4.
//  Copyright © 2017年 ai. All rights reserved.
//

#import "DDCycleScrollView.h"

typedef NS_ENUM(NSUInteger, DDCellSource) {
    DDCellSourceFromClass,
    DDCellSourceFromNib,
    DDCellSourceNone
};

static NSString* const kCellClassIdentifier = @"DDCycleScrollViewClassCell";
static NSString* const kCellNibIdentifier = @"DDCycleScrollViewNibCell";


@interface DDCycleScrollView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, assign) Class cellClass;
@property (nonatomic, assign) DDCellSource cellSource;

@end



@implementation DDCycleScrollView

@synthesize pageControl = _pageControl;

- (instancetype)initWithFrame:(CGRect)frame autoScroll:(BOOL)autoScroll cellCount:(NSInteger)cellCount cellFromClass:(NSString*)className cellFromNib:(NSString*)nibName {
    self = [super initWithFrame:frame];
    if (self) {
        self.timeInterval = 4.0;
        self.cellCount = cellCount;
        self.autoScroll = autoScroll;
        self.showPageControl = YES;
        self.scrollEnabled = YES;
        [self setCycleViewReuseCellFromClass:className nibName:nibName];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame autoScroll:(BOOL)autoScroll cellCount:(NSInteger)cellCount cellFromClass:(NSString*)className {
    return [self initWithFrame:frame autoScroll:autoScroll cellCount:cellCount cellFromClass:className cellFromNib:nil];
}


- (instancetype)initWithFrame:(CGRect)frame autoScroll:(BOOL)autoScroll cellCount:(NSInteger)cellCount cellFromNib:(NSString*)nibName  {
    return [self initWithFrame:frame autoScroll:autoScroll cellCount:cellCount cellFromClass:nil cellFromNib:nibName];
}


#pragma mark - lazy
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        _collectionView.pagingEnabled = YES;
        _collectionView.scrollsToTop = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self addSubview:_collectionView];
    }
    return _collectionView;
}


- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 0.00;
        _flowLayout.itemSize = self.bounds.size;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}


- (void)setCellCount:(NSInteger)cellCount {
    if (_cellCount == cellCount) return;
    _cellCount = cellCount;
    [self reloadImages];
}


- (void)setAutoScroll:(BOOL)autoScroll {
    if (_autoScroll == autoScroll) return;
    _autoScroll = autoScroll;
    [self setUpTimer];
}


- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self reloadImages];
}


- (void)setShowPageControl:(BOOL)showPageControl {
    if (_showPageControl == showPageControl) return;
    _showPageControl = showPageControl;
    self.pageControl.hidden = !_showPageControl;
}

- (void)setPageControl:(SMPageControl *)pageControl {
    if (_pageControl == pageControl) return;
    
    if (_pageControl) {
        [_pageControl removeFromSuperview];
        _pageControl = nil;
    }
    
    
    _pageControl = pageControl;
    _pageControl.hidden = !_showPageControl;
    [self addSubview:_pageControl];
    
    _pageControl.numberOfPages = _cellCount;
    _pageControl.currentPage = [self getCurrentIndex];
}


- (SMPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[SMPageControl alloc] init];
        _pageControl.alignment = SMPageControlAlignmentCenter;
        _pageControl.numberOfPages = _cellCount;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.frame = CGRectMake(0, self.bounds.size.height - 20, self.bounds.size.width, 20);
        [self addSubview:_pageControl];
    }
    return _pageControl;
}



- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    if (_flowLayout.scrollDirection == scrollDirection) return;
    _scrollDirection = scrollDirection;
    _flowLayout.scrollDirection = _scrollDirection;
    [self reloadImages];
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    if (_timeInterval == timeInterval) return;
    _timeInterval = timeInterval;
    [self setUpTimer];
}

- (void)setScrollEnabled:(BOOL)scrollEnabled {
    if (_scrollEnabled == scrollEnabled) return;
    _scrollEnabled = scrollEnabled;
    self.collectionView.scrollEnabled = _scrollEnabled;
}

#pragma mark - actions
- (void)reloadImages {
    if (_cellCount == 0 || self.bounds.size.width == 0 || self.bounds.size.height == 0) {
        self.collectionView.hidden = YES;
        self.pageControl.numberOfPages = 0;
        self.autoScroll = NO;
        return;
    }
    
    
    if (_cellCount == 1) {
        self.collectionView.scrollEnabled = NO;
        self.autoScroll = NO;
    } else {
        self.collectionView.scrollEnabled = _scrollEnabled;
        self.autoScroll = YES;
    }
    
    
    self.collectionView.hidden = NO;
    self.totalCount = _cellCount * 1000;
    _pageControl.numberOfPages = _cellCount;
    _pageControl.currentPage = 0;
    _flowLayout.itemSize = self.bounds.size;
    self.collectionView.frame = self.bounds;
    
    CGPoint contentOffset = _flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal ? CGPointMake(_flowLayout.itemSize.width * _cellCount * 10, 0) : CGPointMake(0, _flowLayout.itemSize.height * _cellCount * 10);
    self.collectionView.contentOffset = contentOffset;
    [self.collectionView reloadData];
}


- (void)invalidateTimer {
    if (_timer) {
        dispatch_cancel(_timer);
        _timer = nil;
    }
}

- (NSInteger)getCurrentIndex {
    if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        return (self.collectionView.contentOffset.x + _flowLayout.itemSize.width * 0.5) / _flowLayout.itemSize.width;
    } else {
        return (self.collectionView.contentOffset.y + _flowLayout.itemSize.height * 0.5) / _flowLayout.itemSize.height;
    }
}

- (void)setUpTimer {
    [self invalidateTimer];
    if (_autoScroll) {
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, _timeInterval * NSEC_PER_SEC), _timeInterval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        
        __weak DDCycleScrollView *weakSelf = self;
        dispatch_source_set_event_handler(_timer, ^{
            if (_totalCount == 0) return;
            NSInteger targetIndex = [weakSelf getCurrentIndex] + 1;
            
            if (targetIndex >= _totalCount) {
                targetIndex = _totalCount * 0.5;
                [weakSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
            } else {
                [weakSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
            }
        });
        dispatch_resume(_timer);
    }
}


- (void)setCycleViewReuseCellFromClass:(NSString *)className nibName:(NSString *)nibName {
    if (className) {
        [self.collectionView registerClass:NSClassFromString(className) forCellWithReuseIdentifier:kCellClassIdentifier];
    } else if (nibName) {
        [self.collectionView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellWithReuseIdentifier:kCellNibIdentifier];
    }
    
    
    self.cellClass = className ?  NSClassFromString(className) : nibName ? NSClassFromString(nibName) : nil;
    self.cellSource = className ?  DDCellSourceFromClass : nibName ? DDCellSourceFromNib : DDCellSourceNone;
    [self reloadImages];
}

#pragma mark - collectionViewDataSourceAndDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _totalCount;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!_cellClass || (_cellSource == DDCellSourceNone)) return [[UICollectionViewCell alloc] init];
    
    UICollectionViewCell *cell;
    switch (_cellSource) {
        case DDCellSourceFromClass:
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellClassIdentifier forIndexPath:indexPath];
            break;
        case DDCellSourceFromNib:
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellNibIdentifier forIndexPath:indexPath];
            break;
        case DDCellSourceNone:
            break;
        default:
            break;
    }
    
    
    if (self.setCellData) {
        if ([cell isMemberOfClass:_cellClass]) {
            NSInteger pageControllerIndex = indexPath.row % _cellCount;
            self.setCellData(cell, pageControllerIndex);
        }
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_totalCount == 0 || _cellCount == 0) return;
    if (self.didClickCycleView) {
        NSInteger pageControllerIndex = indexPath.row % _cellCount;
        self.didClickCycleView(pageControllerIndex);
    }
}

#pragma mark - scrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self invalidateTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_autoScroll) {
        [self setUpTimer];
    }
    [self scrollViewDidEndScrollingAnimation:self.collectionView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    self.pageControl.currentPage = [self getCurrentIndex] % _cellCount;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
