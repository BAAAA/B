//
//  StoryDetail.m
//  B
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "StoryDetail.h"

@implementation StoryDetail

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"text"]) {
        self.photo_text = value;
    }
}

- (void)setNilValueForKey:(NSString *)key{
    
}

@end
