//
//  StoryListCell.m
//  B
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "StoryListCell.h"
#import "UILabel+CustomLabel.h"
#import "UIImageView+WebCache.h"
#import "DataModel.h"
#import "Author.h"

@interface StoryListCell()

@property (nonatomic, strong)UIImageView *photo; // 主要图片
@property (nonatomic, strong)UIImageView *authorPhoto; // 作者头像
@property (nonatomic, strong)UILabel *authorLabel;

@property (nonatomic, strong)UILabel *titleLabel; // 用来存放收藏的故事的简介

@end

@implementation StoryListCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
        
        self.photo = [[UIImageView alloc] init];
        [self.contentView addSubview:self.photo];
        self.titleLabel = [[UILabel alloc] initAddressLabel]; // 选12号字体
        [self.contentView addSubview:self.titleLabel];
        self.authorPhoto = [[UIImageView alloc] init];
        [self.contentView addSubview:self.authorPhoto];
        self.authorLabel = [[UILabel alloc] initAddressLabel];
        [self.contentView addSubview:self.authorLabel];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.photo.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    
    // 判断当无图片的情况下
    self.authorPhoto.frame = CGRectMake(8, self.photo.bounds.size.height - 22, 20, 20);
 
    
    self.authorLabel.frame = CGRectMake(self.authorPhoto.bounds.size.width + 15, self.authorPhoto.frame.origin.y, self.bounds.size.width -  self.authorPhoto.bounds.size.width * 2 - 16, 22);
    self.authorLabel.font = [UIFont boldSystemFontOfSize:13];
    
}

- (void)setDataModel:(DataModel *)dataModel{
    _dataModel = dataModel;
    
    NSString *str = [dataModel.index_cover isEqualToString:@""] || dataModel.index_cover == nil ? dataModel.cover_image : dataModel.index_cover;
    [self.photo sd_setImageWithURL:[NSURL URLWithString:str]];
    self.titleLabel.text = dataModel.index_title;
    [self.authorPhoto sd_setImageWithURL:[NSURL URLWithString:dataModel.author.authorPhoto]];
    self.authorPhoto.layer.masksToBounds = YES;
    self.authorPhoto.layer.cornerRadius = 10;
    self.authorLabel.text = dataModel.author.authorName;
    
    if(dataModel.title != nil){
        self.titleLabel.frame = CGRectMake(8, self.bounds.size.height - 30, self.bounds.size.width - 16, 30);
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.titleLabel.text = dataModel.title;
    }
    
}

@end
