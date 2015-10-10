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

@end

@implementation ViewController
-(void)loadView
{
    [super loadView];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.dataSource = self;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData * jsonData = [NSData dataWithContentsOfFile:path];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSLog(@"%@",jsonDic);
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
