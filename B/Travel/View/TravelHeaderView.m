//
//  TravelHeaderView.m
//  B
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "TravelHeaderView.h"

@interface TravelHeaderView()

@property (nonatomic, strong)UIImageView *backView;
@property (nonatomic, strong)UILabel *dayLabel;
@property (nonatomic, strong)UILabel *dateLabel;

@end

@implementation TravelHeaderView

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
        
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
        
        self.backView = [[UIImageView alloc] initWithFrame:(CGRectMake(30, 0, 100, 80))];
        self.backView.image = [UIImage imageNamed:@"day.png"];
        [self addSubview:self.backView];
        
        self.dayLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, 15, 100, 30))];
        self.dayLabel.textAlignment = NSTextAlignmentCenter;
        self.dayLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.backView addSubview:self.dayLabel];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, 37, 100, 30))];
        self.dateLabel.textAlignment = NSTextAlignmentCenter;
        self.dateLabel.font = [UIFont systemFontOfSize:14];
        [self.backView addSubview:self.dateLabel];
        
    }
    return self;
}

- (void)setDate:(NSString *)date{
    _date = date;
    
    self.dateLabel.text = date;
}

- (void)setDay:(NSString *)day{
    _day = day;
    
    self.dayLabel.text = day;
    
}
@end
