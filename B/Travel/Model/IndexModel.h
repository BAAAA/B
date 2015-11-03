//
//  IndexModel.h
//  B
//
//  Created by lanou on 15/10/27.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DataModel;

@interface IndexModel : NSObject

@property (nonatomic, strong)DataModel *dataModel;
@property (nonatomic, strong)NSString *desc;
@property (nonatomic, assign)NSInteger type;

@end
