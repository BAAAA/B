//
//  TravelDetailViewController.m
//  B
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "TravelDetailViewController.h"
#import "NetHandler.h"
#import "TravelDetail.h"
#import "TravelDay.h"
#import "TravelTitle.h"
#import "TravelTitleCell.h"
#import "TravelDetailCell.h"
#import "TravelHeaderView.h"
#import "PhotoViewController.h"

@interface TravelDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)TravelTitle *travelTitle;
@property (nonatomic, strong)NSMutableArray *travelDays;

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIActivityIndicatorView *acView; // 菊花转

@property (nonatomic, strong)NSString *cover_image; // 记录主要展示的图片, 用于收藏
@property (nonatomic, strong)NSString *name;  //记录travel名字, 用于收藏
@property (nonatomic, strong)UIImage *favorImage; // 收藏按钮图片
@property (nonatomic, strong)UIBarButtonItem *favorItem; // 收藏按钮

@end

@implementation TravelDetailViewController

#pragma mark--- 当页面将要显示的时候, 处理收藏按钮的状态
- (void)viewWillAppear:(BOOL)animated{
    
    // 判断是否收藏 该故事, 确定收藏标识符的颜色(写在viewWillAppear, 防止从"我的"跳转过来的时候, 就是在详情页面, 数据不一致. 所以每次页面出现的时候,都判断一次)
    NSMutableArray *travelArr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"travelId"] mutableCopy];
    if ([travelArr containsObject:@(self.travelId)] ) {
        self.favorImage = [UIImage imageNamed:@"favorYellow.png"];
    }else{
        self.favorImage = [UIImage imageNamed:@"favorBlack.png"];
    }
    
    [self.favorItem setImage:[self.favorImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    
    self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    self.travelTitle = [[TravelTitle alloc] init];
    self.travelDays = [NSMutableArray arrayWithCapacity:1];
    
    
    self.acView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
    self.acView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2 - 50);
    [self.view addSubview:self.acView];
    [self.acView startAnimating];
    
    
    // 收藏按钮
    self.favorItem = [[UIBarButtonItem alloc] initWithTitle:nil style:(UIBarButtonItemStylePlain) target:self action:@selector(favorAction:)];
    self.navigationItem.rightBarButtonItem = self.favorItem;
    self.favorItem.enabled = NO;  // 一开始让收藏按钮不能点击, 等到数据加载完才能点击
    

    
    [self setData];
}

#pragma mark--- 收藏按钮处理
- (void)favorAction:(UIBarButtonItem *)bar{
    
    
    NSMutableArray *travelIdArr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"travelId"] mutableCopy];
    NSMutableArray *travelPhotoArr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"travelPhoto"] mutableCopy];
    NSMutableArray *travelTextArr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"travelText"] mutableCopy];
    NSMutableArray *travelPlaceArr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"travelPlace"] mutableCopy];
    
    
    if (travelIdArr == nil) {
        
        travelIdArr = [NSMutableArray arrayWithCapacity:1];
        travelPhotoArr = [NSMutableArray arrayWithCapacity:1];
        travelTextArr = [NSMutableArray arrayWithCapacity:1];
        travelPlaceArr = [NSMutableArray arrayWithCapacity:1];
        
        self.favorImage = [UIImage imageNamed:@"favorYellow.png"];
        [travelIdArr addObject:@(self.travelId)];
        [travelPhotoArr addObject:self.cover_image];
        [travelTextArr addObject:self.name];
        [travelPlaceArr addObject:self.place];
        
    }else{
        
        if ([travelIdArr containsObject:@(self.travelId)] ) {
            self.favorImage = [UIImage imageNamed:@"favorBlack.png"];
            [travelIdArr removeObject:@(self.travelId)];
            [travelPhotoArr removeObject:self.cover_image];
            [travelTextArr removeObject:self.name];
            [travelPlaceArr removeObject:self.place];
            
        }else{
            self.favorImage = [UIImage imageNamed:@"favorYellow.png"];
            [travelIdArr addObject:@(self.travelId)];
            [travelPhotoArr addObject:self.cover_image];
            [travelTextArr addObject:self.name];
            [travelPlaceArr addObject:self.place];
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:travelIdArr forKey:@"travelId"];
    [[NSUserDefaults standardUserDefaults] setObject:travelPhotoArr forKey:@"travelPhoto"];
    [[NSUserDefaults standardUserDefaults] setObject:travelTextArr forKey:@"travelText"];
    [[NSUserDefaults standardUserDefaults] setObject:travelPlaceArr forKey:@"travelPlace"];
    [self.navigationItem.rightBarButtonItem setImage:[self.favorImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
    
}



#pragma mark--- tableView 的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.travelDays.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   if (section != 0 && self.travelDays.count != 0) {
       TravelDay *travelDay = self.travelDays[section - 1];
       return travelDay.pointArr.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TravelTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"travelTitleCell"];
        if (cell == nil) {
            cell = [[TravelTitleCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"travelTitleCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.travelTitle = self.travelTitle;
        cell.place = self.place;
        return cell;
    }else{
        TravelDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"travelDetailCell"];
        if (cell == nil) {
            cell = [[TravelDetailCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"travelDetailCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        TravelDay *travelDay = self.travelDays[indexPath.section - 1];
        cell.travelDetail = travelDay.pointArr[indexPath.row];
        return cell;
    }
    return nil;
}

// 单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 0) {
        TravelDay *travelDay = self.travelDays[indexPath.section - 1];
        TravelDetail *detail = travelDay.pointArr[indexPath.row];
        return [TravelDetailCell heightOfCellWithDes:detail.text photoWidth:detail.photo_width photoHeight:detail.photo_height photo:detail.photo_webtrip];
    }
    return 250;
}

// 设置区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section != 0) {
        TravelHeaderView *headerView = [[TravelHeaderView alloc] init];
        TravelDay *travelDay = self.travelDays[section - 1];
        
        NSArray *arr = [travelDay.date componentsSeparatedByString:@"-"];
        NSString *date = [NSString stringWithFormat:@"%@月%@日", arr[1], arr[2]];
        
        headerView.day = [NSString stringWithFormat:@"第%ld天", section];
        headerView.date = date;
        return headerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section != 0) {
        return 60;
    }
    return 0;
}

// 单元格的点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 0) {
        
        PhotoViewController *photoVC = [[PhotoViewController alloc] init];
        photoVC.indexPath = indexPath;
        photoVC.travelDays = self.travelDays;
        [self.navigationController pushViewController:photoVC animated:YES];
        
    }
}

// 解析数据
- (void)setData{
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://api.breadtrip.com/trips/%ld/waypoints", self.travelId] completion:^(NSData *data) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        [self.travelTitle setValuesForKeysWithDictionary:rootDic];
        
        self.cover_image = rootDic[@"cover_image"];
        self.name = rootDic[@"name"];
        
        for (NSDictionary *dic in rootDic[@"days"]) {
            TravelDay *day = [[TravelDay alloc] init];
            [day setValuesForKeysWithDictionary:dic];
            [self.travelDays addObject:day];
        }
        
        [self.acView stopAnimating];
        [self.acView removeFromSuperview];
        
        [self.tableView reloadData];
        
        self.favorItem.enabled = YES; // 收藏按钮 处理成 可点击状态
    }];
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
