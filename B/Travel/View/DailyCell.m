//
//  DailyCell.m
//  B
//
//  Created by lanou on 15/10/27.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "DailyCell.h"
#import "UIButton+WebCache.h"
#import "IndexModel.h"
#import "DataModel.h"

@interface DailyCell()

@end

@implementation DailyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
        
        self.meiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.meiButton];
        
        self.riButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.riButton];
        
        self.jingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.jingButton];
        
        self.xuanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.xuanButton];
        
        
        self.meiImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.meiImageView];
        
        self.riImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.riImageView];
        
        self.jingImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.jingImageView];
        
        self.xuanImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.xuanImageView];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.meiButton.frame = CGRectMake(0, 0, self.bounds.size.width / 2, self.bounds.size.width / 2.7);
    self.riButton.frame = CGRectMake(self.bounds.size.width / 2, 0, self.meiButton.bounds.size.width, self.meiButton.bounds.size.height);
    self.jingButton.frame = CGRectMake(0, self.meiButton.bounds.size.height, self.meiButton.bounds.size.width, self.meiButton.bounds.size.height);
    self.xuanButton.frame = CGRectMake(self.bounds.size.width / 2, self.meiButton.bounds.size.height, self.meiButton.bounds.size.width, self.meiButton.bounds.size.height);
    
    self.meiImageView.frame = self.meiButton.frame;
    self.meiImageView.image = [UIImage imageNamed:@"mei1.png"];
    self.meiImageView.alpha = 0.8;
    self.riImageView.frame = self.riButton.frame;
    self.riImageView.image = [UIImage imageNamed:@"ri1.png"];
    self.riImageView.alpha = 0.8;
    self.jingImageView.frame = self.jingButton.frame;
    self.jingImageView.image = [UIImage imageNamed:@"jing1.png"];
    self.jingImageView.alpha =  0.8;
    self.xuanImageView.frame = self.xuanButton.frame;
    self.xuanImageView.image = [UIImage imageNamed:@"xuan1.png"];
    self.xuanImageView.alpha = 0.8;
    
}

- (void)setModelArr:(NSMutableArray *)modelArr{
    _modelArr = [NSMutableArray arrayWithArray:modelArr];
    
    
    NSMutableArray *URLArr = [NSMutableArray arrayWithCapacity:1];
    NSMutableArray *tagArr = [NSMutableArray arrayWithCapacity:1];
    for (IndexModel *indexModel in modelArr) {
        DataModel *dataModel = indexModel.dataModel;
        [URLArr addObject:dataModel.cover_image];
        [tagArr addObject:[NSNumber numberWithInteger:dataModel.spot_id]];
        
    }
    
    //判断当图片不够, 补上空对象, 避免崩溃
    if (URLArr.count < 4) {
        NSInteger count = URLArr.count;
        for (int i = 1; i < 4 - count; i++) {
            URLArr[i + count] = @"";
        }
    }
    
    [self.meiButton sd_setBackgroundImageWithURL:[NSURL URLWithString:URLArr[0]] forState:(UIControlStateNormal)];
    [self.riButton sd_setBackgroundImageWithURL:[NSURL URLWithString:URLArr[1]] forState:(UIControlStateNormal)];
    [self.jingButton sd_setBackgroundImageWithURL:[NSURL URLWithString:URLArr[2]] forState:(UIControlStateNormal)];
    [self.xuanButton sd_setBackgroundImageWithURL:[NSURL URLWithString:URLArr[3]] forState:(UIControlStateNormal)];
    
    self.meiButton.tag = [tagArr[0] integerValue];
    self.riButton.tag = [tagArr[1] integerValue];
    self.jingButton.tag = [tagArr[2] integerValue];
    self.xuanButton.tag = [tagArr[3] integerValue];
    
    self.meiImageView.tag = self.meiButton.tag * 1000;
    self.riImageView.tag = self.riButton.tag * 1000;
    self.jingImageView.tag = self.jingButton.tag * 1000;
    self.xuanImageView.tag = self.xuanButton.tag * 1000;
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
