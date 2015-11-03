//
//  TravelFavorViewController.m
//  B
//
//  Created by lanou on 15/11/2.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "TravelFavorViewController.h"
#import "TravelListView.h"
#import "DataModel.h"
#import "TravelDetailViewController.h"

@interface TravelFavorViewController ()<UITableViewDelegate>

@property (nonatomic, strong)TravelListView *travelListView;
@property (nonatomic, strong)UIActivityIndicatorView *acView;

@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation TravelFavorViewController


// 当在收藏的列表中取消收藏的话, 要重新判断listView 的列表
- (void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.title = @"游记收藏";
    
    NSArray *travelIdArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"travelId"];
    
    if (travelIdArr.count == 0) {  // 当收藏数为0 ,提示
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"该分类下暂无收藏" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
        self.dataArr = nil;
        self.travelListView.travelArr = self.dataArr;    // 数组置空, 保持列表显示的同一性
        
    }else if (travelIdArr.count != self.dataArr.count) {
        
        self.dataArr = [NSMutableArray arrayWithCapacity:1]; // 用于列表的数据
        
        // 菊花转
        self.acView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
        self.acView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2 - 50);
        [self.view addSubview:self.acView];
        [self.acView startAnimating];
        
        
        [self setData];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    
    self.travelListView = [[TravelListView alloc] initWithFrame:(CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 50))];
    self.travelListView.tableView.delegate = self;
    [self.view addSubview:self.travelListView];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *travelIdArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"travelId"];
    NSArray *travelPlaceArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"travelPlace"];
    
    TravelDetailViewController *travelDetailVC = [[TravelDetailViewController alloc] init];
    travelDetailVC.travelId = [travelIdArr[indexPath.item] integerValue];
    travelDetailVC.place = travelPlaceArr[indexPath.item];
    [self.navigationController pushViewController:travelDetailVC animated:YES];

}

// 获取数据
- (void)setData{
    
    NSArray *travelIdArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"travelId"];
    NSArray *travelPhotoArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"travelPhoto"];
    NSArray *travelTextArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"travelText"];
    NSArray *travelPlaceArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"travelPlace"];
    
    for (int i = 0; i < travelIdArr.count; i++) {
        
        DataModel *dataModel = [[DataModel alloc] init];
        dataModel.cover_image = travelPhotoArr[i];
        dataModel.name = travelTextArr[i];
        dataModel.popular_place_str = travelPlaceArr[i];
        [self.dataArr addObject:dataModel];
        
    }
    self.travelListView.travelArr = self.dataArr;
    [self.acView stopAnimating];
    [self.acView removeFromSuperview];
    
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
