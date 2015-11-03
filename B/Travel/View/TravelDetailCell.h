//
//  TravelDetailCell.h
//  B
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TravelDetail;

@interface TravelDetailCell : UITableViewCell

@property (nonatomic, strong)TravelDetail *travelDetail;

+ (CGFloat)heightOfCellWithDes:(NSString *)str photoWidth:(NSInteger)photoWidth photoHeight:(NSInteger)photoHeight photo:(NSString *)photo;

@end
