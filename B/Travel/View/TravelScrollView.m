//
//  TravelScrollView.m
//  B
//
//  Created by lanou on 15/10/30.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "TravelScrollView.h"
#import "UILabel+CustomLabel.h"
#import "UIImageView+WebCache.h"
#import "TravelDetail.h"
#import "TravelDay.h"
#import "StoryDetail.h"
#import "UIColor+AddColor.h"

@interface TravelScrollView()<UIScrollViewDelegate>

@property (nonatomic, strong)UILabel *dayLabel;  // 第几天
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIImageView *photo;
@property (nonatomic, strong)UILabel *desLabel;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UIImageView *timeIcon;
@property (nonatomic, strong)UILabel *addressLabel;
@property (nonatomic, strong)UIImageView *addressIcon;


@property (nonatomic, strong)NSMutableArray *photoArr;
@property (nonatomic, strong)NSMutableArray *photo_widthArr;
@property (nonatomic, strong)NSMutableArray *photo_heightArr;
@property (nonatomic, strong)NSMutableArray *desArr;
@property (nonatomic, strong)NSMutableArray *timeArr;
@property (nonatomic, strong)NSMutableArray *addressArr;
@property (nonatomic, assign)NSInteger scrollWidth;

@property (nonatomic, assign)BOOL isFirst;

@end

@implementation TravelScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        self.scrollView.contentOffset = CGPointMake(0, 0);
        [self addSubview:self.scrollView];
        
        self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.backButton];
        
        self.dayLabel = [[UILabel alloc] initTitleLabel];
        self.dayLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self addSubview:self.dayLabel];
        
        self.desLabel = [[UILabel alloc] initTextLabel];
        self.desLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self addSubview:self.desLabel];
        
        self.timeIcon = [[UIImageView alloc] init];
        [self addSubview:self.timeIcon];
        self.timeLabel = [[UILabel alloc] initTextLabel];
        self.timeLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self addSubview:self.timeLabel];
        
        self.addressIcon = [[UIImageView alloc] init];
        [self addSubview:self.addressIcon];
        self.addressLabel = [[UILabel alloc] initTextLabel];
        self.addressLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self addSubview:self.addressLabel];
        
        
        
        self.photo_widthArr = [NSMutableArray arrayWithCapacity:1];
        self.photo_heightArr = [NSMutableArray arrayWithCapacity:1];
        self.photoArr = [NSMutableArray arrayWithCapacity:1];
        self.desArr = [NSMutableArray arrayWithCapacity:1];
        self.timeArr = [NSMutableArray arrayWithCapacity:1];
        self.addressArr = [NSMutableArray arrayWithCapacity:1];
        
        
        self.photo = [[UIImageView alloc] init];
        [self.scrollView addSubview:self.photo];
        
        self.isFirst = YES;
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.backButton.frame = CGRectMake(20, 20, 40, 40);
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:(UIControlStateNormal)];
    
    self.dayLabel.frame = CGRectMake(100, 30, self.bounds.size.width - 200, 20);
    self.dayLabel.textAlignment = NSTextAlignmentCenter;
    self.dayLabel.font = [UIFont systemFontOfSize:22];
    
    self.timeIcon.frame = CGRectMake(20, self.bounds.size.height - 50, 15, 15);
    self.timeIcon.image = [UIImage imageNamed:@"time.png"];
    self.timeLabel.frame = CGRectMake(self.timeIcon.frame.origin.x + self.timeIcon.bounds.size.width + 5, self.bounds.size.height - 50, 150, 15);
    
  
    if (![self.addressLabel.text isEqualToString:@""]) {
        self.addressIcon.frame = CGRectMake(self.timeIcon.frame.origin.x, self.timeIcon.frame.origin.y + self.timeIcon.bounds.size.height + 5, 15, 15);
        self.addressIcon.image = [UIImage imageNamed:@"locationfill.png"];
    }else{
        self.addressIcon.frame = CGRectMake(self.timeIcon.frame.origin.x, self.timeIcon.frame.origin.y + self.timeIcon.bounds.size.height + 5, 0 ,0);
    }
   
   
    
    self.addressLabel.frame = CGRectMake(self.addressIcon.frame.origin.x + self.addressIcon.bounds.size.width + 5, self.addressIcon.frame.origin.y, self.bounds.size.width - 40, 15);
    self.addressLabel.textColor = [UIColor luse];
    
    self.desLabel.frame = CGRectMake(20, self.timeLabel.frame.origin.y - 55, self.bounds.size.width - 40, 55);
    self.desLabel.numberOfLines = 0;
    
    
  
}

- (void)setTravelDays:(NSMutableArray *)travelDays{
    _travelDays = [NSMutableArray arrayWithArray:travelDays];
    
    self.scrollWidth = 0.0;
    
    for (int j = 0; j < travelDays.count; j++) {
        
        TravelDay *travelDay = travelDays[j];
        
        for (int i = 0; i < travelDay.pointArr.count; i++) {
            
            TravelDetail *detail = travelDay.pointArr[i];
            
            detail.text = detail.text == nil ? @"" : detail.text;
            detail.poi_name = detail.poi_name == nil ? @"" : detail.poi_name;
            detail.local_time = detail.local_time == nil ? @"" : detail.local_time;
            detail.photo_webtrip = detail.photo_webtrip == nil ? @"" : detail.photo_webtrip;
            
            if (![detail.photo_webtrip isEqualToString:@""]) {
                [self.photoArr addObject:detail.photo_webtrip];
                [self.photo_heightArr addObject:@(detail.photo_height)];
                [self.photo_widthArr addObject:@(detail.photo_width)];
                [self.desArr addObject:detail.text];
                [self.addressArr addObject:detail.poi_name];
                [self.timeArr addObject:detail.local_time];
                self.scrollWidth += self.bounds.size.width;
            }

        }
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollWidth, self.scrollView.bounds.size.height - 20);
    
    
    // 计算点击进来的是哪一页
    int currentPage = 0;
    int nilCount = 0;
    
    //判断当前传入的数据所在的数组下 是否存在图片为nil的情况
    TravelDay *travelDay = travelDays[self.indexPath.section - 1];
    NSArray *arr = travelDay.pointArr;
    for (int i = 0; i < self.indexPath.row; i++) {
        TravelDetail *detail = arr[i];
        if ([detail.photo_webtrip isEqualToString:@""]) {
            nilCount ++;
        }
    }
    
    // 判断当前传入的数据 的之前数组中是否含有图片为nil的情况
    for (int i = 0; i < self.indexPath.section - 1; i++) {
        TravelDay *travelDay = travelDays[i];
        
        for (TravelDetail *detail in travelDay.pointArr) {
            if ([detail.photo_webtrip isEqualToString:@""]) {
                nilCount ++;
            }
        }
        
        currentPage += travelDay.pointArr.count;
    }
    currentPage = currentPage + (int )self.indexPath.row - nilCount;
    [self setDataWithCurrentPage:currentPage];
    
    self.scrollView.contentOffset = CGPointMake(currentPage * self.bounds.size.width, 0);
    
}

- (void)setStoryDetailArr:(NSMutableArray *)storyDetailArr{
    _storyDetailArr = [NSMutableArray arrayWithArray:storyDetailArr];
    
    self.scrollWidth = 0.0;
    
    for (int j = 0; j < storyDetailArr.count; j++) {
        
        StoryDetail *detail = storyDetailArr[j];
        
        detail.photo_text = detail.photo_text == nil ? @"" : detail.photo_text;
        detail.photo = detail.photo == nil ? @"" : detail.photo;
    
        if (![detail.photo isEqualToString:@""] && detail.photo != nil) {
            [self.desArr addObject:detail.photo_text];
            [self.photoArr addObject:detail.photo];
            [self.photo_heightArr addObject:@(detail.photo_height)];
            [self.photo_widthArr addObject:@(detail.photo_width)];
            self.scrollWidth += self.bounds.size.width;
        }
            
    }

    self.scrollView.contentSize = CGSizeMake(self.scrollWidth, self.scrollView.bounds.size.height - 20);
    
    
    // 计算点击进来的是哪一页
    int currentPage = 0;
    int nilCount = 0;
    
    // 判断当前传入的数据 的之前数组中是否含有图片为nil的情况
    for (int i = 0; i < self.indexPath.row; i++) {
        for (StoryDetail *detail in storyDetailArr) {
            if ([detail.photo isEqualToString:@""]) {
                nilCount ++;
            }
        }
    }
    currentPage = (int)self.indexPath.row - nilCount - 1;
    [self setDataWithCurrentPage:currentPage];
    
    self.scrollView.contentOffset = CGPointMake(currentPage * self.bounds.size.width, 0);
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int currentPage = self.scrollView.contentOffset.x / self.scrollView.bounds.size.width;
    [self setDataWithCurrentPage:currentPage];
    
}

// 加载页面数据
- (void)setDataWithCurrentPage:(int)currentPage{
    
    int photoCount = (int)self.scrollWidth / self.bounds.size.width;
    
    CGFloat proportion = [self.photo_heightArr[currentPage] floatValue] / [self.photo_widthArr[currentPage] floatValue];
    CGFloat height = proportion * self.scrollView.bounds.size.width;
    self.photo.frame = CGRectMake(0 + (currentPage * self.scrollView.bounds.size.width), self.scrollView.bounds.size.height / 2.3 - height / 2, self.scrollView.bounds.size.width, height);
    [self.photo sd_setImageWithURL:[NSURL URLWithString:self.photoArr[currentPage]]];

    
    if (self.desArr.count != 0 && self.desArr != nil) {
        self.desLabel.text = self.desArr[currentPage];
        
    }
    if (self.timeArr.count != 0 && self.timeArr != nil) {
        
        self.timeIcon.hidden = NO;
        self.timeLabel.text = self.timeArr[currentPage];
    }else{
        self.timeIcon.hidden = YES;
    }
    
    
    if (self.addressArr.count != 0 && self.addressArr != nil) {
        
        self.addressIcon.hidden = NO;
        self.addressLabel.text = self.addressArr[currentPage];
        
        // 判断当无 地址 这一参数的时候, 地址的图标不显示
        CGRect temp = self.addressIcon.bounds;
        if ([self.addressArr[currentPage] isEqualToString:@""]) {
            temp.size = CGSizeMake(0, 0);
        }else{
            temp.size = CGSizeMake(15, 15);
        }
        self.addressIcon.bounds = temp;
        
    }else{
        self.addressIcon.hidden = YES;
    }
    

    self.dayLabel.text = [NSString stringWithFormat:@"%d/%d", currentPage + 1, photoCount];
    
    
}

+ (CGFloat)heightOfString:(NSString *)str{
    return [str boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, NSIntegerMax) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
}


@end
