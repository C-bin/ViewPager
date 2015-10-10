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
    NSInteger numberOfViewController;   //VC的总数量
    NSArray *arrayOfViewController;     //存放VC的数组
    NSArray *arrayOfViewControllerButton;    //存放VC Button的数组
    UIView *headerView;     //头部视图
    
}
@property (nonatomic,strong) UIPageViewController *pageViewController;
@property (nonatomic,strong) UIScrollView *titleBackground;
@end

@implementation LSYViewPagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.view addSubview:self.titleBackground];
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
-(UIScrollView *)titleBackground
{
    if (!_titleBackground) {
        _titleBackground = [[UIScrollView alloc] init];
        _titleBackground.showsHorizontalScrollIndicator = NO;
        _titleBackground.showsVerticalScrollIndicator = NO;
    }
    return _titleBackground;
}
-(void)setDataSource:(id<LSYViewPagerVCDataSource>)dataSource
{
    _dataSource = dataSource;
    [self reload];
    
}
-(void)reload
{
    if ([self.dataSource respondsToSelector:@selector(numberOfViewControllersInViewPager:)]) {
        numberOfViewController = [self.dataSource numberOfViewControllersInViewPager:self];
        NSMutableArray *mutableArrayOfVC = [NSMutableArray array];
        NSMutableArray <UIButton *> *mutableArrayOfBtn = [NSMutableArray array];
        for (int i = 0; i<numberOfViewController; i++) {
            if ([self.dataSource respondsToSelector:@selector(viewPager:indexOfViewControllers:)]) {
                [mutableArrayOfVC addObject:[self.dataSource viewPager:self indexOfViewControllers:i]];
            }
            if ([self.dataSource respondsToSelector:@selector(viewPager:titleWithIndexOfViewControllers:)]) {
                UIButton *button = [[UIButton alloc] init];
                [button setTitle:[self.dataSource viewPager:self titleWithIndexOfViewControllers:i] forState:UIControlStateNormal];
                [mutableArrayOfBtn addObject:button];
            }
            if ([self.dataSource respondsToSelector:@selector(viewPager:colorWithSelectedOfViewControllers:)]) {
                [[mutableArrayOfBtn objectAtIndex:i] setTitleColor:[self.dataSource viewPager:self colorWithSelectedOfViewControllers:i] forState:UIControlStateSelected];
                
            }
            if ([self.dataSource respondsToSelector:@selector(viewPager:colorWithUnSelectedOfViewControllers:)]) {
                [[mutableArrayOfBtn objectAtIndex:i] setTitleColor:[self.dataSource viewPager:self colorWithSelectedOfViewControllers:i] forState:UIControlStateNormal];
            }
            
        }
        arrayOfViewController = [mutableArrayOfVC copy];
    }
    if ([self.dataSource respondsToSelector:@selector(headerViewForInViewPager:)]) {
        [headerView removeFromSuperview];
        headerView = [self.dataSource headerViewForInViewPager:self];
        [self.view addSubview:headerView];
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
    headerView.frame = CGRectMake(0, self.topLayoutGuide.length, self.view.frame.size.width,[self.dataSource respondsToSelector:@selector(heightForheaderOfViewPager:)]?[self.dataSource heightForheaderOfViewPager:self]:0);
    _pageViewController.view.frame = CGRectMake(0, headerView.frame.origin.y+headerView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
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
