# TabBar
Customize tabbar to implement irregular tabbar

![TarBarGif](https://github.com/YQ-Z/TabBar/blob/master/Screenshots/TabBarSample.gif)
# Requirements
iOS 8.0 or later

# Example Usage
```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    TabBarViewController *tabBarVC = [TabBarViewController new];
    self.window.rootViewController = tabBarVC;
    [self.window makeKeyAndVisible];
    return YES;
}
```
