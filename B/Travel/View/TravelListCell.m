//
//  TravelListCell.m
//  B
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "TravelListCell.h"
#import "UILabel+CustomLabel.h"
#import "UIImageView+WebCache.h"
#import "IndexModel.h"
#import "DataModel.h"
#import "UIColor+AddColor.h"

@interface TravelListCell()

@property (nonatomic, strong)UIImageView *photo;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *dateLabel;
@property (nonatomic, strong)UILabel *addressLabel;

@end

@implementation TravelListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
        
        self.photo = [[UIImageView alloc] init];
        [self.contentView addSubview:self.photo];
        
        self.titleLabel = [[UILabel alloc] initTitleLabel];
        [self.contentView addSubview:self.titleLabel];
        
        self.dateLabel = [[UILabel alloc] initAddressLabel];
        [self.contentView addSubview:self.dateLabel];
        
        self.addressLabel = [[UILabel alloc] initAddressLabel];
        [self.contentView addSubview:self.addressLabel];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.photo.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.titleLabel.frame = CGRectMake(10, 10, self.bounds.size.width - 20, 30);
    self.titleLabel.layer.masksToBounds = YES;
    self.titleLabel.layer.cornerRadius = 3;
    [self.titleLabel sizeToFit];
    
    if (self.dateLabel.text != nil) {
        self.dateLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.bounds.size.height + 3, self.bounds.size.width - 10, 20);
        [self.dateLabel sizeToFit];
    }else{
        self.dateLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.bounds.size.height + 3, 0, 0);
    }
    
    self.addressLabel.frame = CGRectMake(self.dateLabel.frame.origin.x, self.dateLabel.frame.origin.y + self.dateLabel.bounds.size.height + 3, self.bounds.size.width - 10, 20);
    self.addressLabel.textColor = [UIColor luse];
    [self.addressLabel sizeToFit];
    
    self.titleLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.dateLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    self.addressLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
}

// indexModel 的传入
- (void)setDataModel:(DataModel *)dataModel{

    _dataModel = dataModel;
    
    [self.photo sd_setImageWithURL:[NSURL URLWithString:dataModel.cover_image]];
    
    NSString *title = [dataModel.index_title isEqualToString:@""] || dataModel.index_title == nil ? dataModel.name : dataModel.index_title;
    self.titleLabel.text = title;
    if (dataModel.first_day == nil || dataModel.day_count == nil || dataModel.view_count == nil) {
        self.dateLabel.text = nil;
    }else{
        self.dateLabel.text = [NSString stringWithFormat:@"%@ %@天 %@次浏览", dataModel.first_day, dataModel.day_count, dataModel.view_count];
    }
    self.addressLabel.text = dataModel.popular_place_str;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
