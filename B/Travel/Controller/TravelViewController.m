//
//  TravelViewController.m
//  B
//
//  Created by lanou on 15/10/27.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "TravelViewController.h"
#import "NetHandler.h"
#import "StoryDetailViewController.h"
#import "IndexModel.h"
#import "DataModel.h"
#import "DailyCell.h" //每日cell
#import "TravelMenuCell.h" //分类跳转 cell
#import "StoryListViewController.h"
#import "TravelListViewController.h"
#import "SpecialCell.h"
#import "SpecialViewController.h"
#import "MJRefresh.h"


@interface TravelViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *dailyArr; //每日精选数组
@property (nonatomic, strong)NSMutableArray *titleArr; //分类标题

@property (nonatomic, strong)NSMutableArray *specialArr; //专题
@property (nonatomic, strong)NSMutableArray *recommendArr; //推荐

@property (nonatomic, strong)UIActivityIndicatorView *acView;


@end

@implementation TravelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"首页";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.tableView];
    
    self.acView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
    self.acView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2 - 50);
    [self.view addSubview:self.acView];
    [self.acView startAnimating];

    
    [self setData];
    [self setupRefresh];
}

#pragma mark---  数据解析
- (void)setData{
    
    
    self.dailyArr = [NSMutableArray arrayWithCapacity:1];
    self.titleArr = [NSMutableArray arrayWithCapacity:1];
    self.specialArr = [NSMutableArray arrayWithCapacity:1];
    self.recommendArr = [NSMutableArray arrayWithCapacity:1];
    
    [NetHandler getDataWithUrl:@"http://api.breadtrip.com/v2/index" completion:^(NSData *data) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSArray *arr = rootDic[@"data"][@"elements"];
        
        for (NSDictionary *dic in arr) {
             if ([dic[@"type"] integerValue] != 1) {
                IndexModel *indexModel = [[IndexModel alloc] init];
                [indexModel setValuesForKeysWithDictionary:dic];
                
                NSInteger currentType = [dic[@"type"] integerValue];
                if (currentType == 10) { // 每日精选
                    [self.dailyArr addObject:indexModel];
                }else if(currentType == 5){ //专题
                    [self.specialArr addObject:indexModel];
                }else if(currentType == 7){
                    [self.recommendArr addObject:indexModel];
                }
            }
        }
        
        [self.acView stopAnimating];
        [self.acView removeFromSuperview];
        
        [self.tableView reloadData];
    }];
}

#pragma mark--- tabelView 的代理方法

// 分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

// 分区内行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return self.specialArr.count;
    }else if (section == 3){
        return self.recommendArr.count;
    }
    return 1;
}

// 加载单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        DailyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dailyCell"];
        if (cell == nil) {
            cell = [[DailyCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"dailyCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        [cell.meiButton addTarget:self action:@selector(storyButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [cell.riButton addTarget:self action:@selector(storyButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [cell.jingButton addTarget:self action:@selector(storyButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [cell.xuanButton addTarget:self action:@selector(storyButton:) forControlEvents:(UIControlEventTouchUpInside)];
        

        if (self.dailyArr.count != 0) {
            cell.modelArr = self.dailyArr;
        }
        
        return cell;
        
    }else if(indexPath.section == 1){
        TravelMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"travelCell"];
        if (cell == nil) {
            cell = [[TravelMenuCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"travelCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell.storyButton addTarget:self action:@selector(storyButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [cell.travelButton addTarget:self action:@selector(travelButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        return cell;
        
    }else if(indexPath.section == 2 || indexPath.section == 3){
        SpecialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"specialCell"];
        if (cell == nil) {
            cell = [[SpecialCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"specialCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        IndexModel *indexModel = indexPath.section == 2 ? self.specialArr[indexPath.row] : self.recommendArr[indexPath.row];
        cell.dataModel = indexModel.dataModel;
        cell.categaryName = indexPath.section == 2 ? @"专题" : @"推荐";
        
        return cell;
    }
    
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2 || indexPath.section == 3) {
        SpecialViewController *specialVC = [[SpecialViewController alloc] init];
        IndexModel *indexModel = indexPath.section == 2 ? self.specialArr[indexPath.row] : self.recommendArr[indexPath.row];
        specialVC.webURL = indexModel.dataModel.url;
        [self.navigationController pushViewController:specialVC animated:YES];
    }
}


#pragma mark--- travelMenu内button的点击时间
- (void)storyButtonAction:(UIButton *)button{
    StoryListViewController *storyListVC = [[StoryListViewController alloc] init];
    [self.navigationController pushViewController:storyListVC animated:YES];
}

- (void)travelButtonAction:(UIButton *) button{
    TravelListViewController *travelListVC = [[TravelListViewController alloc] init];
    [self.navigationController pushViewController:travelListVC animated:YES];
}



// 单元格行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.view.bounds.size.width / 2.7 * 2;
    }else if(indexPath.section == 1){
        return 80;
    }
    return 200;
}

// 每日精选的不同button点击跳转
- (void)storyButton:(UIButton *)button{
    
    StoryDetailViewController *storyDetailVC = [[StoryDetailViewController alloc] init];
    storyDetailVC.spot_id = button.tag;
    [self.navigationController pushViewController:storyDetailVC animated:YES];
    
}



#pragma mark --- 上拉刷新, 下拉加载
- (void)setupRefresh
{
    
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    //1. 在这调用请求网络数据方法（刷新数据）
    
    [self setData];
    //2. 几秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
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
