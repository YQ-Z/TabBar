//
//  TabBarViewController.m
//  ZhiFu
//
//  Created by OSX on 17/3/31.
//  Copyright © 2017年 OSX. All rights reserved.
//

#import "TabBarViewController.h"

#import "ViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"
#import "CustomTabBar.h"

//随机色
#define YQRandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0]
// RGB颜色（不透明）
#define YQColor(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]
// rgb颜色转换（16进制->10进制）
#define YQColorWithHex(rgb) [UIColor colorWithRed:((rgb & 0xFF0000) >> 16) / 255.0f green:((rgb & 0xFF00) >> 8) / 255.0f blue:((rgb & 0xFF)) / 255.0f alpha:1.0f]
//蓝色
#define YQBlueColor YQColorWithHex(0x00abee)
//设置字体大小
#define YQFont(size) [UIFont systemFontOfSize:size]

@interface TabBarViewController ()<CustomTabBarDelegate,UITabBarDelegate>
@end

@implementation TabBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置 TabBarItemTestAttributes 的颜色。
    [self setUpTabBarItemTextAttributes];
    
    // 处理tabBar，使用自定义 tabBar 添加 发布按钮
    [self setUpTabBar];
    
    // 设置子控制器
    [self setUpChildViewController];
    
    //设置进入显示的当前页
    self.selectedIndex = 2;
    
}

- (void)setUpTabBarItemTextAttributes {
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = YQColorWithHex(0x7a7a7a);
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = YQBlueColor;
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
}

/**
 *  添加子控制器，我这里值添加了4个，没有占位自控制器
 */
- (void)setUpChildViewController {
    [self addOneChildViewController:[[ViewController alloc]init]
                          WithTitle:@"tab1"
                          imageName:@"tabBar0_0"
                  selectedImageName:@"tabBar0_1"];
    
    [self addOneChildViewController:[[ViewController1 alloc] init]
                          WithTitle:@"tab2"
                          imageName:@"tabBar1_0"
                  selectedImageName:@"tabBar1_1"];
    
    [self addOneChildViewController:[[ViewController2 alloc] init]
                          WithTitle:@"tab3"
                          imageName:@"tabBar2_0"
                  selectedImageName:@"tabBar2_1"];
    
    [self addOneChildViewController:[[ViewController3 alloc]init]
                          WithTitle:@"tab4"
                          imageName:@"tabBar3_0"
                  selectedImageName:@"tabBar3_1"];
    
    
    [self addOneChildViewController:[[ViewController4 alloc]init]
                          WithTitle:@"tab5"
                          imageName:@"tabBar4_0"
                  selectedImageName:@"tabBar4_1"];

}

- (void)addOneChildViewController:(UIViewController *)viewController WithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    //设置navi的标题颜色
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[YQFont(18),[UIColor whiteColor]] forKeys:@[NSFontAttributeName,NSForegroundColorAttributeName]];
    
    viewController.view.backgroundColor = YQRandomColor;
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:imageName];
    
    if ([title isEqualToString:@"tab3"]) {
        viewController.tabBarItem.imageInsets = UIEdgeInsetsMake(-8, 0, 8, 0);
    }
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:viewController];
    navi.navigationBar.barTintColor = [UIColor whiteColor];
    navi.navigationBar.translucent = NO;
    navi.navigationBar.titleTextAttributes = dic;
    [self addChildViewController:navi];
}

/**
 *  利用 KVC 把 系统的 tabBar 类型改为自定义类型。
 */
- (void)setUpTabBar{
    
    CustomTabBar *tab = [[CustomTabBar alloc] init];
    tab.tabBarDelegate = self;
    
    [self setValue:tab forKey:@"tabBar"];
    
}

#pragma mark - CustomTabBarDelegate
- (void)selectedItemIndex:(NSInteger)tag {
    self.selectedIndex = tag;
    [self addAnimationToIndex:2];
}

#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger index = [tabBar.items indexOfObject:item];
    [self addAnimationToIndex:index];
    
    if (index != 2) {
        if (item.badgeValue) {
            item.badgeValue = nil;
        } else {
            item.badgeValue = [NSString stringWithFormat:@"1"];
        }
        
    }
    
}

//添加tabbarItem动画
- (void)addAnimationToIndex:(NSInteger)index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    
    CAKeyframeAnimation *bounceAnimation = [[CAKeyframeAnimation alloc] init];
    bounceAnimation.keyPath = @"transform.scale";
    bounceAnimation.values = @[@1.0 ,@1.4, @0.9, @1.15, @0.95, @1.02, @1.0];
    bounceAnimation.duration = 0.6;
    bounceAnimation.calculationMode = kCAAnimationCubic;
    [[tabbarbuttonArray[index] layer] addAnimation:bounceAnimation forKey:@"TabBarItemAnimation"];
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
