//
//  SpecialViewController.m
//  B
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "SpecialViewController.h"

@interface SpecialViewController ()

@property (nonatomic, assign)CGRect frame;
@property (nonatomic, strong)UIWebView *webView;

@end

@implementation SpecialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.frame = self.tabBarController.tabBar.frame;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    
    self.webView = [[UIWebView alloc] initWithFrame:(CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))];
    [self.webView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[self.webURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]cachePolicy:0 timeoutInterval:20]];
    
    self.webView.scrollView.bounces = NO;
    
    [self.view addSubview:self.webView];
    
    
    
    
    self.tabBarController.tabBar.frame = CGRectMake(0, 0, 0, 0);
}


- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.frame = self.frame;

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
