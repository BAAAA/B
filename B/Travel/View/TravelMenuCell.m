//
//  TravelMenuCell.m
//  B
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "TravelMenuCell.h"
#import "UIColor+AddColor.h"

@interface TravelMenuCell()


@end

@implementation TravelMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
        
        self.storyButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:self.storyButton];
        
        self.travelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.travelButton];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.storyButton.frame = CGRectMake(20, 10, self.bounds.size.width / 2 - 30, 60);
    
    [self.storyButton.layer setBorderWidth:5]; // 设置边框宽度
    self.storyButton.layer.cornerRadius = 10;
    
    [self.storyButton setTitle:@"精选故事" forState:(UIControlStateNormal)]; // button 上的字体设置
    self.storyButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    [self.storyButton setBackgroundColor:[UIColor anheiColor]];
    
    
    
    
    self.travelButton.frame = CGRectMake(self.bounds.size.width / 2 + 10, 10, self.storyButton.bounds.size.width, self.storyButton.bounds.size.height);
    [self.travelButton setBackgroundColor:[UIColor miganse]];
    
    [self.travelButton.layer setBorderWidth:5];
    self.travelButton.layer.cornerRadius = 10;
    
    [self.travelButton setTitle:@"精彩游记" forState:(UIControlStateNormal)];
    self.travelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];

    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
