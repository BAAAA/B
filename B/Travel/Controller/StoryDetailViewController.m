//
//  StoryDetailViewController.m
//  B
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "StoryDetailViewController.h"
#import "NetHandler.h"
#import "Story.h"
#import "Author.h"
#import "StoryDetail.h"
#import "StoryDetailCell.h"
#import "AuthorCell.h"
#import "PhotoViewController.h"

@interface StoryDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)Story *story;
@property (nonatomic, strong)Author *author;

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIActivityIndicatorView *acView;

@property (nonatomic, strong)UIImage *favorImage;
@property (nonatomic, strong)UIBarButtonItem *favorItem; // 收藏按钮

@end

@implementation StoryDetailViewController

#pragma mark--- 当页面将要显示的时候, 处理收藏按钮的状态
- (void)viewWillAppear:(BOOL)animated{
    
    // 判断是否收藏 该故事, 确定收藏标识符的颜色(写在viewWillAppear, 防止从"我的"跳转过来的时候, 就是在详情页面, 数据不一致. 所以每次页面出现的时候,都判断一次)
    NSMutableArray *storyArr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"storyId"] mutableCopy];
    if ([storyArr containsObject:@(self.spot_id)] ) {
        self.favorImage = [UIImage imageNamed:@"favorYellow.png"];
    }else{
        self.favorImage = [UIImage imageNamed:@"favorBlack.png"];
    }
    
    [self.favorItem setImage:[self.favorImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"故事详情";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    
    self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    
    
    // 菊花转
    self.acView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
    self.acView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2 - 50);
    [self.view addSubview:self.acView];
    [self.acView startAnimating];

    
    self.favorItem = [[UIBarButtonItem alloc] initWithTitle:nil style:(UIBarButtonItemStylePlain) target:self action:@selector(favorAction:)];
    self.navigationItem.rightBarButtonItem = self.favorItem;
    self.favorItem.enabled = NO;  // 一开始让收藏按钮不能点击, 等到数据加载完才能点击
    
    
    [self setData];
    
}

#pragma mark--- 收藏按钮处理
- (void)favorAction:(UIBarButtonItem *)bar{
    
    
    NSMutableArray *storyIdArr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"storyId"] mutableCopy];
    NSMutableArray *storyPhotoArr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"storyPhoto"] mutableCopy];
    NSMutableArray *storyTextArr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"storyText"] mutableCopy];

    
    if (storyIdArr == nil) {
        
        storyIdArr = [NSMutableArray arrayWithCapacity:1];
        storyPhotoArr = [NSMutableArray arrayWithCapacity:1];
        storyTextArr = [NSMutableArray arrayWithCapacity:1];
        
        self.favorImage = [UIImage imageNamed:@"favorYellow.png"];
        [storyIdArr addObject:@(self.spot_id)];
        [storyPhotoArr addObject:self.story.cover_image];
        [storyTextArr addObject:self.story.text];
        
    }else{
        
        if ([storyIdArr containsObject:@(self.spot_id)] ) {
            self.favorImage = [UIImage imageNamed:@"favorBlack.png"];
            [storyIdArr removeObject:@(self.spot_id)];
            [storyPhotoArr removeObject:self.story.cover_image];
            [storyTextArr removeObject:self.story.text];
            
        }else{
            self.favorImage = [UIImage imageNamed:@"favorYellow.png"];
            [storyIdArr addObject:@(self.spot_id)];
            [storyPhotoArr addObject:self.story.cover_image];
            [storyTextArr addObject:self.story.text];
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:storyIdArr forKey:@"storyId"];
    [[NSUserDefaults standardUserDefaults] setObject:storyPhotoArr forKey:@"storyPhoto"];
    [[NSUserDefaults standardUserDefaults] setObject:storyTextArr forKey:@"storyText"];
    [self.navigationItem.rightBarButtonItem setImage:[self.favorImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
    
}

#pragma mark--- tableView 的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.story.detailArr count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        AuthorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"authorCell"];
        if (cell == nil) {
            cell = [[AuthorCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"authorCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.author = self.author;
        cell.storyTitle = self.story.text;
        
        return cell;
    }else{
        StoryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"storyCell"];
        if (cell == nil) {
            cell = [[StoryDetailCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"storyCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (self.story.detailArr.count != 0) {
            cell.storyDetail = self.story.detailArr[indexPath.row - 1];
        }
        return cell;
    }
}

// 单元格的点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != 0) {
        
        PhotoViewController *photoVC = [[PhotoViewController alloc] init];
        photoVC.indexPath = indexPath;
        photoVC.storyDetailArr = self.story.detailArr;
        [self.navigationController pushViewController:photoVC animated:YES];
        
    }
}

// 单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return [AuthorCell heightOfCell:self.story.text];
    }else{
        StoryDetail *detail = self.story.detailArr[indexPath.row - 1];
        return [StoryDetailCell heightOfCellWithText:detail.photo_text photoHeight:detail.photo_height photoWidth:detail.photo_width];
    }
    return 200;
}


// 解析数据
- (void)setData{
    
    self.story = [[Story alloc] init];
    self.author = [[Author alloc] init];
    
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://api.breadtrip.com/v2/new_trip/spot/?spot_id=%ld", self.spot_id] completion:^(NSData *data) {
        
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSDictionary *spotDic = rootDic[@"data"][@"spot"];
        [self.story setValuesForKeysWithDictionary:spotDic];
        
        NSDictionary *tripDic = rootDic[@"data"][@"trip"][@"user"];
        [self.author setValuesForKeysWithDictionary:tripDic];
        
        
        [self.acView stopAnimating];
        [self.acView removeFromSuperview];
        
        
        
        self.navigationItem.rightBarButtonItem.enabled = YES;
        
        [self.tableView reloadData];
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
