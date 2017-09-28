//
//  AICycleScrollView.m
//  AICycleScrollView
//
//  Created by ai on 2017/8/16.
//  Copyright © 2017年 ai. All rights reserved.
//

#import "AICycleScrollView.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

#define kItemWidth self.scrollView.bounds.size.width
#define kItemHeight self.scrollView.bounds.size.height

@interface AICycleScrollView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) AIImageView *overLeftView;
@property (nonatomic, strong) AIImageView *leftView;
@property (nonatomic, strong) AIImageView *centerView;
@property (nonatomic, strong) AIImageView *rightView;
@property (nonatomic, strong) AIImageView *overRightView;

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, strong) dispatch_source_t timer;
@end

@implementation AICycleScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configViews];
        self.autoScroll = YES;
        self.timeInterval = 4.0;
    }
    return self;
}


- (void)configViews {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.clipsToBounds = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
    self.overLeftView = [[AIImageView alloc] init];
    [self.scrollView addSubview:self.overLeftView];
    
    self.leftView = [[AIImageView alloc] init];
    [self.scrollView addSubview:self.leftView];
    
    self.centerView = [[AIImageView alloc] init];
    [self.scrollView addSubview:self.centerView];
    
    self.rightView = [[AIImageView alloc] init];
    [self.scrollView addSubview:self.rightView];
    
    self.overRightView = [[AIImageView alloc] init];
    [self.scrollView addSubview:self.overRightView];
    
    [self changeFrame];
    [self addTapAction];
}


- (void)addTapAction {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickScrollView:)];
    [self.scrollView addGestureRecognizer:tap];
}


- (void)clickScrollView:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:self.scrollView];
    NSInteger clickIndex;
    
    if (CGRectContainsPoint(self.leftView.frame, point)) {
        clickIndex = [self getCurrentIndex] == 1 ? _totalCount : [self getCurrentIndex] - 1;
    } else if (CGRectContainsPoint(self.rightView.frame, point)) {
        clickIndex = [self getCurrentIndex] == _totalCount ? 1 : [self getCurrentIndex] + 1;
    } else {
        clickIndex = [self getCurrentIndex];
    }
    
    
    if (self.didClickCycleView) {
        self.didClickCycleView(clickIndex);
    }
}



- (void)changeFrame {
    self.scrollView.frame = CGRectMake((self.bounds.size.width - _scrollViewSize.width) / 2.0, (self.bounds.size.height - _scrollViewSize.height) / 2.0, _scrollViewSize.width, _scrollViewSize.height);
    self.scrollView.contentSize = CGSizeMake(kItemWidth * 5, kItemHeight);
    [self.scrollView setContentOffset:CGPointMake(2 * kItemWidth, 0) animated:YES];
    
    self.overLeftView.frame = CGRectMake(0, 0, kItemWidth, kItemHeight);
    self.leftView.frame = CGRectMake(kItemWidth, 0, kItemWidth, kItemHeight);
    self.centerView.frame = CGRectMake(kItemWidth * 2, 0, kItemWidth, kItemHeight);
    self.rightView.frame = CGRectMake(kItemWidth * 3, 0, kItemWidth, kItemHeight);
    self.overRightView.frame = CGRectMake(kItemWidth * 4, 0, kItemWidth, kItemHeight);
}


- (void)changeCenterViewScale {
    self.centerView.imageView.transform = CGAffineTransformIdentity;
    
    CGFloat shrink = fabs(kItemHeight - _itemScaleHeight) / kItemHeight;
    self.overLeftView.imageView.transform = CGAffineTransformMakeScale(shrink,shrink);
    self.leftView.imageView.transform = CGAffineTransformMakeScale(shrink,shrink);
    self.rightView.imageView.transform = CGAffineTransformMakeScale(shrink,shrink);
    self.overRightView.imageView.transform = CGAffineTransformMakeScale(shrink,shrink);
}


- (NSInteger)getCurrentIndex {
    NSInteger currentOffsetIndex = (self.scrollView.contentOffset.x + self.scrollView.bounds.size.width * 0.5) / self.scrollView.bounds.size.width;
    if (currentOffsetIndex == 1) {
        return self.currentIndex == 1 ? self.totalCount : self.currentIndex - 1;
    } else if (currentOffsetIndex == 3) {
        return self.currentIndex == self.totalCount ? 1 : self.currentIndex + 1;
    } else {
        return self.currentIndex;
    }
}


- (void)refreshScrollView {
    self.currentIndex = [self getCurrentIndex];
    self.scrollView.contentOffset = CGPointMake(self.scrollView.bounds.size.width * 2, 0);
    [self changeCenterViewScale];
}


- (void)setTimeInterval:(CGFloat)timeInterval {
    if (_timeInterval == timeInterval) return;
    _timeInterval = timeInterval;
    [self startAutoScroll];
}


- (void)startAutoScroll {
    [self invalidTimer];
    if (!_autoScroll) return;
    
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, _timeInterval * NSEC_PER_SEC), _timeInterval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{
        [self.scrollView setContentOffset:CGPointMake(3 * kItemWidth, 0) animated:YES];
    });
    dispatch_resume(_timer);
}


- (void)invalidTimer {
    if (_timer) {
        dispatch_cancel(_timer);
        _timer = nil;
    }
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return CGRectContainsPoint(self.bounds, point) ? self.scrollView : [super hitTest:point withEvent:event];
}

#pragma mark - 属性观察
- (void)setScrollViewSize:(CGSize)scrollViewSize {
    _scrollViewSize = scrollViewSize;
    [self changeFrame];
}

- (void)setItemSpace:(CGFloat)itemSpace {
    if (_itemSpace == itemSpace) return;
    _itemSpace = itemSpace;
    
    self.overLeftView.itemSpace = _itemSpace;
    self.leftView.itemSpace = _itemSpace;
    self.centerView.itemSpace = _itemSpace;
    self.rightView.itemSpace = _itemSpace;
    self.overRightView.itemSpace = _itemSpace;
}

- (void)setItemScaleHeight:(CGFloat)itemScaleHeight {
    if (_itemScaleHeight == itemScaleHeight) return;
    _itemScaleHeight = itemScaleHeight;
    [self changeCenterViewScale];
}

- (void)setRecords:(NSArray *)records {
    if ([_records isEqualToArray:records]) return;
    _records = records;
    
    if (_records.count == 0) {
        self.scrollView.hidden = YES;
        return;
    }
    
    self.scrollView.hidden = NO;
    self.totalCount = _records.count;
    self.currentIndex = 1;
}


- (void)setCurrentIndex:(NSInteger)currentIndex {
    if (_currentIndex == currentIndex) return;
    
    _currentIndex = currentIndex;
    NSInteger leftIndex = _currentIndex > 1 ? _currentIndex - 1 : _totalCount;
    NSInteger overLeftIndex = leftIndex > 1 ? leftIndex - 1 : _totalCount;
    NSInteger rightIndex = _currentIndex == _totalCount ? 1 : (_currentIndex + 1);
    NSInteger overRightIndex = rightIndex == _totalCount ? 1 : (rightIndex + 1);
    
    self.leftView.dataDic = _records[leftIndex - 1];
    self.overLeftView.dataDic = _records[overLeftIndex - 1];
    self.centerView.dataDic = _records[_currentIndex - 1];
    self.rightView.dataDic = _records[rightIndex - 1];
    self.overRightView.dataDic = _records[overRightIndex - 1];
}

- (void)setAutoScroll:(BOOL)autoScroll {
    if (_autoScroll == autoScroll) return;
    _autoScroll = autoScroll;
    
    if (_autoScroll) {
        [self startAutoScroll];
    } else {
        [self invalidTimer];
    }
}


#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = self.scrollView.contentOffset.x;
    
    CGFloat shrinkRatio = fabs(offsetX - 2 * kItemWidth) / kItemWidth;
    CGFloat shrink = (kItemHeight - shrinkRatio * _itemScaleHeight) / kItemHeight;
    
    CGFloat enlargerRatio = 1 - shrinkRatio;
    CGFloat enlarger = (kItemHeight - enlargerRatio * _itemSpace) / kItemHeight;
    
    
    if (offsetX > 2 * kItemWidth) {
        self.centerView.imageView.transform = CGAffineTransformMakeScale(shrink, shrink);
        self.rightView.imageView.transform = CGAffineTransformMakeScale(enlarger, enlarger);
    } else {
        self.centerView.imageView.transform = CGAffineTransformMakeScale(shrink, shrink);
        self.leftView.imageView.transform = CGAffineTransformMakeScale(enlarger, enlarger);
    }
    
    
    if (shrinkRatio > 0.999) {
        [self refreshScrollView];
    }
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self invalidTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_autoScroll) {
        [self startAutoScroll];
    }
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end



@interface AIImageView ()


@end


@implementation AIImageView

#pragma mark - setter
- (void)setDataDic:(NSDictionary *)dataDic {
    if ([_dataDic isEqualToDictionary:dataDic]) return;
    _dataDic = dataDic;
    
    NSString *imageUrl = _dataDic[@"imgUrl"];
    if (imageUrl.length > 0) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    }
}


- (void)setItemSpace:(CGFloat)itemSpace {
    if (_itemSpace == itemSpace) return;
    _itemSpace = itemSpace;
    self.imageView.frame = CGRectMake(_itemSpace / 2.0, 0, self.bounds.size.width - _itemSpace, self.bounds.size.height);
}


#pragma mark - getter
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_imageView];
    }
    return _imageView;
}

@end



