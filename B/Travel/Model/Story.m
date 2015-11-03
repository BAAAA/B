//
//  Story.m
//  B
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "Story.h"
#import "StoryDetail.h"

@implementation Story

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
   
    if ([key isEqualToString:@"detail_list"]){
        
        self.detailArr = [NSMutableArray arrayWithCapacity:1];
        for (NSDictionary *dic in value) {
            if ([dic[@"type"] integerValue] == 1) {
                StoryDetail *storyDetail = [[StoryDetail alloc] init];
                [storyDetail setValuesForKeysWithDictionary:dic];
                [self.detailArr addObject:storyDetail];
            }
        }
    }
    
    
}

- (void)setNilValueForKey:(NSString *)key{
    
}


@end
