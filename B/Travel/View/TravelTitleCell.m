//
//  TravelTitleCell.m
//  B
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "TravelTitleCell.h"
#import "UILabel+CustomLabel.h"
#import "UIImageView+WebCache.h"
#import "TravelTitle.h"
#import "Author.h"
#import "UIColor+AddColor.h"

@interface TravelTitleCell()

@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIImageView *nameIcon;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UIImageView *addressIcon;
@property (nonatomic, strong)UILabel *addressLabel;
@property (nonatomic, strong)UILabel *desLabel;


@property (nonatomic, strong)NSString *placeStr; // 为了页面加载的时候, 不是直接先显示地址, 而是等其他数据加载完后一同显示.  就先用nsstring接住传进来的值, 等和其他数据传进来的时候一同赋值


@end

@implementation TravelTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
        
        self.icon  = [[UIImageView alloc] init];
        [self.contentView addSubview:self.icon];
        
        self.titleLabel = [[UILabel alloc] initTitleLabel];
        [self.contentView addSubview:self.titleLabel];
        
        self.nameIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:self.nameIcon];
        
        self.nameLabel = [[UILabel alloc] initTextLabel];
        [self.contentView addSubview:self.nameLabel];
        
        self.addressIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:self.addressIcon];
        
        self.addressLabel = [[UILabel alloc] initTextLabel];
        self.addressLabel.textColor = [UIColor luse];
        [self.contentView addSubview:self.addressLabel];
        
        self.desLabel = [[UILabel alloc] initTextLabel];
        [self.contentView addSubview:self.desLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.icon.frame = CGRectMake(self.bounds.size.width / 2 - 25, 50, 50, 50);
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.cornerRadius = 25;
    
    self.titleLabel.frame = CGRectMake(10, self.icon.frame.origin.y + self.icon.bounds.size.height + 10, self.bounds.size.width - 20, 60);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 0;
    
    self.nameIcon.frame = CGRectMake(self.bounds.size.width / 2 + 35, self.titleLabel.frame.origin.y + self.titleLabel.bounds.size.height, 15, 15);
    self.nameLabel.frame = CGRectMake(self.nameIcon.frame.origin.x + self.nameIcon.bounds.size.width + 5, self.nameIcon.frame.origin.y, 120, 15);
    
    
    self.addressIcon.frame = CGRectMake(self.nameIcon.frame.origin.x, self.nameIcon.frame.origin.y +  20, 15, 15);
    self.addressLabel.frame = CGRectMake(self.addressIcon.frame.origin.x + self.addressIcon.bounds.size.width + 5, self.addressIcon.frame.origin.y, 120, 15);
    self.addressLabel.numberOfLines = 0;
    [self.addressLabel sizeToFit];
    
    self.desLabel.frame = CGRectMake(0, self.addressLabel.frame.origin.y + self.addressLabel.bounds.size.height + 10, self.bounds.size.width, 15);
    self.desLabel.textAlignment = NSTextAlignmentCenter;
    
}

- (void)setTravelTitle:(TravelTitle *)travelTitle{
    _travelTitle = travelTitle;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:travelTitle.author.authorPhoto]];
    self.titleLabel.text = travelTitle.name;
    
    if (travelTitle.author.authorName) {  // 判断, 使得当页面加载的过程, 不显示任何数据
        self.nameIcon.image = [UIImage imageNamed:@"author.png"];
        self.nameLabel.text = travelTitle.author.authorName;
    }
    
    
    if (![self.placeStr isEqualToString:@""] && self.place != nil) {   // 判断, 使得当页面加载的过程, 不显示任何数据
        self.addressIcon.image = [UIImage imageNamed:@"locationfill.png"];
        self.addressLabel.text = self.placeStr;
    }
    
    
    if (travelTitle.first_day|| travelTitle.day_count|| travelTitle.mileage|| travelTitle.recommendations) {   // 判断, 使得当页面加载的过程, 不显示任何数据
        self.desLabel.text = [NSString stringWithFormat:@"%@  %ld天   |   里程  %ldkm   |   喜欢  %@", travelTitle.first_day, travelTitle.day_count, travelTitle.mileage, travelTitle.recommendations];
    }
    
}

- (void)setPlace:(NSString *)place{
    _place = place;
    
    self.placeStr = place;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
