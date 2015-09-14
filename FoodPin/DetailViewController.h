//
//  DetailViewController.h
//  FoodPin
//
//  Created by uappx.cn on 15/9/6.
//  Copyright (c) 2015年 梅须白. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"

@interface DetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic)UIImageView* imageView;
@property (strong,nonatomic)Restaurant* restaurant;
@property (strong,nonatomic)UITableView* tableView;
@property (strong,nonatomic)UIToolbar* toolBar;

@end
