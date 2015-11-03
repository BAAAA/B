//
//  StoryDetailCell.h
//  B
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StoryDetail;

@interface StoryDetailCell : UITableViewCell

@property (nonatomic, strong)StoryDetail *storyDetail;

+ (CGFloat)heightOfCellWithText:(NSString *)str photoHeight:(NSInteger)photoHeight photoWidth:(NSInteger)photoWidth;

@end
