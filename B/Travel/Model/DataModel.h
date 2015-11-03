//
//  DataModel.h
//  B
//
//  Created by lanou on 15/10/27.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Author;

@interface DataModel : NSObject

@property (nonatomic, strong)NSString *title; 
@property (nonatomic, strong)NSString *index_title;
@property (nonatomic, strong)NSString *index_cover;
@property (nonatomic, strong)NSString *cover_image_w640;
@property (nonatomic, strong)NSString *cover_image;
@property (nonatomic, assign)NSInteger cover_image_height;
@property (nonatomic, assign)NSInteger cover_image_width;
@property (nonatomic, assign)NSInteger spot_id;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *first_day;
@property (nonatomic, strong)NSString *day_count;
@property (nonatomic, strong)NSString *view_count;
@property (nonatomic, strong)NSString *popular_place_str;
@property (nonatomic, assign)NSInteger travelId;
@property (nonatomic, strong)Author *author;



@property (nonatomic, strong)NSString *cover_title; // 专题 主题
@property (nonatomic, strong)NSString *cover_sub_title; //专题的子主题

//@property (nonatomic, strong)NSString *title;  // 推荐的主题
@property (nonatomic, strong)NSString *sub_title; // 推荐的 子主题

@property (nonatomic, strong)NSString *cover; // 专题和推荐 图片
@property (nonatomic, strong)NSString *url; // 专题和推荐 跳转网址


@end
