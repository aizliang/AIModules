//
//  DDAddressPicker.m
//  省市区三级级联
//
//  Created by ai on 17/5/11.
//  Copyright © 2017年 ai. All rights reserved.
//

#import "DDAddressPicker.h"
#import "Masonry.h"

@interface DDAddressPicker()<UIPickerViewDelegate>
@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSArray *provinceArray;
@property (nonatomic, strong) NSArray *cityArray;
@property (nonatomic, strong) NSArray *areaArray;

@property (nonatomic, assign) NSInteger provinceIndex;
@property (nonatomic, assign) NSInteger cityIndex;
@property (nonatomic, assign) NSInteger areaIndex;

@property (nonatomic, copy) void (^selectAreaBlock)(NSString *province,NSString *cityString,NSString *areaString);
@end



@implementation DDAddressPicker

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    UIView *pickerBgView = [UIView new];
    [self addSubview:pickerBgView];
    [pickerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }]
    
    UIButton *selectButton = [UIButton new];
    [selectButton setTitle:@"选择" forState:UIControlStateNormal];
}


@end
