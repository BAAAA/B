//
//  TravelTitle.m
//  B
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "TravelTitle.h"
#import "Author.h"
#import "TravelDay.h"

@implementation TravelTitle


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"user"]) {
        self.author = [[Author alloc] init];
        [self.author setValuesForKeysWithDictionary:value];
    }
}

- (void)setNilValueForKey:(NSString *)key{
    
}
@end
