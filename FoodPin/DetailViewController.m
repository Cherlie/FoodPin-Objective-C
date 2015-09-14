//
//  DetailViewController.m
//  FoodPin
//
//  Created by uappx.cn on 15/9/6.
//  Copyright (c) 2015年 梅须白. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailTableViewCell.h"
#import "ReviewViewController.h"
#import "ShareViewController.h"
#import "MapViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController{
    DetailTableViewCell* cell;
    UINib* nib;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
    self.imageView.image = [UIImage imageWithData:self.restaurant.image];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0 , self.view.bounds.size.width , self.view.bounds.size.width, self.view.bounds.size.height - self.view.bounds.size.width )];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //change the color of tableview
    self.tableView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:0.2];
    //change the color of separator
    self.tableView.separatorColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:0.8];
    //do not display footer view
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    //to solve the problem that fist view no disapper when navigating.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.tableView];
    [self initToolBar];
    
    self.title = self.restaurant.name;
    //Self Sizing Cells
    self.tableView.estimatedRowHeight = 36.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)initToolBar {
    //show tool bar
    self.toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 44)];
    UIBarButtonItem* actionButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionButtonClick)];
    UIBarButtonItem* composeButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeButtonClick)];
    UIBarButtonItem* flexible1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* flexible2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* flexible3 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [self.toolBar setItems:@[flexible1,actionButton,flexible2,composeButton,flexible3]];
    [self.view addSubview:self.toolBar];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellIdentifier = @"DetailCell";
    if (nib == nil) {
        nib = [UINib nibWithNibName:@"DetailTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
    }
    cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[DetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.mapButton.hidden = YES;
    
    switch (indexPath.row) {
        case 0:
            cell.fieldLabel.text = @"Name";
            cell.valueLabel.text = self.restaurant.name;
            break;
        case 1:
            cell.fieldLabel.text = @"Type";
            cell.valueLabel.text = self.restaurant.type;
            break;
        case 2:
            cell.fieldLabel.text = @"Location";
            cell.valueLabel.text = self.restaurant.location;
            cell.mapButton.hidden = NO;
            [cell.mapButton addTarget:self action:@selector(viewMap) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 3:
            cell.fieldLabel.text = @"Been here";
            cell.valueLabel.text = self.restaurant.isVisited.boolValue == YES ? @"Yes, I’ve been here before" : @"NO";
            break;
        default:
            cell.fieldLabel.text = @"";
            cell.valueLabel.text = @"";
            break;
    }

    return cell;
}

- (void)actionButtonClick{
    ShareViewController* shareViewController = [[ShareViewController alloc]init];
    [self.navigationController presentViewController:shareViewController animated:YES completion:nil];
}

- (void)composeButtonClick{
    ReviewViewController* reviewerViewController = [[ReviewViewController alloc]init];
    [self.navigationController presentViewController:reviewerViewController animated:YES completion:nil];
}

- (void)viewMap{
    MapViewController* mapViewController = [[MapViewController alloc]init];
    mapViewController.restaurant = self.restaurant;
    [self.navigationController pushViewController:mapViewController animated:YES];
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        return 70;
    }
    return 45;
}
 */

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
