//
//  ViewController.m
//  FoodPin
//
//  Created by uappx.cn on 15/9/4.
//  Copyright (c) 2015年 梅须白. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"
#import "Restaurant.h"
#import "DetailViewController.h"
#import "AddTableViewController.h"
#import "AppDelegate.h"
#import "PageViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSArray* restaurants;
    NSMutableArray* searchRestults;
    CustomTableViewCell* cell;
    UINib *nib;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    BOOL hasViewedWalkthrough = [defaults boolForKey:@"hasViewedWalkthrough"];
    if (!hasViewedWalkthrough) {
        PageViewController* pageViewController = [[PageViewController alloc]init];
        [self presentViewController:pageViewController animated:YES completion:nil];
    }
    
    self.title = @"FoodPin";
    //to remove the title of back button
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonClick)];
    addButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = addButton;
    
    //fetch data from core data when fist loaded.
    NSFetchRequest* fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Restaurant"];
    //define a sort to data
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext* managedObjectContext = appDelegate.managedObjectContext;
    if (managedObjectContext != nil) {
        self.fetchResultController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        self.fetchResultController.delegate = self;
    
        NSError* e = [[NSError alloc]init];
        BOOL result = [self.fetchResultController performFetch:&e];
        restaurants = self.fetchResultController.fetchedObjects;
        if (!result) {
            NSLog(@"%@",e.localizedDescription);
        }
    }
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    [self.searchController.searchBar sizeToFit];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
}

- (void)filterContentFor:(NSString*)searchText{
    NSRange range,rangeLocation;
    searchRestults = [[NSMutableArray alloc]init];
    for (Restaurant* item in restaurants) {
        range = [item.name rangeOfString:searchText];
        rangeLocation = [item.location rangeOfString:searchText];
        if (range.length > 0 || rangeLocation.length > 0) {
            [searchRestults addObject:item];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.searchController isActive]) {
        return searchRestults.count;
    } else {
        return restaurants.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellIdentifier = @"Cell";
    if (nib == nil) {
        nib = [UINib nibWithNibName:@"CustomTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
    }
    cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    //set data of cells
    Restaurant* rest = [self.searchController isActive] ? [searchRestults objectAtIndex:indexPath.row] : [restaurants objectAtIndex:indexPath.row];
    cell.nameLabel.text = rest.name;
    cell.thumbnailImageView.image = [UIImage imageWithData:rest.image];
    cell.typeLabel.text = rest.type;
    cell.locationLabel.text = rest.location;
    //if the restaurant is visited,it will show a mark on row.
    if(rest.isVisited.boolValue){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    //define a share row action
    UITableViewRowAction* shareAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Share" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        //define some menus
        UIAlertController* shareMenu = [UIAlertController alertControllerWithTitle:nil message:@"Share using" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction* twitterAction = [UIAlertAction actionWithTitle:@"Twitter" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction* facebookAction = [UIAlertAction actionWithTitle:@"Facebook" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction* emailAction = [UIAlertAction actionWithTitle:@"Email" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        //add different menus to action
        [shareMenu addAction:twitterAction];
        [shareMenu addAction:facebookAction];
        [shareMenu addAction:emailAction];
        [shareMenu addAction:cancelAction];
        //show the share view
        [self presentViewController:shareMenu animated:YES completion:nil];
    }];
    //define a delete action to row command
    UITableViewRowAction* deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        //remove data of array and tableview's row
        AppDelegate* app = [UIApplication sharedApplication].delegate;
        NSManagedObjectContext* managedObjectContext = app.managedObjectContext;
        if (managedObjectContext != nil) {
            Restaurant* restaurant = [self.fetchResultController objectAtIndexPath:indexPath];
            [managedObjectContext deleteObject:restaurant];
            NSError* e = [[NSError alloc]init];
            if (![managedObjectContext save:&e]) {
                NSLog(@"delete error:%@",e.localizedDescription);
            }
        }
    }];
    //background of actions
    shareAction.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:166.0/255.0 blue:51.0/255.0 alpha:1.0];
    deleteAction.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    return @[shareAction,deleteAction];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /*define custom push animation
    CATransition* transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
     */
    //navigate to detial view
    DetailViewController* detailViewController = [[DetailViewController alloc]init];
    detailViewController.hidesBottomBarWhenPushed = YES;
    detailViewController.restaurant = [self.searchController isActive] ? [searchRestults objectAtIndex:indexPath.row] : [restaurants objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)addButtonClick{
    //navigationcontroller contains a navigation bar,so easy to use.
    UINavigationController* controller = [[UINavigationController alloc]init];
    AddTableViewController* addViewController = [[AddTableViewController alloc]init];
    controller.viewControllers = @[addViewController];
    [self.navigationController presentViewController:controller animated:YES completion:nil];
}

//this function is important,the swipe command wouldn't show whith out this func.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

//tell the table view we will change row
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView beginUpdates];
}

//define the behavior that insert,delete or updates rows
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            [self.tableView reloadData];
            break;
    }
    restaurants = [controller fetchedObjects];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.searchController isActive]) {
        return NO;
    }else{
        return YES;
    }
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString* searchText = self.searchController.searchBar.text;
    [self filterContentFor:searchText];
    [self.tableView reloadData];
}

//tell the table view we changed rows
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
