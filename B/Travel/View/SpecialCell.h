//
//  SpecialCell.h
//  B
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataModel;

@interface SpecialCell : UITableViewCell

@property (nonatomic, strong)DataModel *dataModel;
@property (nonatomic, strong)NSString *categaryName;  // 分类名称

@end
