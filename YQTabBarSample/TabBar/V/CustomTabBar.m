//
//  CustomTabBar.m
//  ZhiFu
//
//  Created by OSX on 17/6/1.
//  Copyright © 2017年 OSX. All rights reserved.
//

#import "CustomTabBar.h"
#import "TabBarViewController.h"

@interface CustomTabBar()
@property (nonatomic, strong) UIImageView *topImageView;
@end
@implementation CustomTabBar

- (UIImageView *)topImageView {
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabBarBackgroundView"]];
    }
    return _topImageView;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        CGPoint tp = [self.topImageView convertPoint:point fromView:self];
        if (CGRectContainsPoint(self.topImageView.bounds, tp)) {
            [self.tabBarDelegate selectedItemIndex:2];
        }
    }
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setBackgroundImage:[[UIImage alloc]init]];

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIView *view in self.subviews) {
        NSString *viewClass = NSStringFromClass([view class]);
        if ([viewClass isEqualToString:@"_UIBarBackground"]) {
            self.topImageView.frame = CGRectMake((self.frame.size.width - [UIImage imageNamed:@"tabBarBackgroundView"].size.width) / 2, - [UIImage imageNamed:@"tabBarBackgroundView"].size.height, [UIImage imageNamed:@"tabBarBackgroundView"].size.width, [UIImage imageNamed:@"tabBarBackgroundView"].size.height);
            [view addSubview:self.topImageView];
        } else if ([viewClass isEqualToString:@"UITabBarButton"]) {

        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSSet *allTouch = [event allTouches];
    UITouch *touch = [allTouch anyObject];
    CGPoint point = [touch locationInView:[touch view]];
    
    [self hitTest:point withEvent:event];
}

@end
