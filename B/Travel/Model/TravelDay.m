//
//  TravelDay.m
//  B
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "TravelDay.h"
#import "TravelDetail.h"

@implementation TravelDay

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"waypoints"]) {
        self.pointArr = [NSMutableArray arrayWithCapacity:1];
        for (NSDictionary *dic in value) {
            TravelDetail *detail = [[TravelDetail alloc] init];
            [detail setValuesForKeysWithDictionary:dic];
            [self.pointArr addObject:detail];
        }
    }
}

- (void)setNilValueForKey:(NSString *)key{
    
}

@end
