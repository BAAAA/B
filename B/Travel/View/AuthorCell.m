//
//  AuthorCell.m
//  B
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "AuthorCell.h"
#import "UILabel+CustomLabel.h"
#import "Story.h"
#import "Author.h"
#import "UIImageView+WebCache.h"

@interface AuthorCell()

@property (nonatomic, strong)UILabel *title; //标题
@property (nonatomic, strong)UIImageView *authorPhoto;
@property (nonatomic, strong)UILabel *authorName;

@property (nonatomic, assign)CGFloat nameX; // 作者名的自适应
@property (nonatomic, assign)CGFloat nameWidth; // 作者名的自适应

@end

@implementation AuthorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
        
        self.title = [[UILabel alloc] initAuthorLabel];
        [self.contentView addSubview:self.title];
        
        self.authorPhoto = [[UIImageView alloc] init];
        [self.contentView addSubview:self.authorPhoto];
        
        self.authorName = [[UILabel alloc] initAuthorLabel];
        [self.contentView addSubview:self.authorName];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.title.frame = CGRectMake(30, 20, self.bounds.size.width - 50, 30);
    [self.title sizeToFit];
    
    self.authorPhoto.frame = CGRectMake(self.nameX - 10 - 50, self.title.frame.origin.y + self.title.bounds.size.height + 15, 50, 50);
    self.authorPhoto.layer.masksToBounds = YES;
    self.authorPhoto.layer.cornerRadius = 25;
    
    
    self.authorName.frame = CGRectMake(self.nameX, self.authorPhoto.frame.origin.y + 10, self.nameWidth, 30);
    
}


- (void)setAuthor:(Author *)author{
    _author = author;
    
    [self.authorPhoto sd_setImageWithURL:[NSURL URLWithString:author.authorPhoto]];
    self.authorName.text = author.authorName;
    
    
    self.nameWidth = [AuthorCell sizeOfString:author.authorName].width;
    self.nameX = [UIScreen mainScreen].bounds.size.width - self.nameWidth - 30;

    
}

- (void)setStoryTitle:(NSString *)storyTitle{
    _storyTitle = storyTitle;
    
    self.title.text = storyTitle;
}

+ (CGSize)sizeOfString:(NSString *)str{
    return [str boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 50, NSIntegerMax) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
}

+ (CGFloat)heightOfCell:(NSString *)str{
    CGFloat height = [AuthorCell sizeOfString:str].height;
    return height + 90;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
