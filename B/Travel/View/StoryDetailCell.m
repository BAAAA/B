//
//  StoryDetailCell.m
//  B
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "StoryDetailCell.h"
#import "UILabel+CustomLabel.h"
#import "UIImageView+WebCache.h"
#import "StoryDetail.h"

@interface StoryDetailCell()

@property (nonatomic, strong)UIImageView *photo;
@property (nonatomic, strong)UILabel *label;


@end

@implementation StoryDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
        
        self.photo = [[UIImageView alloc] init];
        [self.contentView addSubview:self.photo];
        
        self.label = [[UILabel alloc] initTextLabel];
        [self.contentView addSubview:self.label];
        
    }
    return self;
}

- (void)setStoryDetail:(StoryDetail *)storyDetail{
    _storyDetail = storyDetail;
    
    
    CGFloat photo_height = 0.0;
    if (storyDetail.photo_width != 0 && storyDetail.photo_height != 0) {  //安全判断
        CGFloat proportion = (CGFloat)storyDetail.photo_height / (CGFloat)storyDetail.photo_width; // 比例
        photo_height = proportion * ([UIScreen mainScreen].bounds.size.width - 40);
    }else{
        photo_height = 1.5 * ([UIScreen mainScreen].bounds.size.width - 40);
    }

    self.photo.frame = CGRectMake(20, 10, [UIScreen mainScreen].bounds.size.width - 40, photo_height);
    
    CGFloat height = [StoryDetailCell heightOfString:storyDetail.photo_text];
    self.label.frame = CGRectMake(self.photo.frame.origin.x, self.photo.frame.origin.y + self.photo.bounds.size.height, self.photo.bounds.size.width, height);
    
    
    [self.photo sd_setImageWithURL:[NSURL URLWithString:storyDetail.photo]];
    self.label.text = storyDetail.photo_text;

    
}

+ (CGFloat)heightOfString:(NSString *)str{
    if ([str isEqualToString:@""]) {
        return 0;
    }
    return [str boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, NSIntegerMax) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height + 10;
}

+ (CGFloat)heightOfCellWithText:(NSString *)str photoHeight:(NSInteger)photoHeight photoWidth:(NSInteger)photoWidth{
    
    CGFloat photo_height = 0.0;
    if (photoWidth != 0 && photoHeight != 0) {   // 比例
        CGFloat proportion = (CGFloat) photoHeight / (CGFloat) photoWidth;
        photo_height = proportion * ([UIScreen mainScreen].bounds.size.width - 40);
    }else{
        photo_height = 1.5 * ([UIScreen mainScreen].bounds.size.width - 40);
    }

    CGFloat height = [StoryDetailCell heightOfString:str];
    
    return height + photo_height + 20;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
