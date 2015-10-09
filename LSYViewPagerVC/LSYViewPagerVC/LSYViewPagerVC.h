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
-(NSInteger)numberOfViewControllersInViewPager:(LSYViewPagerVC *)viewPager;
-(__kindof UIViewController *)viewPager:(LSYViewPagerVC *)viewPager indexOfViewControllers:(NSInteger)index;
@end
@interface LSYViewPagerVC : UIViewController
@property (nonatomic,weak) id<LSYViewPagerVCDataSource>dataSource;
@property (nonatomic,weak) id<LSYViewPagerVCDelegate>delegate;
@end
