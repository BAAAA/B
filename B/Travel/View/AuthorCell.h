//
//  AuthorCell.h
//  B
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Author;

@interface AuthorCell : UITableViewCell

@property (nonatomic, strong)Author *author;
@property (nonatomic, strong)NSString *storyTitle;

+ (CGFloat)heightOfCell:(NSString *)str;

@end
