//
//  LSYViewPagerVC.m
//  LSYViewPagerVC
//
//  Created by okwei on 15/10/9.
//  Copyright © 2015年 okwei. All rights reserved.
//

#import "LSYViewPagerVC.h"

@interface LSYViewPagerVC ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
{
    NSInteger numberOfViewController;
    NSArray *arrayOfViewController;
    
}
@property (nonatomic,strong) UIPageViewController *pageViewController;
@end

@implementation LSYViewPagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}
-(UIPageViewController *)pageViewController
{
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;

    }
    return _pageViewController;
}
-(void)setDataSource:(id<LSYViewPagerVCDataSource>)dataSource
{
    _dataSource = dataSource;
    if ([self.dataSource respondsToSelector:@selector(numberOfViewControllersInViewPager:)]) {
        numberOfViewController = [self.dataSource numberOfViewControllersInViewPager:self];
        NSMutableArray *mutableArray = [NSMutableArray array];
        for (int i = 0; i<numberOfViewController; i++) {
            if ([self.dataSource respondsToSelector:@selector(viewPager:indexOfViewControllers:)]) {
                [mutableArray addObject:[self.dataSource viewPager:self indexOfViewControllers:i]];
            }
        }
        arrayOfViewController = [mutableArray copy];
    }
    if (arrayOfViewController.count) {
        [_pageViewController setViewControllers:@[arrayOfViewController.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
}
#pragma mark -UIPageViewControllerDelegate

#pragma mark -UIPageViewControllerDataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [arrayOfViewController indexOfObject:viewController];
    if (index == 0) {
        return nil;
    }
    else{
        return arrayOfViewController[--index];
    }
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [arrayOfViewController indexOfObject:viewController];
    if (index == arrayOfViewController.count-1) {
        return nil;
    }
    else{
        return arrayOfViewController[++index];
    }
}
-(void)viewDidLayoutSubviews
{
    _pageViewController.view.frame = CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height-40);
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
