//
//  PhotoViewController.h
//  B
//
//  Created by lanou on 15/10/30.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController

@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, strong)NSMutableArray *travelDays;  // 用来接收游记传递来的图片数组
@property (nonatomic, strong)NSMutableArray *storyDetailArr; // 用于接收故事传递来的图片数组

@end
