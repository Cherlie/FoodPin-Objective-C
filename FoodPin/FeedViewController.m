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
    self.spinner = [[UIActivityIndicatorView alloc]initWithFrame:CGRectZero];
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
        cell.thumbnailImageView.image = [UIImage imageNamed:@"camera"];
        cell.locationLabel.text = dict[@"Location"];
        
        //loading image from url async
        NSURL* url = [[NSURL alloc]initWithString:dict[@"Image"]];
        NSURL* cacheURL = [imageCache objectForKey:dict[@"Id"]];
        if (cacheURL != nil) {
            cell.thumbnailImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:cacheURL]];
        }else{
            NSURLRequest* request = [[NSURLRequest alloc]initWithURL:url];
            //send request async
            
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionTask* downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if(error != nil){
                    NSLog(@"%@",error);
                }else{
                    //move tmp file to document path
                    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
                    NSURL* documentsDirectoryURL = [NSURL fileURLWithPath:documentsPath];
                    NSURL* newFileLocation = [documentsDirectoryURL URLByAppendingPathComponent:[[response URL]lastPathComponent]];
                    [[NSFileManager defaultManager]copyItemAtURL:location toURL:newFileLocation error:nil];
                    
                    NSData* data = [NSData dataWithContentsOfURL:location];
                    UIImage* image = [UIImage imageWithData:data];
                    //update ui
                    dispatch_async(dispatch_get_main_queue(), ^{
                        cell.thumbnailImageView.image = image;
                        [imageCache setObject:newFileLocation forKey:dict[@"Id"]];
                    });
                }
            }];
            [downloadTask resume];
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
    //NSOperationQueue* queue = [[NSOperationQueue alloc]init];
    //get data from webapi async
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error != nil){
            //deal with http error
            NSLog(@"%@",error);
            dispatch_async(dispatch_get_main_queue(), ^{
                // error handle
            });
        }else{
            //deserialize json
            NSArray* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            //run main queue to update ui
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([json isKindOfClass:[NSArray class]]) {
                    restaurants = json;
                    [self.tableView reloadData];
                    [self.spinner stopAnimating];
                    [self.refreshControl endRefreshing];
                }
            });
        }
    }];
    [dataTask resume];
    //[NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
 
    //}];
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
