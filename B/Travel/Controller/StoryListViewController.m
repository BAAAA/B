//
//  StoryListViewController.m
//  B
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "StoryListViewController.h"
#import "NetHandler.h"
#import "DataModel.h"
#import "StoryListCell.h"
#import "StoryDetailViewController.h"
#import "MJRefresh.h"
#import "StoryListView.h"

@interface StoryListViewController ()<UICollectionViewDelegate>

@property (nonatomic, strong)StoryListView *storyListView;
@property (nonatomic, assign)NSInteger nextCount;
@property (nonatomic, strong)UIActivityIndicatorView *acView;

@end

@implementation StoryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"精选故事";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    
    //storyListView
    self.storyListView = [[StoryListView alloc] initWithFrame:(CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))];
    self.storyListView.collectionView.delegate = self;
    [self.view addSubview:self.storyListView];
    
    
    self.storyArr = [NSMutableArray arrayWithCapacity:1];
    self.nextCount = 0;
    
    
    self.acView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
    self.acView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2 - 50);
    [self.view addSubview:self.acView];
    [self.acView startAnimating];
    
    // 区分数据是传进来的还是解析出来的
    if (self.storyArr.count == 0) {
        [self setData];
        [self setupRefresh];
    }
}

// collectionView 代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    StoryDetailViewController *detailVC = [[StoryDetailViewController alloc] init];
    DataModel *dataModel = self.storyArr[indexPath.item];
    detailVC.spot_id = dataModel.spot_id;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

// 解析数据
- (void)setData{
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://api.breadtrip.com/v2/new_trip/spot/hot/list?start=%ld", self.nextCount] completion:^(NSData *data) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSArray *arr = rootDic[@"data"][@"hot_spot_list"];
        self.nextCount += arr.count;
        for (NSDictionary *dic in arr) {
            DataModel *dataModel = [[DataModel alloc] init];
            [dataModel setValuesForKeysWithDictionary:dic];
            [self.storyArr addObject:dataModel];
        }
        [self.acView stopAnimating];
        [self.acView removeFromSuperview];
        
        self.storyListView.storyArr = self.storyArr;
    }];
}


#pragma mark --- 上拉刷新, 下拉加载
- (void)setupRefresh
{
    
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.storyListView.collectionView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    //进入刷新状态(一进入程序就下拉刷新)
    //[self.tableView headerBeginRefreshing];
    
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.storyListView.collectionView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    //1. 在这调用请求网络数据方法（刷新数据）
    
    [self setData];
    //2. 几秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.storyListView.collectionView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.storyListView.collectionView headerEndRefreshing];
    });
}

//   进入加载状态
- (void)footerRereshing
{
    //1. 拼接口等操作
    [self setData];
    
    // 请求加载数据
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.storyListView.collectionView reloadData];
        [self.storyListView.collectionView footerEndRefreshing];
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
