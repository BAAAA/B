//
//  Author.m
//  B
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "Author.h"

@implementation Author


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"name"]) {
        self.authorName = value;
    }
    if ([key isEqualToString:@"avatar_m"]) {
        self.authorPhoto = value;
    }
    if ([key isEqualToString:@"exprience"]) {
        self.authorLevel = [value[@"level_info"][@"value"] integerValue];
    }
    
}

- (void)setNilValueForKey:(NSString *)key{
    
}


@end
