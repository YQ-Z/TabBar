//
//  CustomTabBar.h
//  ZhiFu
//
//  Created by OSX on 17/6/1.
//  Copyright © 2017年 OSX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomTabBarDelegate <NSObject>

- (void)selectedItemIndex:(NSInteger)tag;

@end

@interface CustomTabBar : UITabBar
@property (weak, nonatomic) id<CustomTabBarDelegate> tabBarDelegate;

@end
