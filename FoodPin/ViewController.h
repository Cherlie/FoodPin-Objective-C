//
//  ViewController.h
//  FoodPin
//
//  Created by uappx.cn on 15/9/4.
//  Copyright (c) 2015年 梅须白. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ViewController : UITableViewController<NSFetchedResultsControllerDelegate,UISearchResultsUpdating>

@property (strong,nonatomic)NSFetchedResultsController* fetchResultController;
@property (strong,nonatomic)UISearchController* searchController;

@end

