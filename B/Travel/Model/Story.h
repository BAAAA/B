//
//  Story.h
//  B
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import <Foundation/Foundation.h>
@class StoryDetail;

@interface Story : NSObject

@property (nonatomic, strong)NSString *cover_image;
@property (nonatomic, strong)NSString *text;
@property (nonatomic, strong)NSMutableArray *detailArr;


@end
