//
//  TravelListViewController.m
//  B
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "TravelListViewController.h"
#import "NetHandler.h"
#import "TravelDetailViewController.h"
#import "DataModel.h"
#import "TravelListView.h"
#import "MJRefresh.h"

@interface TravelListViewController ()<UITableViewDelegate>


@property (nonatomic, strong)NSMutableArray *travelArr;
@property (nonatomic, strong)NSNumber *next_start; // 用于下拉加载新的数据
@property (nonatomic, strong)TravelListView *travelListView;

@property (nonatomic, strong)UIActivityIndicatorView *acView;

@end

@implementation TravelListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"精彩游记";
    
    self.travelListView = [[TravelListView alloc] initWithFrame:(CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 50))];
    self.travelListView.tableView.delegate = self;
    [self.view addSubview:self.travelListView];
    
    
    
    self.travelArr = [NSMutableArray arrayWithCapacity:1];
    
    
    self.acView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
    self.acView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2 - 50);
    [self.view addSubview:self.acView];
    [self.acView startAnimating];
    
    
    [self setData];
    [self setupRefresh];
    
}

// 点击单元格触发事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TravelDetailViewController *detailVC = [[TravelDetailViewController alloc] init];
    
    DataModel *dataModel = self.travelArr[indexPath.row];
    detailVC.travelId = dataModel.travelId;
    detailVC.place = dataModel.popular_place_str;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

// 数据解析
- (void)setData{
    [NetHandler getDataWithUrl:@"http://api.breadtrip.com/v2/index" completion:^(NSData *data) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSArray *arr = rootDic[@"data"][@"elements"];
        self.next_start = rootDic[@"data"][@"next_start"];
        
        for (NSDictionary *dic in arr) {
           if ([dic[@"type"] integerValue] != 1) {
               
               DataModel *dataModel = [[DataModel alloc] init];
               [dataModel setValuesForKeysWithDictionary:dic[@"data"][0]];
               
                NSInteger currentType = [dic[@"type"] integerValue];
                if(currentType == 4){ // 热门游记
                    [self.travelArr addObject:dataModel];
                }
            }
        }
        
        [self.acView stopAnimating];
        [self.acView removeFromSuperview];
        
        self.travelListView.travelArr = self.travelArr;
    }];
}


// 下拉刷新的数据解析
- (void)setNextData{
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://api.breadtrip.com/v2/index/?next_start=%@", self.next_start] completion:^(NSData *data) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSArray *arr = rootDic[@"data"][@"elements"];
        self.next_start = rootDic[@"data"][@"next_start"];
        
        for (NSDictionary *dic in arr) {
            
            NSInteger currentType = [dic[@"type"] integerValue];
            
            if (currentType == 4) {
                
                DataModel *dataModel = [[DataModel alloc] init];
                [dataModel setValuesForKeysWithDictionary:dic[@"data"][0]];
                [self.travelArr addObject:dataModel];
            }
        }
        
        self.travelListView.travelArr = self.travelArr;
    }];
}


- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    
    [self.travelListView.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //进入刷新状态(一进入程序就下拉刷新)
    //[self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.travelListView.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    //1. 在这调用请求网络数据方法（刷新数据）
    [self setData];
    
    //2. 几秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.travelListView.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.travelListView.tableView headerEndRefreshing];
    });
}

//   进入加载状态
- (void)footerRereshing
{
    //1. 拼接口等操作
    [self setNextData];
    
    // 请求加载数据
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.travelListView.tableView reloadData];
        [self.travelListView.tableView footerEndRefreshing];
    });
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
