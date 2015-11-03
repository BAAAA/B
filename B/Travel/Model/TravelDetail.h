//
//  TravelDetail.h
//  B
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelDetail : NSObject

@property (nonatomic, strong)NSString *text; // 描述
@property (nonatomic, assign)NSInteger recommendations;
@property (nonatomic, strong)NSString *photo_webtrip;
@property (nonatomic, strong)NSString *local_time;
@property (nonatomic, strong)NSString *cover_image;

@property (nonatomic, assign)NSInteger photo_height;
@property (nonatomic, assign)NSInteger photo_width;
@property (nonatomic, strong)NSString *poi_name;


@end
