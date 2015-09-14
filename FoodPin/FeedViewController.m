//
//  FeedViewController.m
//  FoodPin
//
//  Created by uappx.cn on 15/9/13.
//  Copyright (c) 2015年 梅须白. All rights reserved.
//

#import "FeedViewController.h"
#import "CustomTableViewCell.h"
#import "Restaurant.h"
#import "AddTableViewController.h"

#define APIURL @"http://uappx.cn:8080/api/restaurant"

@interface FeedViewController ()

@end

@implementation FeedViewController{
    NSArray* restaurants;
    CustomTableViewCell* cell;
    UINib *nib;
    NSOperationQueue* thumbQueue;
    NSCache* imageCache;
}
@dynamic refreshControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Feed";
    thumbQueue = [[NSOperationQueue alloc]init];
    imageCache = [[NSCache alloc]init];
    //indicator
    self.spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.spinner.center = self.view.center;
    self.spinner.hidesWhenStopped = YES;
    [self.view addSubview:self.spinner];
    [self.spinner startAnimating];
    //pull to refresh control
    self.refreshControl = [[UIRefreshControl alloc]init];
    self.refreshControl.backgroundColor = [UIColor whiteColor];
    self.refreshControl.tintColor = [UIColor grayColor];
    [self.refreshControl addTarget:self action:@selector(getDataSourceAsync) forControlEvents:UIControlEventValueChanged];
    [self getDataSourceAsync];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return restaurants.count;
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

    if (restaurants.count > 0) {
        //set data of cells
        NSDictionary* dict = [restaurants objectAtIndex:indexPath.row];
        cell.nameLabel.text = dict[@"Name"];
        cell.typeLabel.text = dict[@"Type"];
        cell.thumbnailImageView.image = [UIImage imageNamed:@"default"];
        cell.locationLabel.text = dict[@"Location"];
        
        //loading image from url async
        NSURL* url = [[NSURL alloc]initWithString:dict[@"Image"]];
        NSData* data = [imageCache objectForKey:dict[@"Id"]];
        if (data != nil) {
            cell.thumbnailImageView.image = [UIImage imageWithData:data];
        }else{
            NSURLRequest* request = [[NSURLRequest alloc]initWithURL:url];
            
            //send request async
            [NSURLConnection sendAsynchronousRequest:request queue:thumbQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                if(connectionError != nil){
                    NSLog(@"%@",connectionError);
                }else{
                    UIImage* image = [[UIImage alloc]initWithData:data];
                    //update ui
                    dispatch_async(dispatch_get_main_queue(), ^{
                        cell.thumbnailImageView.image = image;
                        [imageCache setObject:data forKey:dict[@"Id"]];
                    });
                }
            }];
        }
        //if the restaurant is visited,it will show a mark on row.
        if([[dict objectForKey:@"IsVisited"]intValue] == 1){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    return cell;
}

- (void)getDataSourceAsync
{
    //define a request
    NSURL* nsUrl = [[NSURL alloc] initWithString:APIURL];
    NSURLRequest* request = [[NSURLRequest alloc]initWithURL:nsUrl];
    NSOperationQueue* queue = [[NSOperationQueue alloc]init];
    //get data from webapi async
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(connectionError != nil){
            //deal with http error
            NSLog(@"%@",connectionError);
            dispatch_async(dispatch_get_main_queue(), ^{
                // error handle
            });
        }else{
            //deserialize json
            NSArray* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            //run main queue to update ui
            dispatch_async(dispatch_get_main_queue(), ^{
                restaurants = json;
                [self.tableView reloadData];
                [self.spinner stopAnimating];
                [self.refreshControl endRefreshing];
            });
        }
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //navigate to detial view
    UINavigationController* controller = [[UINavigationController alloc]init];
    AddTableViewController* addViewController = [[AddTableViewController alloc]init];
    addViewController.hidesBottomBarWhenPushed = YES;
    NSDictionary* selectedItem = [restaurants objectAtIndex:indexPath.row];
    addViewController.dictRestaurant = selectedItem;
    CustomTableViewCell* selectedCell = (CustomTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    addViewController.imageData = UIImagePNGRepresentation(selectedCell.thumbnailImageView.image);
    controller.viewControllers = @[addViewController];
    [self.navigationController presentViewController:controller animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110.0;
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
