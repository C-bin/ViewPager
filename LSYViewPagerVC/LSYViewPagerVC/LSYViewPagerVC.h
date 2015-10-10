//
//  LSYViewPagerVC.h
//  LSYViewPagerVC
//
//  Created by okwei on 15/10/9.
//  Copyright © 2015年 okwei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSYViewPagerVC;
@protocol  LSYViewPagerVCDelegate <NSObject>

@end
@protocol LSYViewPagerVCDataSource <NSObject>
@required
-(NSInteger)numberOfViewControllersInViewPager:(LSYViewPagerVC *)viewPager;
-(__kindof UIViewController *)viewPager:(LSYViewPagerVC *)viewPager indexOfViewControllers:(NSInteger)index;

@optional
-(NSString *)viewPager:(LSYViewPagerVC *)viewPager titleWithIndexOfViewControllers:(NSInteger)index;
-(UIColor *)viewPager:(LSYViewPagerVC *)viewPager colorWithSelectedOfViewControllers:(NSInteger)index;
-(UIColor *)viewPager:(LSYViewPagerVC *)viewPager colorWithUnSelectedOfViewControllers:(NSInteger)index;
-(CGFloat)heightForTitleOfViewPager:(LSYViewPagerVC *)viewPager;
-(UIView *)headerViewForInViewPager:(LSYViewPagerVC *)viewPager;
-(CGFloat)heightForHeaderOfViewPager:(LSYViewPagerVC *)viewPager;
@end

@interface LSYViewPagerVC : UIViewController
@property (nonatomic,weak) id<LSYViewPagerVCDataSource>dataSource;
@property (nonatomic,weak) id<LSYViewPagerVCDelegate>delegate;
-(void)reload;
@end


#pragma -mark View Controller Title Button

@interface LSYViewPagerTitleButton : UIButton

@end