//
//  TravelScrollView.h
//  B
//
//  Created by lanou on 15/10/30.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelScrollView : UIView

@property (nonatomic, strong)NSMutableArray *travelDays;
@property (nonatomic, strong)UIButton *backButton; // 返回按钮
@property (nonatomic, strong)NSIndexPath *indexPath;

@property (nonatomic, strong)NSMutableArray *storyDetailArr;

@end
