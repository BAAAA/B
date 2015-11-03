//
//  StoryFavorViewController.m
//  B
//
//  Created by lanou on 15/11/2.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "StoryFavorViewController.h"
#import "StoryListCell.h"
#import "StoryListView.h"
#import "NetHandler.h"
#import "DataModel.h"
#import "Story.h"
#import "Author.h"
#import "StoryDetailViewController.h"

@interface StoryFavorViewController ()<UICollectionViewDelegate>

@property (nonatomic, strong)StoryListView *storyListView;
@property (nonatomic, strong)NSMutableArray *dataArr;

@property (nonatomic, strong)UIActivityIndicatorView *acView;

@end

@implementation StoryFavorViewController

// 当在收藏的列表中取消收藏的话, 要重新判断listView 的列表
- (void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.title = @"故事收藏";
    
    NSArray *storyIdArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"storyId"];
    
    if (storyIdArr.count == 0) {  // 当收藏数为0 ,提示
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"该分类下暂无收藏" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
        self.dataArr = nil;
        self.storyListView.storyArr = self.dataArr;    // 数组置空, 保持列表显示的同一性
        
    }else if (storyIdArr.count != self.dataArr.count) {
        
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
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.view.bounds.size.width / 2 - 10, self.view.bounds.size.width / 3);
    layout.minimumInteritemSpacing = 8;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 5, 0, 5);
    
    
    self.storyListView = [[StoryListView alloc] initWithFrame:(CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))];
    self.storyListView.collectionView.delegate = self;
    [self.view addSubview:self.storyListView];
    
    
    
}

// 单元格点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *storyIdArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"storyId"];
    StoryDetailViewController *storyDetailVC = [[StoryDetailViewController alloc] init];
    storyDetailVC.spot_id = [storyIdArr[indexPath.item] integerValue];
    [self.navigationController pushViewController:storyDetailVC animated:YES];
    
}

- (void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = [NSMutableArray arrayWithArray:dataArr];
    [self.storyListView.collectionView reloadData];
}

// 获取数据
- (void)setData{
    
    NSArray *storyIdArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"storyId"];
    NSArray *storyPhotoArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"storyPhoto"];
    NSArray *storyTextArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"storyText"];
    
    
    for (int i = 0; i < storyIdArr.count; i++) {
        
        DataModel *dataModel = [[DataModel alloc] init];
        dataModel.cover_image = storyPhotoArr[i];
        dataModel.title = storyTextArr[i];
        [self.dataArr addObject:dataModel];
        
    }
    self.storyListView.storyArr = self.dataArr;
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
