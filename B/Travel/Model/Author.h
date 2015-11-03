//
//  Author.h
//  B
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Author : NSObject

@property (nonatomic, strong)NSString *authorName;
@property (nonatomic, strong)NSString *authorPhoto; // 作者头像
@property (nonatomic, assign)NSInteger authorLevel; // 作者等级

@end
