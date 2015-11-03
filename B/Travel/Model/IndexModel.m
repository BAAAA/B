//
//  IndexModel.m
//  B
//
//  Created by lanou on 15/10/27.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "IndexModel.h"
#import "DataModel.h"

@implementation IndexModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"data"]) {
        self.dataModel = [[DataModel alloc] init];
        NSDictionary *dic = value[0];
        [self.dataModel setValuesForKeysWithDictionary:dic];
    }
}

- (void)setNilValueForKey:(NSString *)key{
    
}

@end
