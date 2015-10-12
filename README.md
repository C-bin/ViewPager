# ViewPager
可以集成不同的控制器进行左右滑动，给控制器设置标题实现左右联动的效果

---
实现效果：<br>
![](https://github.com/GGGHub/ViewPager/raw/master/LSYViewPagerVC/ViewPager.gif "没有头部视图")
![](https://github.com/GGGHub/ViewPager/raw/master/LSYViewPagerVC/ViewPager2.gif "有头部视图")<br>

---

**关于ViewPager：**
* 可以设置`title`的选中颜色和默认颜色与高度
* 可以在`title`上添加自定义的视图，并自定义视图的高度
* 根据`tilte`的内容和屏幕的宽度自动设置`frame`确保填充整个屏幕的宽度，当`title`的总宽度超出屏幕时会实现滚动效果

## 安装
1. 打开`LSYViewPagerVC`项目导入`LSYViewPagerVC.h`与`LSYViewPagerVC.m`即可

## 使用
### 继承
* 导入头文件`LSYViewPagerVC.h`
* 当前要实现的控制器继承`LSYViewPagerVC`
``` objective-c
#import "LSYViewPagerVC.h"
@interface ViewController : LSYViewPagerVC
@end
``` 

* 给当前的控制器设置代理方法 
```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.dataSource = self;
}
```
