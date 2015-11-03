//
//  DataModel.m
//  B
//
//  Created by lanou on 15/10/27.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "DataModel.h"
#import "Author.h"

@implementation DataModel



- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"user"]) {
        self.author = [[Author alloc] init];
        [self.author setValuesForKeysWithDictionary:value];
    }
    if ([key isEqualToString:@"id"]) {
        self.travelId = [value integerValue];
    }
    
}

- (void)setNilValueForKey:(NSString *)key{
    
}

@end
