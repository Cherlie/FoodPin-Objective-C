//
//  AddTableViewController.h
//  FoodPin
//
//  Created by uappx.cn on 15/9/12.
//  Copyright (c) 2015年 梅须白. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Restaurant.h"

@interface AddTableViewController : UITableViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak,nonatomic)IBOutlet UITableViewCell* imageCell;
@property (weak,nonatomic)IBOutlet UITableViewCell* nameCell;
@property (weak,nonatomic)IBOutlet UITableViewCell* typeCell;
@property (weak,nonatomic)IBOutlet UITableViewCell* locationCell;
@property (weak,nonatomic)IBOutlet UITableViewCell* isVisitedCell;

@property (weak,nonatomic)IBOutlet UIImageView* imageView;
@property (weak,nonatomic)IBOutlet UITextField* nameTextField;
@property (weak,nonatomic)IBOutlet UITextField* typeTextField;
@property (weak,nonatomic)IBOutlet UITextField* locationTextField;
@property (weak,nonatomic)IBOutlet UIButton* yesButton;
@property (weak,nonatomic)IBOutlet UIButton* noButton;

@property (strong,nonatomic)Restaurant* restaurant;

@property (strong,nonatomic)NSDictionary* dictRestaurant;
@property (strong,nonatomic)NSData* imageData;

- (IBAction)yesButtonClick:(id)sender;
- (IBAction)noButtonClick:(id)sender;

@end
