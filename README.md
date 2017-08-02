# TabBar
Customize tabbar to implement irregular tabbar

![TarBarGif](https://github.com/YQ-Z/LeftAndRightScrollTextView/blob/master/ScrollTextVew.gif)
# Requirements
iOS 8.0 or later

# Example Usage
```
    self.scrollTextView1 = [[TextScrollBarView alloc]initWithFrame:CGRectMake(0, 50, Width,Height * 40) textScrollModel:TextScrollFromOutside_Continuous direction:TextScrollMoveLeft];
        [self.scrollTextView1 startScrollWithText:@"此为从控件外，从左往右连续不间断显示、此为从控件外，从左往右连续不间断显示" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15.0f]];
        [self.view addSubview:self.scrollTextView1];
```
