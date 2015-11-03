//
//  TravelListView.m
//  B
//
//  Created by lanou on 15/11/2.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "TravelListView.h"
#import "TravelListCell.h"
#import "IndexModel.h"

@interface TravelListView()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation TravelListView

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
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
        
        self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)) style:(UITableViewStylePlain)];
        self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.showsVerticalScrollIndicator = NO;
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 250;
        [self addSubview:self.tableView];

    }
    return self;
}

// tableView 的代理方法实现

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.travelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TravelListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"travelListCell"];
    if (cell == nil) {
        cell = [[TravelListCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"travelListCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.dataModel = self.travelArr[indexPath.row];
    
    return cell;
}

- (void)setTravelArr:(NSMutableArray *)travelArr{
    _travelArr = [NSMutableArray arrayWithArray:travelArr];
    [self.tableView reloadData];
}


@end
