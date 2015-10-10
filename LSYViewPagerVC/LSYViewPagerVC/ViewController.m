//
//  ViewController.m
//  LSYViewPagerVC
//
//  Created by okwei on 15/10/9.
//  Copyright © 2015年 okwei. All rights reserved.
//

#import "ViewController.h"
#import "LSYBackGroundVC.h"
@interface ViewController ()<LSYViewPagerVCDataSource>
@property (nonatomic,strong) NSArray *titleArray;
@end

@implementation ViewController
-(void)loadView
{
    [super loadView];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = @[@"11111111",@"222222",@"3",@"44444",@"5555555"];
    self.delegate = self;
    self.dataSource = self;
    UIPageViewController *page = [[UIPageViewController alloc] init];
    for (id view in page.view.subviews) {
        NSLog(@"%@",NSStringFromClass([view class]));
    }
    // Do any additional setup after loading the view, typically from a nib.
}
-(NSInteger)numberOfViewControllersInViewPager:(LSYViewPagerVC *)viewPager
{
    return 5;
}
-(__kindof UIViewController *)viewPager:(LSYViewPagerVC *)viewPager indexOfViewControllers:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            LSYBackGroundVC *backGround = [[LSYBackGroundVC alloc] init];
            backGround.bgColor = [UIColor redColor];
            return backGround;
        }
            break;
        case 1:
        {
            LSYBackGroundVC *backGround = [[LSYBackGroundVC alloc] init];
            backGround.bgColor = [UIColor blackColor];
            return backGround;
        }
            break;
        case 2:
        {
            LSYBackGroundVC *backGround = [[LSYBackGroundVC alloc] init];
            backGround.bgColor = [UIColor blueColor];
            return backGround;
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
-(UIView *)headerViewForInViewPager:(LSYViewPagerVC *)viewPager
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor greenColor];
    return headerView;
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
-(UIColor *)viewPager:(LSYViewPagerVC *)viewPager colorWithSelectedOfViewControllers:(NSInteger)index
{
    return [UIColor redColor];
}
-(UIColor *)viewPager:(LSYViewPagerVC *)viewPager colorWithUnSelectedOfViewControllers:(NSInteger)index
{
    return [UIColor blackColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
