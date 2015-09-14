//
//  FeedViewController.h
//  FoodPin
//
//  Created by uappx.cn on 15/9/13.
//  Copyright (c) 2015年 梅须白. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedViewController : UITableViewController

@property (strong,nonatomic)UIActivityIndicatorView* spinner;
@property (strong,nonatomic)UIRefreshControl* refreshControl;

@end
