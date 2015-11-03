//
//  PhotoViewController.m
//  B
//
//  Created by lanou on 15/10/30.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "PhotoViewController.h"
#import "TravelScrollView.h"

@interface PhotoViewController ()

@property (nonatomic, strong)TravelScrollView *photoView;
@property (nonatomic, assign)CGRect frame;


@end

@implementation PhotoViewController

- (void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.hidden = YES; //隐藏 navi
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.frame = self.tabBarController.tabBar.frame;
    
    self.photoView = [[TravelScrollView alloc] initWithFrame:(CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))];
    self.photoView.indexPath = self.indexPath;
    
    if (self.travelDays != nil) { // 游记传来的数据
        self.photoView.travelDays = self.travelDays;
    }
    if (self.storyDetailArr != nil) { 
        self.photoView.storyDetailArr = self.storyDetailArr;
    }
    
    [self.photoView.backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.photoView];
    
    self.tabBarController.tabBar.frame = CGRectMake(0, 0, 0, 0); //隐藏 tabBar;
    
    
}

#pragma mark--- 轮播图的按钮点击触发事件
- (void)backButtonAction:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = NO;  // 显示navi
    self.tabBarController.tabBar.frame = self.frame; // 显示 tabBar

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
