//
//  TravelDetail.m
//  B
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "TravelDetail.h"

@implementation TravelDetail

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"poi"]) {
        self.poi_name = value[@"name"];
    }
    if ([key isEqualToString:@"photo_info"]) {
        self.photo_height = [value[@"h"] integerValue];
        self.photo_width = [value[@"w"] integerValue];
    }
}

- (void)setNilValueForKey:(NSString *)key{
    
}

@end
