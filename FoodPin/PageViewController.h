//
//  PageViewController.h
//  FoodPin
//
//  Created by uappx.cn on 15/9/13.
//  Copyright (c) 2015年 梅须白. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageViewController : UIPageViewController<UIPageViewControllerDataSource>

- (void)forwardIndex:(int)Index;

@end
