//
//  UILabel+CustomLabel.m
//  B
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "UILabel+CustomLabel.h"
#import "UIColor+AddColor.h"

@implementation UILabel (CustomLabel)

- (instancetype)initTitleLabel{
    self = [super init];
    if (self) {
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:18];
        self.numberOfLines = 0;
    }
    return self;
}

- (instancetype)initTextLabel{
    self = [super init];
    if (self) {
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:14];
        self.numberOfLines = 0;
    }
    return self;
}

- (instancetype)initAuthorLabel{
    self = [super init];
    if (self) {
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:16];
        self.numberOfLines = 0;
    }
    return self;

}
- (instancetype)initAddressLabel{
    self = [super init];
    if (self) {
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:12];
        self.numberOfLines = 0;
    }
    return self;

}

@end
