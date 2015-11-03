//
//  TravelTitle.h
//  B
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Author;

@interface TravelTitle : NSObject

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)Author *author;
@property (nonatomic, assign)NSInteger day_count;
@property (nonatomic, strong)NSString *last_day;
@property (nonatomic, strong)NSString *first_day;
@property (nonatomic, strong)NSString *recommendations; // 喜欢的人数
@property (nonatomic, assign)NSInteger mileage; //里程
@property (nonatomic, strong)NSString *city; //城市
@property (nonatomic, strong)NSString *country; //国家
@property (nonatomic, strong)NSArray *cities;

@end
