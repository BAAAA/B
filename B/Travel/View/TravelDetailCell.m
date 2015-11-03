//
//  TravelDetailCell.m
//  B
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "TravelDetailCell.h"
#import "UILabel+CustomLabel.h"
#import "UIImageView+WebCache.h"
#import "TravelDetail.h"
#import "UIColor+AddColor.h"

@interface TravelDetailCell()

@property (nonatomic, strong)UIImageView *photo;
@property (nonatomic, strong)UILabel *desLabel;
@property (nonatomic, strong)UIImageView *timeIcon;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UIImageView *placeIcon;
@property (nonatomic, strong)UILabel *placeLabel;


@property (nonatomic, strong)UIImageView *backView;

@end

@implementation TravelDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
        
        self.backView = [[UIImageView alloc] init];
        self.backView.backgroundColor = [UIColor huiseColor];
        [self.contentView addSubview:self.backView];
        
        self.photo = [[UIImageView alloc] init];
        [self.backView addSubview:self.photo];
        
        self.desLabel = [[UILabel alloc] initTextLabel];
        self.desLabel.textColor = [UIColor blackColor];
        self.desLabel.numberOfLines = 0;
        [self.backView addSubview:self.desLabel];
        
        self.timeIcon = [[UIImageView alloc] init];
        [self.backView addSubview:self.timeIcon];
        
        self.timeLabel = [[UILabel alloc] initTextLabel];
        self.timeLabel.textColor = [UIColor grayColor];
        [self.backView addSubview:self.timeLabel];
        
        self.placeIcon = [[UIImageView alloc] init];
        [self.backView addSubview:self.placeIcon];
        
        self.placeLabel = [[UILabel alloc] initTextLabel];
        self.placeLabel.textColor = [UIColor greenSeaColor];
        [self.backView addSubview:self.placeLabel];
    }
    return self;
}

- (void)setTravelDetail:(TravelDetail *)travelDetail{
    _travelDetail = travelDetail;
    
    
    self.backView.frame = CGRectMake(20, 10, [UIScreen mainScreen].bounds.size.width - 40, [TravelDetailCell heightOfCellWithDes:travelDetail.text photoWidth:travelDetail.photo_width photoHeight:travelDetail.photo_height photo:travelDetail.photo_webtrip] - 20);
    
    // 判断当图片不存在的时候
    if (![travelDetail.photo_webtrip isEqualToString:@""]) {
        //计算宽高比
        CGFloat photoHeight = 0.0;
        if (travelDetail.photo_width != 0 && travelDetail.photo_height != 0) {  //安全判断
            CGFloat proportion = (CGFloat)travelDetail.photo_height / (CGFloat)travelDetail.photo_width;
            photoHeight = proportion * ([UIScreen mainScreen].bounds.size.width - 40); // 按宽高比例
        }else{
            photoHeight = 1.5 * ([UIScreen mainScreen].bounds.size.width - 40);
        }
        self.photo.frame = CGRectMake(0, 0, self.backView.bounds.size.width, photoHeight);
        [self.photo sd_setImageWithURL:[NSURL URLWithString:travelDetail.photo_webtrip]];
        
    }else{
        
        self.photo.frame = CGRectMake(0, 0, 0, 0);
    }
    
    CGFloat desHeight = [TravelDetailCell heightOfString:travelDetail.text];
    self.desLabel.frame = CGRectMake(10, self.photo.frame.origin.y + self.photo.bounds.size.height, self.backView.bounds.size.width - 20, desHeight);
    self.desLabel.text = travelDetail.text;
    
    self.timeIcon.frame = CGRectMake(self.desLabel.frame.origin.x, self.desLabel.frame.origin.y + self.desLabel.bounds.size.height + 5, 15, 15);
    self.timeIcon.image = [UIImage imageNamed:@"time.png"];
    
    self.timeLabel.frame = CGRectMake(self.timeIcon.frame.origin.x + self.timeIcon.bounds.size.width + 5, self.timeIcon.frame.origin.y, 200, 15);
    self.timeLabel.text = [travelDetail.local_time substringFromIndex:5];
    
    
    // 判断当 没有地址参数的时候不显示
    CGFloat width = [TravelDetailCell widthOfString:travelDetail.poi_name];
    if (travelDetail.poi_name != nil && ![travelDetail.poi_name isEqualToString:@""]) {
        self.placeIcon.frame = CGRectMake(self.backView.bounds.size.width - width - 25, self.timeIcon.frame.origin.y, 15, 15);
        self.placeIcon.image = [UIImage imageNamed:@"locationfill.png"];
        self.placeLabel.frame = CGRectMake(self.backView.bounds.size.width - 10 - width, self.timeIcon.frame.origin.y, width, 15);
        self.placeLabel.text = travelDetail.poi_name;
    }else{
        
        // 为了解决 因单元格重用而图片在画面上显示  的问题
        self.placeIcon.frame = CGRectMake(self.backView.bounds.size.width - 20 - width - 20, self.timeIcon.frame.origin.y, 0, 0);
        self.placeLabel.frame = CGRectMake(self.backView.bounds.size.width - 20 - width, self.timeIcon.frame.origin.y, 0, 0);

    }
    
    
}


+ (CGFloat)heightOfString:(NSString *)str{
    if ([str isEqualToString:@""]) {
        return 0;
    }
    return [str boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, NSIntegerMax) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height + 30;
}

+ (CGFloat)widthOfString:(NSString *)str{
    return [str boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, NSIntegerMax) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.width;
}


+ (CGFloat)heightOfCellWithDes:(NSString *)str photoWidth:(NSInteger)photoWidth photoHeight:(NSInteger)photoHeight photo:(NSString *)photo{
    
    CGFloat photo_height = 0.0;
    if (![photo isEqualToString:@""]) {
        if (photoWidth != 0 && photoHeight != 0) {
            CGFloat proportion = (CGFloat) photoHeight / (CGFloat) photoWidth;
            photo_height = proportion * ([UIScreen mainScreen].bounds.size.width - 40);
        }else{
            photo_height = 1.5 * ([UIScreen mainScreen].bounds.size.width - 40);
        }
    }
    
    CGFloat height = [TravelDetailCell heightOfString:str];
    
    return height + photo_height + 50;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
