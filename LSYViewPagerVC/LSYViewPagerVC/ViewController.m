//
//  ViewController.m
//  LSYViewPagerVC
//
//  Created by okwei on 15/10/9.
//  Copyright © 2015年 okwei. All rights reserved.
//

#import "ViewController.h"
#import "TestTabView.h"
@interface ViewController ()<LSYViewPagerVCDataSource,LSYViewPagerVCDelegate>
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) UIView *headerView;
@end

@implementation ViewController
-(void)loadView
{
    [super loadView];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ViewPager";
    _titleArray = @[@"分类1",@"分类2",@"分类3",@"长标题分类4",@"分类5",@"长标题分类6",@"长标题分类7",@"长标题分类8",@"长标题分类9"];
    self.delegate = self;
    self.dataSource = self;
    // Do any additional setup after loading the view, typically from a nib.
}
-(UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
        _headerView.backgroundColor = [UIColor colorWithRed:120/255.0f green:210/255.0f blue:249/255.0f alpha:1];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        label.text = @"头部视图";
        [_headerView addSubview:label];
    }
    return _headerView;
}
#pragma View Pager Data Source
-(NSInteger)numberOfViewControllersInViewPager:(LSYViewPagerVC *)viewPager
{
    return _titleArray.count;
}
-(UIViewController *)viewPager:(LSYViewPagerVC *)viewPager indexOfViewControllers:(NSInteger)index
{
    TestTabView *tableViewVC = [[TestTabView alloc] init];
    tableViewVC.content = _titleArray[index];
    return tableViewVC;
}
-(UIView *)headerViewForInViewPager:(LSYViewPagerVC *)viewPager
{
    return self.headerView;
}
-(CGFloat)heightForHeaderOfViewPager:(LSYViewPagerVC *)viewPager
{
    return 100;
}
-(CGFloat)heightForTitleOfViewPager:(LSYViewPagerVC *)viewPager
{
    return 30;
}
-(NSString *)viewPager:(LSYViewPagerVC *)viewPager titleWithIndexOfViewControllers:(NSInteger)index
{
    return self.titleArray[index];
}


#pragma View Pager Delegate
-(void)viewPagerViewController:(LSYViewPagerVC *)viewPager willScrollerWithCurrentViewController:(UIViewController *)ViewController
{
    
}
-(void)viewPagerViewController:(LSYViewPagerVC *)viewPager didFinishScrollWithCurrentViewController:(UIViewController *)viewController
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
