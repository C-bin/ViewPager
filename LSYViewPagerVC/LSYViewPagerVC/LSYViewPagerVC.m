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
    NSArray <LSYViewPagerTitleButton *>*arrayOfViewControllerButton;    //存放VC Button的数组
    UIView *headerView;     //头部视图
    CGRect oldRect;   //用来保存title布局的Rect
    LSYViewPagerTitleButton *oldButton;
    
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
        NSMutableArray <LSYViewPagerTitleButton *> *mutableArrayOfBtn = [NSMutableArray array];
        for (int i = 0; i<numberOfViewController; i++) {
            if ([self.dataSource respondsToSelector:@selector(viewPager:indexOfViewControllers:)]) {
                [mutableArrayOfVC addObject:[self.dataSource viewPager:self indexOfViewControllers:i]];
            }
            if ([self.dataSource respondsToSelector:@selector(viewPager:titleWithIndexOfViewControllers:)]) {
                NSString *buttonTitle = [self.dataSource viewPager:self titleWithIndexOfViewControllers:i];
                if (arrayOfViewControllerButton.count > i) {
                    [[arrayOfViewControllerButton objectAtIndex:i] removeFromSuperview];
                }
                LSYViewPagerTitleButton *button = [[LSYViewPagerTitleButton alloc] init];
                [button addTarget:self action:@selector(p_titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                button.frame = CGRectMake(oldRect.origin.x+oldRect.size.width, 0, [self p_fontText:buttonTitle withFontHeight:20], [self.dataSource respondsToSelector:@selector(heightForTitleOfViewPager:)]?[self.dataSource heightForTitleOfViewPager:self]:0);
                oldRect = button.frame;
                [button setTitle:buttonTitle forState:UIControlStateNormal];
                [mutableArrayOfBtn addObject:button];
                [_titleBackground addSubview:button];
                if (i == 0) {
                    oldButton = [mutableArrayOfBtn objectAtIndex:0];
                    oldButton.selected = YES;
                }
                
            }
            
            if ([self.dataSource respondsToSelector:@selector(viewPager:colorWithSelectedOfViewControllers:)]) {
                [[mutableArrayOfBtn objectAtIndex:i] setTitleColor:[self.dataSource viewPager:self colorWithSelectedOfViewControllers:i] forState:UIControlStateSelected];
                
            }
            if ([self.dataSource respondsToSelector:@selector(viewPager:colorWithUnSelectedOfViewControllers:)]) {
                [[mutableArrayOfBtn objectAtIndex:i] setTitleColor:[self.dataSource viewPager:self colorWithUnSelectedOfViewControllers:i] forState:UIControlStateNormal];
            }
            
        }
        if (mutableArrayOfBtn.count && mutableArrayOfBtn.lastObject.frame.origin.x + mutableArrayOfBtn.lastObject.frame.size.width<self.view.frame.size.width) //当所有按钮尺寸小于屏幕宽度的时候要重新布局
        {
            oldRect = CGRectZero;
            for (LSYViewPagerTitleButton *button in mutableArrayOfBtn) {
                button.frame = CGRectMake(oldRect.origin.x+oldRect.size.width, 0, self.view.frame.size.width/mutableArrayOfBtn.count, [self.dataSource respondsToSelector:@selector(heightForTitleOfViewPager:)]?[self.dataSource heightForTitleOfViewPager:self]:0);
                oldRect = button.frame;
            }
        }
        arrayOfViewControllerButton = [mutableArrayOfBtn copy];
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
-(void)p_titleButtonClick:(LSYViewPagerTitleButton *)sender
{
    oldButton.selected = NO;
    sender.selected = YES;
    oldButton = sender;
    NSInteger index = [arrayOfViewControllerButton indexOfObject:sender];
    UIScrollView *scrollView = _pageViewController.view.subviews.firstObject;
    scrollView.contentOffset = CGPointMake(index*self.view.frame.size.width, 0);
    
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
    headerView.frame = CGRectMake(0, self.topLayoutGuide.length, self.view.frame.size.width,[self.dataSource respondsToSelector:@selector(heightForHeaderOfViewPager:)]?[self.dataSource heightForHeaderOfViewPager:self]:0);
    _titleBackground.frame = CGRectMake(0, headerView.frame.origin.y+headerView.frame.size.height, self.view.frame.size.width,[self.dataSource respondsToSelector:@selector(heightForTitleOfViewPager:)]?[self.dataSource heightForTitleOfViewPager:self]:0);
    if (arrayOfViewControllerButton.count) {
        
        _titleBackground.contentSize = CGSizeMake(arrayOfViewControllerButton.lastObject.frame.size.width+arrayOfViewControllerButton.lastObject.frame.origin.x, _titleBackground.frame.size.height);
    }
    _pageViewController.view.frame = CGRectMake(0, _titleBackground.frame.origin.y+_titleBackground.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
}
#pragma maek 计算字体宽度
-(CGFloat)p_fontText:(NSString *)text withFontHeight:(CGFloat)height
{
    NSDictionary *fontAttribute = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    CGSize fontSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:fontAttribute context:nil].size;
    return fontSize.width+20;
}

@end

#pragma -mark View Controller Title Button

@implementation LSYViewPagerTitleButton
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.titleLabel setFont:[UIFont systemFontOfSize:14]];
    }
    return self;
}
-(void)drawRect:(CGRect)rect
{
    if (self.selected) {
        CGFloat lineWidth = 5;
        CGColorRef color = self.titleLabel.textColor.CGColor;
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(ctx, color);
        CGContextSetLineWidth(ctx, lineWidth);
        CGContextMoveToPoint(ctx, 0, self.frame.size.height-lineWidth);
        CGContextAddLineToPoint(ctx, self.frame.size.width, self.frame.size.height-lineWidth);
        CGContextStrokePath(ctx);
    }
}
@end
