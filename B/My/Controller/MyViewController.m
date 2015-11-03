//
//  MyViewController.m
//  B
//
//  Created by lanou on 15/10/27.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "MyViewController.h"
#import "StoryFavorViewController.h"
#import "TravelFavorViewController.h"

// 缓存地址
#define PhotoFilePath [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/com.hackemist.SDWebImageCache.default"]  // 第三方的图片缓存文件夹地址
#define TextFilePath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] // 网络请求的文字缓存地址


@interface MyViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, assign)CGFloat cache;
@property (nonatomic, assign)NSInteger storyCount;
@property (nonatomic, assign)NSInteger travelCount;

@end

@implementation MyViewController

- (void)viewWillAppear:(BOOL)animated{
    
    //收藏故事的数量
    NSArray *storyArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"storyId"];
    self.storyCount = storyArr.count;
    
    NSArray *travelArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"travelId"];
    self.travelCount = travelArr.count;
    
    [self getSizeOfCache];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的";
    
    
    self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 50)) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}

#pragma mark--- tableView 代理实现方法
// 分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
//分区中单元格行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 1;
}
//加载单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"storyFavor"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"storyFavor"];
        }
        cell.textLabel.text = indexPath.row == 0 ? @"故事收藏" : @"游记收藏";
        
        NSInteger count = indexPath.row == 0 ? self.storyCount : self.travelCount;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", count];
        return cell;
    }

    if (indexPath.section == 1) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cleanCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cleanCell"];
        }
        cell.textLabel.text = @"清除缓存";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fM", self.cache];
        
        return cell;
    }
    return nil;
}
// 区头设置
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
//单元格点击触发事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            StoryFavorViewController *storyFavorVC = [[StoryFavorViewController alloc] init];
            [self.navigationController pushViewController:storyFavorVC animated:YES];
        }else{
            TravelFavorViewController *travelVC = [[TravelFavorViewController alloc] init];
            [self.navigationController pushViewController:travelVC animated:YES];
        }
    }
        
    if (indexPath.section == 1) {
        
        if (self.cache == 0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂无缓存" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alertView show];
            [self performSelector:@selector(missAlertView:) withObject:alertView afterDelay:1.0]; // 1秒后自动消失
        }else{
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"缓存大小为%.2fM, 确定要清理缓存吗?",self.cache] delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消",nil];
            [alertView show];
        }
    }
}

#pragma mark--- alertView 的代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self cleanCache];
    }
}


#pragma mark--- 提示的延迟自动消失
- (void)missAlertView:(UIAlertView *)alert{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark--- 清除缓存
- (void)cleanCache{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:PhotoFilePath error:nil];  // 移除缓存文件
    
    // 遍历存放text文件下的所有文件
    NSArray *subFiles = [fileManager subpathsAtPath:TextFilePath];
    for (NSString *fileName in subFiles) {
        NSString *path = [TextFilePath stringByAppendingPathComponent:fileName];
        [fileManager removeItemAtPath:path error:nil];
    }
    
    [self getSizeOfCache];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"缓存清除成功" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alertView show];
    [self performSelector:@selector(missAlertView:) withObject:alertView afterDelay:1.0];
    
}

#pragma mark--- 获取缓存
- (void)getSizeOfCache{
    
    long long size = 0.0;

    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath :PhotoFilePath]){  // 当文件下包含该文件
        
        NSArray *subFiles = [fileManager subpathsAtPath:PhotoFilePath];
        for (NSString *fileName in subFiles) {  // 按个获取文件下的图片, 计算大小
            
            NSString *path = [PhotoFilePath stringByAppendingPathComponent:fileName];
            NSDictionary *dic = [fileManager attributesOfItemAtPath:path error:nil];
            size += [dic fileSize];
            
        }
    }
    
    if ([fileManager fileExistsAtPath :TextFilePath]){  // 当文件下包含该文件
        
        NSArray *subFiles = [fileManager subpathsAtPath:TextFilePath];
        for (NSString *fileName in subFiles) {
            
            NSString *path = [TextFilePath stringByAppendingPathComponent:fileName];
            NSDictionary *dic = [fileManager attributesOfItemAtPath:path error:nil];
            size += [dic fileSize];
        }
    }
    
    self.cache = size / (1024.0 * 1024.0);
    [self.tableView reloadData];
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
