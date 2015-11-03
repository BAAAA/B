//
//  SpecialCell.m
//  B
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "SpecialCell.h"
#import "UILabel+CustomLabel.h"
#import "UIImageView+WebCache.h"
#import "UIColor+AddColor.h"
#import "DataModel.h"

@interface SpecialCell()

@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UILabel *categaryLabel;
@property (nonatomic, strong)UIImageView *backView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *sub_titleLabel;

@end

@implementation SpecialCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
        
        
        self.backView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.backView];
        
        self.icon = [[UIImageView alloc] init];
        [self.contentView addSubview:self.icon];
        
        self.categaryLabel = [[UILabel alloc] initTitleLabel];
        [self.icon addSubview:self.categaryLabel];

        self.titleLabel = [[UILabel alloc] initTitleLabel];
        [self.contentView addSubview:self.titleLabel];
        
        self.sub_titleLabel = [[UILabel alloc] initAuthorLabel];
        [self.contentView addSubview:self.sub_titleLabel];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.backView.frame = CGRectMake(10, 10, self.bounds.size.width - 20, self.bounds.size.width / 2);
    self.backView.alpha = 0.8;
    
    self.icon.frame = CGRectMake(20, 0, 80, 60);
    self.icon.image = [UIImage imageNamed:@"day.png"];
    
    self.categaryLabel.frame = CGRectMake(0, 15, self.icon.bounds.size.width - 5, 30);
    self.categaryLabel.textColor = [UIColor blackColor];
    self.categaryLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titleLabel.frame = CGRectMake(0, self.backView.bounds.size.height / 2, self.bounds.size.width, 30);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:25];

    self.sub_titleLabel.frame = CGRectMake(0, self.titleLabel.frame.origin.y + self.titleLabel.bounds.size.height + 5, self.bounds.size.width, 20);
    self.sub_titleLabel.textAlignment = NSTextAlignmentCenter;
    self.sub_titleLabel.font = [UIFont boldSystemFontOfSize:14];
}

- (void)setDataModel:(DataModel *)dataModel{
 
    _dataModel = dataModel;
    
    [self.backView sd_setImageWithURL:[NSURL URLWithString:dataModel.cover]];
    self.titleLabel.text = dataModel.title == nil ? dataModel.cover_title : dataModel.title;
    self.sub_titleLabel.text = dataModel.sub_title == nil ? dataModel.cover_sub_title : dataModel.sub_title;
}

- (void)setCategaryName:(NSString *)categaryName{
    _categaryName = categaryName;
    
    self.categaryLabel.text = categaryName;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
