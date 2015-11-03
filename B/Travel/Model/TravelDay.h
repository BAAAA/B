//
//  TravelDay.h
//  B
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelDay : NSObject

@property (nonatomic, strong)NSString *cover_image;
@property (nonatomic, strong)NSString *date; // 游玩日期
@property (nonatomic, assign)NSInteger day; // 游玩的第几天

@property (nonatomic, strong)NSMutableArray *pointArr;

@end
