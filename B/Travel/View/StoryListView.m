//
//  StoryListView.m
//  B
//
//  Created by lanou on 15/11/2.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "StoryListView.h"
#import "StoryListCell.h"

@interface StoryListView()<UICollectionViewDataSource>

@end

@implementation StoryListView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(self.bounds.size.width / 2 - 10, self.bounds.size.width / 3);
        layout.minimumInteritemSpacing = 8;
        layout.minimumLineSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(10, 5, 0, 5);
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:(CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)) collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
        self.collectionView.showsVerticalScrollIndicator = NO;
        
        self.collectionView.dataSource = self;
        
        [self.collectionView registerClass:[StoryListCell class] forCellWithReuseIdentifier:@"storyListCell"];
        
        [self addSubview:self.collectionView];
        
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.storyArr count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StoryListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"storyListCell" forIndexPath:indexPath];
    
    if (self.storyArr.count != 0) {
        cell.dataModel = self.storyArr[indexPath.item];
    }
    return cell;
}

- (void)setStoryArr:(NSMutableArray *)storyArr{
    
    _storyArr = [NSMutableArray arrayWithArray:storyArr];
    [self.collectionView reloadData];
}

@end
