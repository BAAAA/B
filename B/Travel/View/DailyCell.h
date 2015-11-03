//
//  DailyCell.h
//  B
//
//  Created by lanou on 15/10/27.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyCell : UITableViewCell

@property (nonatomic, strong)NSMutableArray *modelArr;

@property (nonatomic, strong)UIButton *meiButton;
@property (nonatomic, strong)UIButton *riButton;
@property (nonatomic, strong)UIButton *jingButton;
@property (nonatomic, strong)UIButton *xuanButton;

@property (nonatomic, strong)UIImageView *meiImageView;
@property (nonatomic, strong)UIImageView *riImageView;
@property (nonatomic, strong)UIImageView *jingImageView;
@property (nonatomic, strong)UIImageView *xuanImageView;


@end
