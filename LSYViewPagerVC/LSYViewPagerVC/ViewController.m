//
//  ViewController.m
//  LSYViewPagerVC
//
//  Created by okwei on 15/10/9.
//  Copyright © 2015年 okwei. All rights reserved.
//

#import "ViewController.h"
#import "LSYBackGroundVC.h"
#import "TestTabView.h"
@interface ViewController ()<LSYViewPagerVCDataSource,LSYViewPagerVCDelegate>
@property (nonatomic,strong) NSArray *titleArray;
@end

@implementation ViewController
-(void)loadView
{
    [super loadView];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ViewPager";
    _titleArray = @[@"分类1",@"分类2",@"分类3",@"长标题分类4",@"分类5"];
    self.delegate = self;
    self.dataSource = self;
    [self reload];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma View Pager Data Source
-(NSInteger)numberOfViewControllersInViewPager:(LSYViewPagerVC *)viewPager
{
    return 5;
}
-(__kindof UIViewController *)viewPager:(LSYViewPagerVC *)viewPager indexOfViewControllers:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            TestTabView *tableViewVC = [[TestTabView alloc] init];
            return tableViewVC;
            ;
        }
            break;
        case 1:
        {
            LSYBackGroundVC *backGround = [[LSYBackGroundVC alloc] init];
            backGround.bgColor = [UIColor blueColor];
            return backGround;
        }
            break;
        case 2:
        {
            TestTabView *tableViewVC = [[TestTabView alloc] init];
            return tableViewVC;
        }
            break;
        case 3:
        {
            LSYBackGroundVC *backGround = [[LSYBackGroundVC alloc] init];
            backGround.bgColor = [UIColor grayColor];
            return backGround;
        }
            break;
        case 4:
        {
            LSYBackGroundVC *backGround = [[LSYBackGroundVC alloc] init];
            backGround.bgColor = [UIColor greenColor];
            return backGround;
        }
            break;
        default:
        {
            LSYBackGroundVC *backGround = [[LSYBackGroundVC alloc] init];
            backGround.bgColor = [UIColor redColor];
            return backGround;
        }
            break;
    }
}
//-(UIView *)headerViewForInViewPager:(LSYViewPagerVC *)viewPager
//{
//    UIView *headerView = [[UIView alloc] init];
//    headerView.backgroundColor = [UIColor greenColor];
//    return headerView;
//}
//-(CGFloat)heightForHeaderOfViewPager:(LSYViewPagerVC *)viewPager
//{
//    return 100;
//}
-(CGFloat)heightForTitleOfViewPager:(LSYViewPagerVC *)viewPager
{
    return 30;
}
-(NSString *)viewPager:(LSYViewPagerVC *)viewPager titleWithIndexOfViewControllers:(NSInteger)index
{
    return self.titleArray[index];
}
-(UIColor *)viewPager:(LSYViewPagerVC *)viewPager colorWithSelectedOfViewControllers:(NSInteger)index
{
    return [UIColor redColor];
}
-(UIColor *)viewPager:(LSYViewPagerVC *)viewPager colorWithUnSelectedOfViewControllers:(NSInteger)index
{
    return [UIColor blackColor];
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
